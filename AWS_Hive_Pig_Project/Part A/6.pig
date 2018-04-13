Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE $3 AS time, (double)$4 AS temp;


filtered1 = FILTER weather_data BY temp > -100;

group_by_time = GROUP filtered1 BY time;


f = FOREACH group_by_time GENERATE group as time1, AVG(filtered1.temp) as temp1;

/*coldest_hour = FOREACH f GENERATE time1 as hour, MIN(temp1);*/

sorted = ORDER f BY temp1 ASC;

lim = LIMIT sorted 30;

dump lim;