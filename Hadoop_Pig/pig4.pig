batters_fielding = LOAD 'hdfs:/home/hduser/pigTest1/Fielding.csv' using PigStorage(',');
fielding_batters = FILTER batters_fielding BY $1>0;
fielding_batters_2001 = FILTER fielding_batters BY $1 == 2001;

fielding_data = FOREACH fielding_batters_2001 GENERATE $1 AS id, $2 AS teamid,(int)$10 AS error;
sorted = ORDER fielding_data BY error DESC;
lim = LIMIT sorted 1;
dump lim

/*

(2001,SDN,27)

In the year 2001, teamid :SDN, made  27 errors it being the most that year.


*/