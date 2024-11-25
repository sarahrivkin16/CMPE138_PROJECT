-- Generate a list of all months from July 2019 to July 2024 and join with actual data
WITH expected_months AS (
  SELECT
    FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP(DATE_ADD('2019-07-01', INTERVAL n MONTH))) AS month_year
  FROM
    UNNEST(GENERATE_ARRAY(0, 60)) AS n -- Generate 60 months starting from July 2019
)
SELECT
  e.month_year, -- All months, including those without data
  d.city_name,
  d.state_name,
  AVG(d.aqi) AS avg_monthly_aqi -- Average AQI for months with data
FROM
  expected_months e
LEFT JOIN
  `bigquery-public-data.epa_historical_air_quality.pm25_frm_daily_summary` d
ON
  FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP(d.date_local)) = e.month_year
  AND d.city_name = "Los Angeles" -- Replace with your desired city
  AND d.state_name = "California" -- Replace with your desired state
WHERE
  e.month_year BETWEEN "2019-07" AND "2024-07" -- Restrict to July 2019 to July 2024
GROUP BY
  e.month_year, d.city_name, d.state_name
ORDER BY
  e.month_year;

