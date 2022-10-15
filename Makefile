load_data:
	docker compose run --rm dev sh -c "cd load && python discord.py"

extract_discord:
	docker compose run --rm dev sh -c "cd extract/scripts && python discord.py"

transform_data: load_data
	docker compose run --rm dbt sh -c "dbt seed && dbt run && dbt test"

dbt_seed:
	docker compose run --rm dbt sh -c "dbt seed"

run_jupyter:
	docker compose up jupyter --build
