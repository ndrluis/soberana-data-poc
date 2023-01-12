{{ config(materialized='table') }}

WITH members_by_hour_and_weekday AS (
  SELECT week_name
        ,hour_interval
        ,AVG(approximate_presence_count)::int  AS avg_members
  FROM {{ ref('discord_members') }}
  GROUP BY 1, 2
)

SELECT *
FROM members_by_hour_and_weekday mw
