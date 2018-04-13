Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
A = FOREACH Weather GENERATE (int)$0 AS year,(int)$1 AS month,(int)$2 AS day, (double)$7 AS bpressure;


A = FILTER A BY bpressure > 0;


group_by_day = GROUP A BY (year,month,day);




d = FOREACH group_by_day GENERATE group as  day, A.bpressure as barPressure;


e = FOREACH d GENERATE day, MIN(barPressure.bpressure) as lowest;

sorted = ORDER e BY lowest ASC;

lim = LIMIT sorted 1;

dump lim;


f = FOREACH d GENERATE day, MAX(barPressure.bpressure) as highest;

sorted1 = ORDER f BY highest DESC;

lim1 = LIMIT sorted1 1;



unioned_temp = UNION lim, lim1;

dump unioned_temp;





