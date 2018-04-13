batters = LOAD 'hdfs:/home/hduser/pigTest1/Batting.csv' using PigStorage(',');
realbatters = FILTER batters BY $1>0;
run_data = FOREACH realbatters GENERATE $0 AS id, (int)$5 AS bats;



batters_master= LOAD 'hdfs:/home/hduser/pigTest1/Master.csv' using PigStorage(',');
master_batters = FILTER batters_master BY $1>0;
master_data = FOREACH master_batters GENERATE $0 AS id,$6 AS birthCity;


sorted = ORDER run_data BY bats DESC ;
lim = LIMIT sorted 1;

join_data = JOIN lim BY id,master_data BY id;
finished = FOREACH join_data GENERATE $0 AS id, $1 AS bats, $3 AS city;

finalSort = ORDER finished by bats DESC;
DUMP finalSort

/* ANSWER OUTPUT


(rolliji01,716,Utica)

(id, AB, City)
Id and bats(AB) and city spited out by finalSort

*/




