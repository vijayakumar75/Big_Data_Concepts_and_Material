batters = LOAD 'hdfs:/home/hduser/pigTest1/Batting.csv' using PigStorage(',');
batting_batters = FILTER batters BY $1>0;

batting_data = FOREACH batting_batters GENERATE $0 AS id, (int)$5 AS AB,(int)$7 AS H;


batters_fielding = LOAD 'hdfs:/home/hduser/pigTest1/Fielding.csv' using PigStorage(',');
fielding_batters = FILTER batters_fielding BY $1>0;
fielding_batters_years = FILTER fielding_batters BY $1 >= 2005 AND $1 <= 2009;

fielding_data = FOREACH fielding_batters_years GENERATE $0 AS id, (int)$5 AS G,(int)$10 AS E;


cleaned_batting_data = FILTER batting_data BY AB >= 40;
cleaned_fielding_data = FILTER fielding_data BY G >= 20;


B = GROUP cleaned_batting_data BY id;
C = FOREACH B GENERATE group as id,
              SUM(cleaned_batting_data.AB) as AB,
              SUM(cleaned_batting_data.H) as H;
 



E = GROUP cleaned_fielding_data BY id;
F = FOREACH E GENERATE group as id,
              SUM(cleaned_fielding_data.G) as G,
              SUM(cleaned_fielding_data.E) as E;




join_data = JOIN C BY id, F BY id;




DESCRIBE join_data

j_data = FOREACH join_data GENERATE $0 AS id, (float)$1 AS AB, (float)$2 AS H, (float)$4 AS G , (float)$5 AS E;


Register 'baseball_6UDF.py' using streaming_python as myfuncs;

answer = FOREACH j_data GENERATE id, myfuncs.polirevVal(AB, H, G,E) AS Criteria;



sorted = ORDER answer BY Criteria DESC;

lim = LIMIT sorted 3;
dump lim


/*
ANSWER OUTOUT
			  
(suzukic01,0.30762276)		  
(hoppeno01,0.3053995)	
(walkela01,0.300678)	  


((player id, Criteria_score) lowest score(h/ab))
			  
*/	




