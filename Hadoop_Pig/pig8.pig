batters_master= LOAD 'hdfs:/home/hduser/pigTest1/Master.csv' using PigStorage(',');
master_batters = FILTER batters_master BY $1>0;
master_data = FOREACH master_batters GENERATE $0 AS id, $2 AS bMonth, $5 AS bState;


master_data1 = FILTER master_data BY bMonth IS NOT NULL;
master_data2 = FILTER master_data1 BY bState IS NOT NULL;


batters = LOAD 'hdfs:/home/hduser/pigTest1/Batting.csv' using PigStorage(',');
batting_batters = FILTER batters BY $1>0;
batting_data = FOREACH batting_batters GENERATE $0 AS id, (int)$5 AS AB,(int)$7 AS H;


/*master_data*/

group_by_month_and_place = GROUP master_data2 BY (bMonth,bState);
Filtered = FILTER group_by_month_and_place BY COUNT(master_data2.bMonth) >= 3 AND COUNT(master_data2.bState) >= 3;



flattened = FOREACH Filtered GENERATE FLATTEN(master_data2);
result = FOREACH flattened GENERATE $0 AS id, $1 AS month, $2 AS state;
master_data_sorted1 = ORDER result BY id DESC;



 
group_by_id = GROUP batting_data BY id;
 
/*batting_data sums group of AB and H organized by id */
C = FOREACH group_by_id GENERATE group AS id,
              SUM(batting_data.AB) as AB,
              SUM(batting_data.H) as H;

	
batting_data_sorted = ORDER C BY id DESC;





join_data = JOIN master_data_sorted1 BY id, batting_data_sorted BY id;

generated_data = FOREACH join_data GENERATE $0 AS id, $1 AS month, $2 AS state, (int)$4 AS AB, (int)$5 AS H; 



s = ORDER generated_data BY id ASC;



final_group = GROUP s BY (month,state);

/*dump final_group*/


sum_of_scores = FOREACH final_group GENERATE group AS id,
				SUM(s.AB) AS AB,
				SUM(s.H) AS H;

				
final_final = FOREACH sum_of_scores GENERATE $0 AS month_state, (float)$1 AS AB, (float)$2 AS H;

/*dump final_final*/

out_put = FOREACH final_final GENERATE month_state, (float)(H / AB) AS score; 

sorted = ORDER out_put BY score ASC;

sorted_filter = FILTER sorted BY score  != 0;


lim = LIMIT sorted_filter 5;
dump lim






/*
ANSWER OUTOUT
			  
((1,Sanchez Ramirez), 0.07317073)
((4,Tokyo),0.07692308)
((10, San Cristobal), 0.07936508)
((9, Duarte), 0.08695652)			  
((12,La Vega),0.08983452)			  
			  
((Month, State) lowest score(h/ab))
			  
*/	


