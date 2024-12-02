SELECT
  `city_name`,
  `state_name`,
  ROUND(AVG(`aqi`), 2) AS average_aqi
FROM
  `bigquery-public-data.epa_historical_air_quality.pm25_frm_daily_summary`
WHERE
  `state_name` = "California"
  AND `sample_duration` = "24 HOUR"
  AND `poc` = 1
  AND EXTRACT(YEAR FROM `date_local`) = 2021
GROUP BY
  `city_name`, `state_name`
ORDER BY
  average_aqi DESC
LIMIT 5;
