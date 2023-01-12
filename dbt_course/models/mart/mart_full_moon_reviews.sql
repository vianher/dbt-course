{{ config(
  materialized = 'table',
) }}
WITH fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
),
full_moon_dates AS (
    SELECT * FROM {{ ref('seed_full_moon_dates') }}
)
SELECT fct_reviews.*,
CASE
    WHEN full_moon_dates.full_moon_date IS NULL THEN 'not full moon'
    ELSE 'full moon'
  END AS is_full_moon
FROM
  fct_reviews
  LEFT JOIN full_moon_dates
  ON (TO_DATE(fct_reviews.review_date) = DATEADD(DAY, 1, full_moon_dates.full_moon_date))