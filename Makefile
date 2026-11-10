.PHONY: db-up db-down db-dump db-schema-dump db-data-dump db-dump-and-exit db-schema-dump-and-exit db-data-dump-and-exit
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
	./scripts/container.sh compose \
	-p "$${DB_PROJECT:-rdr}" \
	down \
	-v \
	--remove-orphans \
	--rmi all

db-dump:
	@$(DB_COMPOSE) run --rm --no-deps -T --entrypoint bash db-dump -eo pipefail -c '\
		output="$(DB_DUMP_DIR)"; \
		mkdir -p "$$output"; \
		stage=$$(mktemp -d "$$output/.dump-XXXXXX"); \
		publishing=false; \
		cleanup() { \
			status=$$?; \
			if $$publishing && [ "$$status" -ne 0 ]; then \
				for file in data.dump schema.sql; do \
					if [ -f "$$stage/previous/$$file" ]; then \
						mv "$$stage/previous/$$file" "$$output/$$file"; \
					else rm -f "$$output/$$file"; fi; \
				done; \
			fi; \
			rm -rf "$$stage"; \
			return "$$status"; \
		}; \
		trap cleanup EXIT; \
		pg_dump --format=custom --file="$$stage/data.dump"; \
		pg_restore --list "$$stage/data.dump" > /dev/null; \
		pg_restore --schema-only --file="$$stage/schema.raw.sql" "$$stage/data.dump"; \
		sed "$$ { /^$$/d; }" "$$stage/schema.raw.sql" > "$$stage/schema.sql"; \
		mkdir "$$stage/previous"; \
		for file in data.dump schema.sql; do \
			if [ -f "$$output/$$file" ]; then cp -p "$$output/$$file" "$$stage/previous/$$file"; fi; \
		done; \
		publishing=true; \
		mv "$$stage/data.dump" "$$output/data.dump"; \
		mv "$$stage/schema.sql" "$$output/schema.sql"; \
		printf "Snapshot exported to %s\n" "$$output"'

# Keep the old commands as aliases; always export a matching archive/schema pair.
db-schema-dump db-data-dump: db-dump

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
	-p "$${DB_PROJECT:-rdr}" \
	run \
	--no-deps \
	--rm \
	--build \
	schemapy-docs

db-dump-and-exit: db-dump db-down

db-schema-dump-and-exit: db-schema-dump db-down

db-data-dump-and-exit: db-data-dump db-down

.PHONY: db-validate db-data-track

db-validate:
	$(DB_COMPOSE) run --build --rm --no-deps -T db-validate

db-data-track:
	./scripts/dvc.sh add db/data.dump
