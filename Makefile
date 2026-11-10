.PHONY: db-up db-down db-dump db-schema-dump db-data-dump db-dump-and-exit db-schema-dump-and-exit db-data-dump-and-exit
.PHONY: dvc dvc-build db-data-push db-data-pull

db-up:
	docker compose \
	-f containers/compose.yml \
	-p rdr \
	up \
	--build \
	--detach \
	db

db-down:
	docker compose \
	-f containers/compose.yml \
 	-p rdr \
 	down \
 	-v \
 	--remove-orphans \
 	--rmi all

db-dump:
	docker compose \
	-f containers/compose.yml \
	-p rdr \
	run \
	--remove-orphans \
    --build \
	db-dump

db-schema-dump:
	docker compose \
	-f containers/compose.yml \
	-p rdr \
	run \
	--remove-orphans \
	--build \
	db-dump --schema

db-data-dump:
	docker compose \
	-f containers/compose.yml \
	-p rdr \
	run \
	--remove-orphans \
	--build \
	db-dump --data

dvc:
	./scripts/dvc.sh $(DVC_ARGS)

dvc-build:
	docker compose --env-file /dev/null --project-name rdr-dvc \
		--file containers/compose.dvc.yml build --pull --no-cache dvc

db-data-push:
	./scripts/dvc.sh \
	push \
	-r ensreg-git-lfs

db-data-pull:
	./scripts/dvc.sh \
	pull

schemapy-docs:
	docker compose \
	-f containers/compose.yml \
	-p rdr \
	run \
	--remove-orphans \
	--build \
	schemapy-docs

db-dump-and-exit: db-dump db-down

db-schema-dump-and-exit: db-schema-dump db-down

db-data-dump-and-exit: db-data-dump db-down
