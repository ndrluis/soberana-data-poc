{{ config(materialized='table') }}

WITH coerced_types AS (
  SELECT _started_at::timestamptz AT TIME ZONE 'America/Sao_Paulo' as extracted_at
        ,CAST(approximate_member_count AS INTEGER)
        ,CAST(approximate_presence_count AS INTEGER)
  FROM {{ source('public', 'discord_data') }}
),

enriched_columns AS (
  SELECT *
        ,date_trunc('hour', extracted_at) AS hour_interval
        ,EXTRACT('ISODOW' FROM date_trunc('hour', extracted_at))::int AS isodow
  FROM coerced_types
)

SELECT *
FROM enriched_columns
