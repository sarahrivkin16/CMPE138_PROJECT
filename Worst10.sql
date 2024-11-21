
-- Query to get the top 10 cities with the worst air quality
SELECT 
  city_name, state_name, AVG(aqi) AS avg_aqi
FROM 
  bigquery-public-data.epa_historical_air_quality.pm25_frm_daily_summary
WHERE 
  aqi IS NOT NULL
GROUP BY 
  city_name, state_name
ORDER BY 
  avg_aqi DESC
LIMIT 
  10;