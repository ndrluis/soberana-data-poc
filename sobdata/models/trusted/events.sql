{{ config(materialized='table') }}

SELECT CAST(event_name AS VARCHAR)
      ,CAST(occurred_at AS TIMESTAMP)
      ,CAST(kind AS VARCHAR)
FROM {{ source('public', 'events_log') }}
