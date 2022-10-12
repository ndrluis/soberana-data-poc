import pandas as pd
import requests

DISCORD_URL = "https://discord.com/api/v9/invites/UQZpTQbCT4?with_counts=true"

request = requests.get(DISCORD_URL)

data = request.json()

new_dataframe = pd.json_normalize(data, max_level=2)

old_dataframe = pd.read_parquet("../data/discord.parquet")

current_dataframe = pd.concat([new_dataframe, old_dataframe])

current_dataframe.to_parquet("../data/discord.parquet", compression="gzip")
