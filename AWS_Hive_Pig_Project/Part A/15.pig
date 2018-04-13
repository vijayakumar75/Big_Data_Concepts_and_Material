Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE (int)$6 AS humidity;


filtered1 = FILTER weather_data BY humidity > 1;

A = FOREACH filtered1 GENERATE $0 as humd;

group_1 = GROUP A BY humd;

B = FOREACH group_1 GENERATE group as humdity1, COUNT(A.humd) as cnt;


sorted = ORDER B by cnt ASC;

lim = LIMIT sorted 3;

dump lim;