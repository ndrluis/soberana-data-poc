import pandas as pd
import requests

from datetime import datetime

DISCORD_URL = "https://discord.com/api/v9/invites/UQZpTQbCT4?with_counts=true"
STARTED_AT = datetime.now()

request = requests.get(DISCORD_URL)

data = request.json()

new_dataframe = pd.json_normalize(data, max_level=2)

new_dataframe["_started_at"] = STARTED_AT.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

old_dataframe = pd.read_parquet("../data/discord.parquet")

current_dataframe = pd.concat([new_dataframe, old_dataframe])

current_dataframe.to_parquet("../data/discord.parquet", compression="gzip")
