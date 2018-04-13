
SELECT *
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NULL
 AND "Supplier City" IS NULL
 AND "Supplier State" IS NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NULL
 AND "Consumer State" IS NULL
 AND "Product Name" IS NULL



SELECT *
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NOT NULL
 AND "Supplier City" IS NOT NULL
 AND "Supplier State" IS NOT NULL
 AND "Consumer Name" IS NOT NULL
 AND "Consumer City" IS NOT NULL
 AND "Consumer State" IS NOT NULL
 AND "Product Name" IS NOT NULL



/*1) Aggregates by combinations of supplier name and product name?*/   
SELECT *
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NOT NULL
 AND "Supplier City" IS NOT NULL
 AND "Supplier State" IS NOT NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NULL
 AND "Consumer State" IS NULL
 AND "Product Name" IS NOT NULL

 Supplier Name	Supplier City	Supplier State	Consumer Name	Consumer City	Consumer State	Product Name	Total Transactions Quantity	Number of Transactions
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Boat	311710	13
Stronger	Springfield	Illinois	NULL	NULL	NULL	Auto	100	1
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Milk	311710	13
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Computer	311710	13
Traiger	Chicago	Illinois	NULL	NULL	NULL	Orange	100	1
Stronger	Springfield	Illinois	NULL	NULL	NULL	Boat	100	1
Deitel	Stevens Point	Wisconsin	NULL	NULL	NULL	Auto	100	1
Traiger	Chicago	Illinois	NULL	NULL	NULL	Milk	10	1
Herman	Madison	Wisconsin	NULL	NULL	NULL	Milk	20000	2
Joe	Madison	Wisconsin	NULL	NULL	NULL	Airplane	300	3
Herman	Madison	Wisconsin	NULL	NULL	NULL	Gas	200000	2
Herman	Madison	Wisconsin	NULL	NULL	NULL	Orange	500	5
Deitel	Stevens Point	Wisconsin	NULL	NULL	NULL	Boat	100	1
Wolf	Wausau	Wisconsin	NULL	NULL	NULL	Orange	300	3
Herman	Madison	Wisconsin	NULL	NULL	NULL	Airplane	300	3
Joe	Madison	Wisconsin	NULL	NULL	NULL	Milk	20000	2
Joe	Madison	Wisconsin	NULL	NULL	NULL	Computer	500	5
Herman	Madison	Wisconsin	NULL	NULL	NULL	Boat	300000	3
Herman	Madison	Wisconsin	NULL	NULL	NULL	TV	3000	3
Joe	Madison	Wisconsin	NULL	NULL	NULL	Orange	500	5
Deitel	Stevens Point	Wisconsin	NULL	NULL	NULL	Milk	10	1
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	TV	311710	13
Herman	Madison	Wisconsin	NULL	NULL	NULL	Computer	500	5
Stronger	Springfield	Illinois	NULL	NULL	NULL	Milk	10	1
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Gas	311710	13
Joe	Madison	Wisconsin	NULL	NULL	NULL	Auto	40	4
Joe	Madison	Wisconsin	NULL	NULL	NULL	Boat	300000	3
Wolf	Wausau	Wisconsin	NULL	NULL	NULL	TV	1000	1
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Auto	311710	13
Wolf	Wausau	Wisconsin	NULL	NULL	NULL	Computer	300	3
Joe	Madison	Wisconsin	NULL	NULL	NULL	Gas	300000	3
Joe	Madison	Wisconsin	NULL	NULL	NULL	TV	4000	4
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Airplane	311710	13
Wolf	Wausau	Wisconsin	NULL	NULL	NULL	Gas	100100	2
Herman	Madison	Wisconsin	NULL	NULL	NULL	Auto	40	4
Bernstein	Madison	Wisconsin	NULL	NULL	NULL	Orange	311710	13
Wolf	Wausau	Wisconsin	NULL	NULL	NULL	Auto	110	2
Traiger	Chicago	Illinois	NULL	NULL	NULL	Auto	100	1
Wolf	Wausau	Wisconsin	NULL	NULL	NULL	Milk	10000	1




/*2) Aggregates by supplier states?*/

SELECT *
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NULL
 AND "Supplier City" IS NULL
 AND "Supplier State" IS NOT NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NULL
 AND "Consumer State" IS NULL
 AND "Product Name" IS NULL


 Supplier Name	Supplier City	Supplier State	Consumer Name	Consumer City	Consumer State	Product Name	Total Transactions Quantity	Number of Transactions
NULL	NULL	Illinois	NULL	NULL	NULL	NULL	420	6
NULL	NULL	Wisconsin	NULL	NULL	NULL	NULL	3755380	175




 /*3) Number of transactions between supplier-city-consumer-city pairs?*/

SELECT [Supplier City],[Consumer City], [Number of Transactions]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" IS NOT NULL
 AND "Supplier State" IS NOT NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NOT NULL
 AND "Consumer State" IS NOT NULL
 AND "Product Name"  IS NULL

 Supplier City	Consumer City	Number of Transactions
Chicago	Wausau	2
Wausau	Wausau	10
Madison	Chicago	24
Wausau	Lansing	2
Stevens Point	Wausau	2
Chicago	Lansing	1
Madison	Wausau	82
Stevens Point	Lansing	1
Springfield	Lansing	1
Springfield	Wausau	2
Madison	Lansing	54



/*4) Quantity of each product sold in Wisconsin?*/

SELECT [Consumer State], [Product Name],[Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS  NULL
AND "Supplier City" IS  NULL
 AND "Supplier State"IS  NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NOT NULL
 AND "Consumer State" ='Wisconsin'
 AND "Product Name" IS NOT NULL
 Consumer State	Product Name	Total Transactions Quantity
Wisconsin	TV	313300
Wisconsin	Computer	310900
Wisconsin	Orange	311200
Wisconsin	Boat	710500
Wisconsin	Auto	310430
Wisconsin	Gas	610400
Wisconsin	Airplane	310700
Wisconsin	Milk	340330


/*5) Quantity of sales by product and supplier state?*/
SELECT [Product Name],[Supplier State],[Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" IS NULL
 AND "Supplier State" IS NOT NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NULL
 AND "Consumer State" IS NULL
 AND "Product Name" IS NOT NULL
 Product Name	Supplier State	Total Transactions Quantity
Auto	Wisconsin	312000
Boat	Wisconsin	911810
TV	Wisconsin	319710
Gas	Wisconsin	911810
Computer	Wisconsin	313010
Airplane	Wisconsin	312310
Milk	Wisconsin	361720
Orange	Wisconsin	313010
Milk	Illinois	20
Boat	Illinois	100
Auto	Illinois	200
Orange	Illinois	100

/*6) Quantity of computer sales by suppliers in Wisconsin?*/

SELECT [Supplier Name], [Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" IS NOT NULL
 AND "Supplier State"='Wisconsin'
 AND "Consumer Name" IS NULL
 AND "Consumer City" IS NULL
 AND "Consumer State" IS NULL
 AND "Product Name" = 'computer'

 Supplier Name	Total Transactions Quantity
Bernstein	311710
Joe	500
Herman	500
Wolf	300

/*7) Quantity of auto sales by suppliers in Wisconsin to consumers in Illinois? */

SELECT [Supplier Name], [Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State"='Wisconsin'
AND "Consumer Name" IS NULL
AND "Consumer City" IS NULL
AND "Consumer State" ='Illinois'
AND "Product Name" = 'Auto'

Supplier Name	Total Transactions Quantity
Bernstein	300

/*8) Quantity e of auto sales by suppliers in Madison to consumers in Illinois?*/

SELECT [Supplier Name], [Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" = 'Madison'
AND "Supplier State" IS NOT NULL
AND "Consumer Name" IS NULL
AND "Consumer City" IS NULL
AND "Consumer State" ='Illinois'
AND "Product Name" = 'Auto'

Supplier Name	Total Transactions Quantity
Bernstein	300

/*9) Quantity of each product sold by supplier Bernstein to consumers in
Chicago?*/


SELECT [Product Name],[Consumer Name], [Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" = 'Bernstein'
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Consumer Name" IS NOT NULL
AND "Consumer City" = 'Chicago'
AND "Consumer State" IS NOT NULL
AND "Product Name" IS NOT NULL

Product Name	Consumer Name	Total Transactions Quantity
TV	Metzker	100
Computer	Metzker	100
Gas	Jacob	100
Orange	Jacob	100
TV	Jacob	100
Airplane	Boggs	100
Airplane	Metzker	100
Auto	Jacob	100
Gas	Boggs	100
Gas	Metzker	100
TV	Boggs	100
Boat	Boggs	100
Milk	Jacob	100
Orange	Metzker	100
Computer	Boggs	100
Milk	Boggs	100
Milk	Metzker	100
Airplane	Jacob	100
Auto	Boggs	100
Computer	Jacob	100
Boat	Metzker	100
Auto	Metzker	100
Orange	Boggs	100
Boat	Jacob	100


/*10) Quantity of milk sold by supplier Bernstein to consumers in Chicago?*/

SELECT [Supplier Name],[Product Name], [Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name" = 'Bernstein'
 AND "Supplier City" IS NOT NULL
 AND "Supplier State"  IS NOT NULL
 AND "Consumer Name" IS NULL
 AND "Consumer City" = 'Chicago'
 AND "Consumer State"  IS NOT NULL
 AND "Product Name" = 'Milk'



 Supplier Name	Product Name	Total Transactions Quantity
Bernstein	Milk	300



 /*11.) For each product list quantity sold by suppliers in
Madison to consumers in Chicago versus quantity sold by suppliers in
Chicago to consumers in Madison (result columns will be: product name,
quantity Madison_Chicago, quantity Chicago_Madison? */


SELECT [Supplier Name],[Product Name], [Total Transactions Quantity]
FROM Tb_Transactions_Cube
WHERE "Supplier Name"  IS NOT NULL
 AND "Supplier City" = 'Chicago'
 AND "Supplier State"  IS NOT NULL
 AND "Consumer Name" IS NOT NULL
 AND "Consumer City" = 'Madison'
 AND "Consumer State"  IS NOT NULL
 AND "Product Name" IS NOT NULL
