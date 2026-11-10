.PHONY: db-up db-down db-dump db-schema-dump db-data-dump db-dump-and-exit db-schema-dump-and-exit db-data-dump-and-exit
.PHONY: dvc dvc-build db-data-push db-data-pull

db-up:
	./scripts/container.sh compose \
	-p rdr \
	up \
	--build \
	--detach \
	db

db-down:
	./scripts/container.sh compose \
 	-p rdr \
 	down \
 	-v \
 	--remove-orphans \
 	--rmi all

db-dump:
	./scripts/container.sh compose \
	-p rdr \
	run \
	--rm \
    --build \
	db-dump

db-schema-dump:
	./scripts/container.sh compose \
	-p rdr \
	run \
	--rm \
	--build \
	db-dump --schema

db-data-dump:
	./scripts/container.sh compose \
	-p rdr \
	run \
	--rm \
	--build \
	db-dump --data

dvc:
	./scripts/dvc.sh $(DVC_ARGS)

dvc-build:
	./scripts/container.sh dvc-compose build --pull --no-cache dvc

db-data-push:
	./scripts/dvc.sh \
	push \
	-r ensreg-git-lfs

db-data-pull:
	./scripts/dvc.sh \
	pull

schemapy-docs:
	./scripts/container.sh compose \
	-p rdr \
	run \
	--rm \
	--build \
	schemapy-docs

db-dump-and-exit: db-dump db-down

db-schema-dump-and-exit: db-schema-dump db-down

db-data-dump-and-exit: db-data-dump db-down
