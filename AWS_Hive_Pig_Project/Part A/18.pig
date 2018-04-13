Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE (double)$11 AS gust, $9 as dirc , $14 as condition;


filtered1 = FILTER weather_data BY gust > 30;

A = FOREACH filtered1 GENERATE $0 as gust ,$1 as direction,$2 as condition;

group_1 = GROUP A BY (direction,condition);


B = FOREACH group_1 GENERATE group as comb, COUNT(A.gust) as cnt;


sorted = ORDER B by cnt DESC;

lim = LIMIT sorted 3;
dump lim;