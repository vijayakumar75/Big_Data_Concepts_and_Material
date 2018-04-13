batters_master= LOAD 'hdfs:/home/hduser/pigTest1/Master.csv' using PigStorage(',');
master_batters = FILTER batters_master BY $1>0;
master_data = FOREACH master_batters GENERATE $0 AS playerId,(int)$2 AS bmonth,(int)$3 AS bday;

players = FOREACH master_data GENERATE playerId;
distinct_players = DISTINCT players;



join_data = JOIN master_data BY playerId, distinct_players BY playerId;

fin = FOREACH join_data GENERATE $1 AS month,$2 AS day, $3 AS playerId;


group_by_date = GROUP fin by (month,day);



cleaned = FOREACH group_by_date GENERATE group AS date, COUNT(fin.playerId) AS numPplSameBdays;


sorted = ORDER cleaned BY numPplSameBdays DESC;

filtered = FILTER sorted BY (date.month) IS NOT NULL;
filtered_2 = FILTER filtered BY (date.day) IS NOT NULL;


topThree = LIMIT filtered_2 3;



/* ANSWER OUTPUT
((11,18) , 75)
((8,15), 73)
((8,4), 71)


format(Month, day), count of how many birthdays)
*/







dump topThree;