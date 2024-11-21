
-- Query to get the top 5 cities with the best air quality
SELECT 
  city_name, state_name, AVG(aqi) AS avg_aqi
FROM 
  bigquery-public-data.epa_historical_air_quality.pm25_frm_daily_summary
WHERE 
  aqi IS NOT NULL
GROUP BY 
  city_name, state_name
ORDER BY 
  avg_aqi ASC
LIMIT 
  10;