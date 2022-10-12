{{ config(materialized='table') }}

SELECT CAST(interval_start_timestamp AS TIMESTAMP)
       ,CAST(total_membership AS INTEGER) AS members_count
FROM {{ source('public', 'discord_members_data') }}
