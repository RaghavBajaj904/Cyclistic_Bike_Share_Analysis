USE cyclistic_bike;

-- ==================================================
-- CYCLISTIC BIKE SHARE ANALYSIS
-- Business Question:
-- How do casual riders and annual members use Cyclistic differently?
-- ==================================================

-- 1. Overall ride distribution
SELECT member_casual, FORMAT(COUNT(*), 0) as num_of_rides,
ROUND((COUNT(*) / SUM(COUNT(*)) OVER ()) *100,2) as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY member_casual;

-- 2 Ride-duration difference
SELECT member_casual, ROUND(AVG(ride_length_mins),2) as Avg_ride_duration_in_mins
FROM cyclistic_bike_cleaned_dataset
GROUP BY member_casual;

-- 3. Weekday vs Weekend usage
SELECT day_type, member_casual,
FORMAT(COUNT(*),0) as num_of_rides, ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual))*100,2)
as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY day_type, member_casual
ORDER BY day_type;

-- 4. Day wise behaviour
SELECT day_of_week, member_casual,
FORMAT(COUNT(*),0) as num_of_rides,
ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual))*100,2) as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY day_of_week, member_casual
ORDER BY FIELD(
		 day_of_week,
		 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');

-- 5. Monthly Usage
SELECT month_name, member_casual,
FORMAT(COUNT(*),0) as num_of_rides, ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual))*100,2)
as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY month, month_name, member_casual
ORDER BY month;

-- 6. Hourly behavior
SELECT hour, member_casual,
FORMAT(COUNT(*),0) as num_of_rides,
ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual))*100,2) as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY hour, member_casual
ORDER BY hour;

-- 7. Seasonal behavior
SELECT season, member_casual,
FORMAT(COUNT(*),0) as num_of_rides,
ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual)) * 100,2) as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY season, member_casual
ORDER BY FIELD (season, 'Winter', 'Spring', 'Summer', 'Autumn');

-- 8. Bike-type preference
SELECT rideable_type, member_casual,
FORMAT(COUNT(*),0) as num_of_rides,
ROUND(COUNT(*) / (SUM(COUNT(*)) OVER (PARTITION BY member_casual)) * 100,2) as percentage_share
FROM cyclistic_bike_cleaned_dataset
GROUP BY member_casual, rideable_type
ORDER BY rideable_type;

-- 9. Top 10 Start Stations of Casual riders
SELECT start_station_id, start_station_name, FORMAT(COUNT(*),0) as num_of_rides
FROM cyclistic_bike_cleaned_dataset
WHERE start_station_name IS NOT NULL
AND TRIM(start_station_name) <> ''
AND member_casual = 'casual'
GROUP BY start_station_id, start_station_name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 10. Top 10 End Stations of Casual riders
SELECT end_station_id, end_station_name, FORMAT(COUNT(*),0) as num_of_rides
FROM cyclistic_bike_cleaned_dataset
WHERE end_station_name IS NOT NULL
AND TRIM(end_station_name) <> ''
AND member_casual = 'casual'
GROUP BY end_station_id, end_station_name
ORDER BY COUNT(*) DESC
LIMIT 10;
