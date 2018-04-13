batters = LOAD 'hdfs:/home/hduser/pigTest1/Batting.csv' using PigStorage(',');
real_batters = FILTER batters BY $1>0;
run_data = FOREACH real_batters GENERATE $0 AS id,$8 AS dble, $9 AS tripple;



batters_master= LOAD 'hdfs:/home/hduser/pigTest1/Master.csv' using PigStorage(',');
master_batters = FILTER batters_master BY $1>0;
master_data = FOREACH master_batters GENERATE $0 AS id, $6 AS bCity, $5 AS bState;


join_data = JOIN master_data BY id, run_data BY id;

clean_data = FOREACH join_data GENERATE $1 AS city, $2 AS state, $3 AS id,
(int)$4 AS dble, (int)$5 AS tripple;



filtered = FILTER clean_data BY state IS NOT NULL;
filtered_2 = FILTER filtered BY city IS NOT NULL;


describe filtered_2;

clean = FOREACH filtered_2 GENERATE id,city,state, dble + tripple AS combined;

clean_group = GROUP clean BY (city,state);
counter = FOREACH clean_group GENERATE FLATTEN(group) as (city,state),SUM(clean.combined) as sum1;



top5Cities = ORDER counter BY sum1 DESC; 

lim = LIMIT top5Cities 5;

dump lim

/*

(Los Angeles, CA, 16214)
(Chicago, IL,14966)
(Philadelphia, PA, 13413)
(San Fransisco, CA, 12656)
(St. Louis, Mo, 12656)


City, State, Number of doubles and tripples

*/