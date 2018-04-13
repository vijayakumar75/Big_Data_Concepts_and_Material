Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE $1 AS month, (double)$12 AS prec;

filter_NA = FILTER weather_data BY prec > 0.0;
d = FOREACH filter_NA GENERATE $0 AS month, $1 AS prec;

group_by_month = GROUP d BY month;

sum_of_prec_by_month = FOREACH group_by_month GENERATE group as month, SUM(d.prec) as sum1;

top_month =  ORDER sum_of_prec_by_month BY sum1 DESC;

sorted = LIMIT top_month 1;

dump sorted;