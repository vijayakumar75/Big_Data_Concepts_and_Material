Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
A = FOREACH Weather GENERATE (int)$0 AS year, (int)$1 AS month, (int)$2 AS day, (int)$8 AS visbilty,(double)$10 AS windSpeed;


group_by_day = GROUP A BY (year,month,day);

d = FOREACH group_by_day GENERATE group as  day, A.visbilty as vis, A.windSpeed as speed;

e = FILTER d  BY MIN(vis.visbilty) >= 9 AND MAX(speed.windSpeed) < 15;

f = FOREACH e GENERATE $0;





group_all = GROUP f ALL;

cnt = FOREACH group_all GENERATE COUNT(f);

dump cnt;


/*

lim = LIMIT d 3;

dump lim;

describe d;














filtered = FILTER weather_data BY NOT(windSpeed > 15);

filterd_data = FILTER filtered BY visbilty >= 9 AND windSpeed < 15;


group_by_day = GROUP filterd_data BY (year,month,day);


f = FOREACH group_by_day GENERATE group as day;



group_all = GROUP f ALL;

cnt = FOREACH group_all GENERATE COUNT(f);


dump cnt;
DESCRIBE cnt;
DESCRIBE group_all;



num_cnt = FOREACH f GENERATE COUNT(f.day) as cnt;

dump num_cnt;
g = FOREACH group_by_day GENERATE group,$1 AS visbilty,$2 AS speed;

lim = LIMIT g 100;

dump lim;
*/