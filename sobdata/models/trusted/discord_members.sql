{{ config(materialized='table') }}

SELECT _started_at::timestamptz AT TIME ZONE 'America/Sao_Paulo' as extracted_at
      ,CAST(approximate_member_count AS INTEGER)
      ,CAST(approximate_presence_count AS INTEGER)
FROM {{ source('public', 'discord_data') }}
