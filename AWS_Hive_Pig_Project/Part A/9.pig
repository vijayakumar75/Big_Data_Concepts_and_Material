Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE $16 AS time,(double)$10 AS windSpeed;


weather_data_filtered1 = FILTER weather_data BY windSpeed > .1;


Register 'udf9.py' using streaming_python as myfuncs;

A = FOREACH weather_data_filtered1 GENERATE myfuncs.polirevVal(time) as hour, windSpeed AS speed;

B = GROUP A by hour;

C= FOREACH B GENERATE group as hour,AVG(A.speed) as Total;

sorted = ORDER C BY Total ASC;

dump sorted;
/*
lim = LIMIT sorted 1;

dump lim;



*/