seed:
	dbt seed
	dbt seed --target prod

run:
	dbt run
	metaplane import-dbt-run  \
		--connection-id 2861a224-0270-4715-a681-40bcd260f87a \
		--project-name dbt-jaffleshop \
		--job-name jaffle-run-dev \
		--manifest ./target/manifest.json \
		--run-results ./target/run_results.json
		dbt run --target prod
	metaplane import-dbt-run  \
		--connection-id 2861a224-0270-4715-a681-40bcd260f87a \
		--project-name dbt-jaffleshop \
		--job-name jaffle-run-prod \
		--manifest ./target/manifest.json \
		--run-results ./target/run_results.json
