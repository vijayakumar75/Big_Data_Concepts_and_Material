Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE (int)$0 AS year,(int)$1 AS month,(int)$2 AS day, (double)$4 AS temperature;

weather_data_filtered1 = FILTER weather_data BY temperature > -100;


filtered1 = FOREACH (GROUP weather_data_filtered1 BY (year,month,day)) GENERATE group AS day, MAX(weather_data_filtered1.temperature) - MIN(weather_data_filtered1.temperature) AS yo;
 


sorted = ORDER filtered1 BY yo DESC;

lim = LIMIT sorted 30;

dump lim;