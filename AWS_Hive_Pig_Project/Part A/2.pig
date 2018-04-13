Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE (int)$1 AS Month, (double)$4 AS Temperature;

filtered1 = FOREACH (GROUP weather_data BY Month) GENERATE group AS month, AVG(weather_data.Temperature);

sorted = ORDER filtered1 BY month DESC;

lim = LIMIT sorted 30;

dump lim;


/*
winds = FOREACH Weather GENERATE $9 AS w_dir;

distint_wind_dir = DISTINCT winds;




group_by_direction= GROUP weather_data BY distint_wind_dir);

lim = LIMIT group_by_direction 2;

dump lim;

DESCRIBE group_by_direction;
*/


/*
SELECT a.bcity,a.id, b.ab FROM master a 
JOIN
(SELECT id, SUM(ab) as ab FROM batting
GROUP by id) b
ON a.id = b.id
ORDER by b.ab DESC
limit 1;
*/