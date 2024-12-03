SELECT
  COUNT(date_local) AS NUM_OF_DAYS,
  CASE
    WHEN aqi < 51 THEN "Good (green)"
    WHEN aqi <101 THEN "Moderate (yellow)"
    WHEN aqi <151 THEN "Unhealthy for sensitive groups (orange)"
    WHEN aqi <201 THEN "Unhealthy (red)"
    WHEN aqi <301 THEN "Very unhealthy (purple)"
    WHEN aqi <501 THEN "Hazardous (maroon)"
    ELSE "unexpected data"
  END AS AQ_RATING
FROM
  `bigquery-public-data.epa_historical_air_quality.pm25_frm_daily_summary`
WHERE
  city_name = "Fresno"
  AND state_name = "California"
  AND sample_duration = "24 HOUR"
  AND poc = 1
  AND EXTRACT(YEAR FROM date_local) = 2020
GROUP BY
  2
ORDER BY
  1 DESC
