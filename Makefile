seed:
	dbt seed
	dbt seed --target prod

run:
	dbt run
	metaplane import-dbt-run  \
		--connection-id d1483bb6-8c8a-41cb-a0db-f85eaf80868b \
		--project-name dbt-jaffleshop \
		--job-name dbt-run-dev \
		--manifest ./target/manifest.json \
		--run-results ./target/run_results.json
	dbt run --target prod
	metaplane import-dbt-run  \
		--connection-id d1483bb6-8c8a-41cb-a0db-f85eaf80868b \
		--project-name dbt-jaffleshop \
		--job-name dbt-run-prod \
		--manifest ./target/manifest.json \
		--run-results ./target/run_results.json
