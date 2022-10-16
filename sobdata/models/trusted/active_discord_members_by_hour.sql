{{ config(materialized='table') }}

WITH members_by_hour_and_weekday AS (
  SELECT isodow
        ,hour_interval
        ,AVG(approximate_presence_count)::int  AS avg_members
  FROM {{ ref('discord_members') }}
  GROUP BY 1, 2
)

SELECT dw.name as week_name
      ,hour_interval
      ,mw.avg_members
FROM members_by_hour_and_weekday mw
JOIN {{ ref('day_of_the_week') }} dw ON mw.isodow = dw.isodow
