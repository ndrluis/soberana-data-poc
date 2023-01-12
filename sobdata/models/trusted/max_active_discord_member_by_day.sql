{{ config(materialized='table') }}

WITH max_members_by_day AS (
  SELECT week_name
        ,date_trunc('day', extracted_at) AS day
        ,MAX(approximate_presence_count)::int  AS max_members
  FROM {{ ref('discord_members') }}
  GROUP BY 1, 2
)

SELECT *
FROM max_members_by_day
