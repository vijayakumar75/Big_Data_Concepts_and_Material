batters_master= LOAD 'hdfs:/home/hduser/pigTest1/Master.csv' using PigStorage(',');
master_batters = FILTER batters_master BY $1>0;
master_data = FOREACH master_batters GENERATE $0 AS id,$16 AS weight;

group_by_weight = GROUP master_data BY weight;

most_common = FOREACH group_by_weight GENERATE group as weight,COUNT(master_data.id) as common_weight;

sorted = ORDER most_common BY common_weight DESC;
lim = LIMIT sorted 2;
dump lim

second_common = ORDER lim BY common_weight ASC;
second_lim = LIMIT second_common 1;

dump second_lim


/* ANSWER OUTPUT

(185,1591)

(weight,number of players who weight)
The second most common weight is 185, with 1591 players weighing that much.

*/