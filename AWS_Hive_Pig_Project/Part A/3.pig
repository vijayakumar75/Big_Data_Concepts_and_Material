Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE $16 AS Date, $9 AS w_direction;


wd = FOREACH weather_data GENERATE $1 AS w_direction;
gwd = GROUP wd BY w_direction;
cwd = FOREACH gwd GENERATE group as wd,COUNT(wd.$0);
owd = ORDER cwd BY $1 DESC;
mwd  = LIMIT owd 1;
DUMP mwd;




