.PHONY: db-up db-down db-dump db-schema-dump db-data-dump db-dump-and-exit db-schema-dump-and-exit db-data-dump-and-exit

db-up:
	docker compose \
	-f compose.yml \
	-p rdr \
	up \
	--build \
	--detach \
	db

db-down:
	docker compose \
 	-p rdr \
 	down \
 	-v \
 	--remove-orphans \
 	--rmi all

db-dump:
	docker compose \
	-p rdr \
	run \
	--remove-orphans \
    --build \
	db-dump

db-schema-dump:
	docker compose \
	-p rdr \
	run \
	--remove-orphans \
	--build \
	db-dump --schema

db-data-dump:
	docker compose \
	-p rdr \
	run \
	--remove-orphans \
	--build \
	db-dump --data

db-data-push:
	dvc \
	push \
	-r regulation-s3

db-data-pull:
	dvc \
	pull

schemapy-docs:
	docker compose \
	-p rdr \
	run \
	--remove-orphans \
	--build \
	schemapy-docs

db-dump-and-exit: db-dump db-down

db-schema-dump-and-exit: db-schema-dump db-down

db-data-dump-and-exit: db-data-dump db-down
