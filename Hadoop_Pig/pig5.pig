batters_fielding = LOAD 'hdfs:/home/hduser/pigTest1/Fielding.csv' using PigStorage(',');
fielding_batters = FILTER batters_fielding BY $1>0;

fielding_data = FOREACH fielding_batters GENERATE $0 AS id, (int)$10 AS error;
group_by_id = GROUP fielding_data BY id;


cleaned_data = FOREACH group_by_id GENERATE group AS id, SUM(fielding_data.error) AS numErrors;

sorted = ORDER cleaned_data BY numErrors DESC;
lim = LIMIT sorted 1;
dump lim

/*
ANSWER OUTPUT

(longhe01,1096)

Id displayed and the person with the most errors for all seasons combined

*/