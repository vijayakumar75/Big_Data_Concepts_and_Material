Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE (int)$1 AS month,  (double)$4 AS temp, $16 AS time;


weather_data_filtered1 = FILTER weather_data BY temp >= 49.5 AND temp <= 51.5;


Register 'udf9.py' using streaming_python as myfuncs;

A = FOREACH weather_data_filtered1 GENERATE month, temp, myfuncs.polirevVal(time) as hour;


B = GROUP A BY (month, hour);

C= FOREACH B GENERATE group as time,COUNT(A.temp) as cnt;


Describe C;


X = GROUP C By time;

Y = FOREACH X GENERATE group, MAX(C.cnt) as mcount;




flat = FOREACH Y GENERATE FLATTEN(group), mcount;

new = FOREACH flat GENERATE $0 AS month, $1 AS hour, $2 AS cnt; 





Z = GROUP new by month;
DESCRIBE Z;

final = FOREACH Z GENERATE group, new.hour, MAX(new.cnt);

DUMP final;
