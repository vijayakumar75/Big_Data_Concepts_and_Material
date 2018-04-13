Weather = LOAD 'hdfs:/home/hduser/final/Weather.csv' USING PigStorage(',');
weather_data = FOREACH Weather GENERATE (int)$0 AS Year, (int)$1 AS Month, (int)$2 AS Day, (double)$4 AS Temperature;

/*There is invalid data of -9999 degrees*/
filtered1 = FILTER weather_data BY Temperature < -9.9 AND Temperature > -100;
filtered2 = FILTER weather_data BY Temperature > 94.9;

low_temp = FOREACH (GROUP filtered1 BY (Year,Month,Day)) GENERATE group AS Date, COUNT(filtered1.Day);
high_temp = FOREACH (GROUP filtered2 BY (Year,Month,Day)) GENERATE group AS Date, COUNT(filtered2.Day);

/*
b = GROUP low_temp ALL;
c = FOREACH b GENERATE COUNT(low_temp.$0) as cnt;
dump c;
*/

x = GROUP high_temp ALL;
y = FOREACH x GENERATE COUNT(high_temp.$0) as cnt;
dump y;


