WITH yearly_data AS (
  SELECT
    EXTRACT(YEAR FROM `date_local`) AS year,
    `city_name`,
    `state_name`,
    `aqi`,
    `arithmetic_mean`,
    `sample_duration`,
    `poc`
  FROM
    `bigquery-public-data.epa_historical_air_quality.pm25_frm_daily_summary`
  WHERE
    `city_name` = "San Jose" -- Filter for San Jose
    AND `state_name` = "California" -- Filter for California
    AND `sample_duration` = "24 HOUR" -- Filter for 24-hour samples
    AND `poc` = 1 -- Parameter occurrence code filter
    AND `date_local` BETWEEN '2015-01-01' AND '2019-12-31' -- Extended range
    AND aqi IS NOT NULL -- Exclude null AQI values
)
SELECT
  year,                    -- Year of the AQI data
  city_name,               -- City name
  state_name,              -- State name
  COUNT(aqi) AS aqi_count, -- Count of valid AQI values
  ROUND(AVG(aqi), 2) AS avg_aqi, -- Average AQI for the year
  MIN(aqi) AS min_aqi,     -- Minimum AQI value
  MAX(aqi) AS max_aqi      -- Maximum AQI value
FROM
  yearly_data
GROUP BY
  year, city_name, state_name
ORDER BY
  year, avg_aqi DESC; -- Sort by year and descending average AQI
