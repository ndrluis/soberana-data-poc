{{ config(materialized='table') }}

SELECT CAST(_started_at AS TIMESTAMP) as extracted_at
      ,CAST(approximate_member_count AS INTEGER)
      ,CAST(approximate_presence_count AS INTEGER)
FROM {{ source('public', 'discord_data') }}
