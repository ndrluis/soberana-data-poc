import sqlalchemy
import pandas as pd
import numpy as np
import json
from psycopg2.extensions import register_adapter, AsIs


def addapt_numpy_float64(numpy_float64):
    return AsIs(numpy_float64)


def addapt_numpy_int64(numpy_int64):
    return AsIs(numpy_int64)


def addapt_numpy_float32(numpy_float32):
    return AsIs(numpy_float32)


def addapt_numpy_int32(numpy_int32):
    return AsIs(numpy_int32)


def addapt_numpy_array(numpy_array):
    return AsIs(tuple(numpy_array))


register_adapter(np.float64, addapt_numpy_float64)
register_adapter(np.int64, addapt_numpy_int64)
register_adapter(np.float32, addapt_numpy_float32)
register_adapter(np.int32, addapt_numpy_int32)
register_adapter(np.ndarray, addapt_numpy_array)

df = pd.read_parquet("../extract/data/discord.parquet")

engine = sqlalchemy.create_engine("postgresql://postgres:@postgres:5432/soberana_data")

df = df[df["message"] != "You are being rate limited."]

df.loc[:, "guild.welcome_screen.welcome_channels"] = df[
    "guild.welcome_screen.welcome_channels"
].apply(lambda x: json.dumps(list(x)))

with engine.connect() as conn:
    df.to_sql(
        "discord_data",
        con=conn,
        schema="public",
        if_exists="replace",
        index=False,
        dtype={"guild.welcome_screen.welcome_channels": sqlalchemy.types.JSON},
    )
