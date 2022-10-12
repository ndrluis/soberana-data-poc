load_data:
	docker compose run --rm dev sh -c "cd load && python discord.py"

extract_discord:
	docker compose run --rm dev sh -c "cd extract/scripts && python discord.py"
