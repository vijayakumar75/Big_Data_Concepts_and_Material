Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
A = FOREACH Weather GENERATE (int)$0 AS year, (int)$1 AS month, (int)$2 AS day, (int)$4 AS temp, (chararray)$14 AS cond, (double)$5 as dewpoint , (double)$10 as wind;


group_by_day = GROUP A BY (year,month,day);

d = FOREACH group_by_day GENERATE group as day, A.temp as temperature, A.cond as condition, A.dewpoint as dewPoint, A.wind as windSpeed;

e = FILTER d  BY MIN(temperature.temp) >= 60 AND MAX(temperature.temp) <= 79;

f = FILTER e BY MAX(dewPoint.dewpoint) < 60;

g = FILTER f BY MAX(windSpeed.wind) <= 10;




days = FOREACH g GENERATE $0;

dump days;

group_all = GROUP days ALL;

cnt = FOREACH group_all GENERATE COUNT(days);

dump cnt;


















/*

f = FOREACH group_by_day
	generate
		group as day,
		A.cond as condition,
		FLATTEN (group_by_day);
	


z = filter f by condition.cond == 'clear' OR condition.cond == 'partly cloudy';

dump z;




FILTER g BY condition.$0 == 'clear' OR condition.$0 == 'partly cloudy';

dump f;
*/








/*

f = FILTER e BY day.condition.cond == 'clear' OR day.condition.cond == 'partly cloudy';
lim = LIMIT f 3;

dump lim;
f = FOREACH e GENERATE $0, $1;

dump f;
*/
