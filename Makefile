.PHONY: db-up db-down db-dump
.PHONY: dvc dvc-build db-data-push db-data-pull

DB_PROJECT ?= rdr
DB_START_TIMEOUT ?= 120
DB_DUMP_DIR ?= /db
DB_COMPOSE = ./scripts/container.sh compose --project-name "$(DB_PROJECT)"

.PHONY: db-start db-wait db-info

# Separate recursive invocations preserve ordering even with make -j.
db-up: db-data-pull
	@$(MAKE) --no-print-directory db-start
	@$(MAKE) --no-print-directory db-wait
	@$(MAKE) --no-print-directory db-info

db-start:
	$(DB_COMPOSE) up --build --detach db

db-wait:
	@timeout="$(DB_START_TIMEOUT)"; \
	case "$$timeout" in \
		''|*[!0-9]*|0) printf 'DB_START_TIMEOUT must be a positive number of seconds.\n' >&2; exit 2 ;; \
	esac; \
	printf 'Waiting for PostgreSQL initialization (up to %s seconds)...\n' "$$timeout"; \
	elapsed=0; \
	until $(DB_COMPOSE) exec -T db sh -c \
		'pg_isready -h 127.0.0.1 -U "$$POSTGRES_USER" -d "$$POSTGRES_DB"' >/dev/null 2>&1; do \
		if [ "$$elapsed" -ge "$$timeout" ]; then \
			printf 'PostgreSQL did not become ready. Recent database logs:\n' >&2; \
			$(DB_COMPOSE) logs --tail 50 db >&2 || true; \
			exit 1; \
		fi; \
		sleep 1; \
		elapsed=$$((elapsed + 1)); \
	done

db-info:
	@address=$$($(DB_COMPOSE) port db 5432) || exit $$?; \
	case "$$address" in *:*) ;; *) address="127.0.0.1:$$address" ;; esac; \
	printf '\nRDR is ready.\nAddress: %s\n' "$$address"
	@$(DB_COMPOSE) exec -T db sh -c \
		'printf "Database: %s\nUser: %s\nPassword: %s\n" "$$POSTGRES_DB" "$$POSTGRES_USER" "$$POSTGRES_PASSWORD"'
	@printf '\nThis database is disposable. Run make db-dump before stopping it to save schema and data changes.\n'

db-down:
	$(DB_COMPOSE) down --volumes --remove-orphans

# Export once, then extract matching schema and data SQL files.
db-dump:
	@$(DB_COMPOSE) --profile tools run --rm --no-deps -T --entrypoint sh db-dump -ec '\
		stage=$$(mktemp -d "$(DB_DUMP_DIR)/.dump-XXXXXX"); \
		trap "rm -rf \"$$stage\"" EXIT; \
		pg_dump --format=custom --file="$$stage/snapshot.dump"; \
		pg_restore --schema-only --file="$$stage/schema.sql" "$$stage/snapshot.dump"; \
		pg_restore --data-only --file="$$stage/data.sql" "$$stage/snapshot.dump"; \
		mv "$$stage/schema.sql" "$$stage/data.sql" "$(DB_DUMP_DIR)/"; \
		printf "Schema and data exported to %s\n" "$(DB_DUMP_DIR)"'

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

.PHONY: schemaspy-docs

schemaspy-docs: db-wait
	DB_PROJECT="$(DB_PROJECT)" ./scripts/schemaspy.sh

.PHONY: db-validate db-data-track

db-validate:
	$(DB_COMPOSE) --profile tools run --build --rm --no-deps -T db-validate

db-data-track:
	./scripts/dvc.sh add db/data.sql
