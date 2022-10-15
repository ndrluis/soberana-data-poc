{{ config(materialized='table') }}

WITH members_by_hour AS (
  SELECT date_trunc('hour', extracted_at) AS hour
        ,AVG(approximate_presence_count) AS avg_presence
   FROM discord_members
   GROUP BY 1
),

members_by_hour_and_weekday AS (
  SELECT EXTRACT('ISODOW' FROM hour)::int AS isodow
        ,hour
        ,AVG(avg_presence)::int  AS avg_members
  FROM members_by_hour
  GROUP BY 1, 2
)

SELECT dw.name as week_name
      ,hour
      ,mw.avg_members
FROM members_by_hour_and_weekday mw
JOIN day_of_the_week dw ON mw.isodow = dw.isodow
