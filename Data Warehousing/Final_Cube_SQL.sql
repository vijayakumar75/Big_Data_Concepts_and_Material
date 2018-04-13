



/*Cube Creation */


SELECT DISTINCT S.Name "Supplier Name",
S.City "Supplier City",
S.State "Supplier State",
P.Product_Packaging "Product Packaging",
P.Name "Product Name",
P.Product_Category "Product Category",
P.Product_Line "Product Line",

SUM(Quantity) "Total Transactions Quantity",
SUM(Quantity*Price) "Transaction Value",
MAX(Price) "Max Price",
MIN(Price) "Min Price"
INTO Tb_Final_Cube

FROM Tb_Supplier S, Tb_Offers O, Tb_Product P
 WHERE
 O.Supp_ID = S.Supp_ID AND
 O.Prod_ID = P.Prod_ID
 GROUP BY CUBE    ((S.State, S.City, S.Name), 
				(P.Product_Packaging, P.Name), 
				(P.Product_Category, P.Product_Line, P.Name)),

 ROLLUP(S.State, S.City, S.Name),
 ROLLUP(P.Product_Packaging, P.Name),
 ROLLUP(P.Product_Category, P.Product_Line, P.Name)


 /*1. Quantity of products offered in each supplier city? (2 points)*/


 SELECT [Supplier City],[Product Name], [Total Transactions Quantity]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS  NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS  NULL
AND "Product Line" IS NULL




/*2. Quantity of offers for each product? (2 points)*/

 SELECT [Product Name], [Total Transactions Quantity]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS  NULL
AND "Supplier City" IS  NULL
AND "Supplier State" IS NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS  NULL
AND "Product Line" IS NULL



/*3. Quantity of offers for each product category by each supplier? (2 points)*/

 SELECT [Supplier Name],[Product Category], [Total Transactions Quantity]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS  NOT NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NULL
AND "Product Category" IS  NOT NULL
AND "Product Line" IS NULL



/*4. Quantity of offers for each product line in each supplier city? (2 points)*/

SELECT [Supplier City],[Product Line], [Total Transactions Quantity]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS  NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NULL
AND "Product Category" IS  NOT NULL
AND "Product Line" IS NOT NULL



/*5. Value of products offered by supplier and by product packaging? (2 points)*/

SELECT [Supplier Name],[Product Name],[Product Packaging], [Transaction Value]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS  NULL
AND "Product Line" IS NULL



/*6. Volume of milk offered by each supplier in Wisconsin? (2 points)*/

SELECT [Supplier Name],[Supplier State],[Product Name], [Total Transactions Quantity]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" = 'Wisconsin'
AND "Product Packaging" IS NOT NULL
AND "Product Name" = 'Milk'
AND "Product Category" IS NULL
AND "Product Line" IS NULL


/*7. Find the maximum price for each product offered in Madison? (4 points)*/
SELECT [Supplier City], [Product Name], [Max Price]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" = 'Madison'
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS NULL
AND "Product Line" IS NULL

SELECT [Supplier City], [Product Name], [Min Price]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" = 'Madison'
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS NULL
AND "Product Line" IS NULL



/*8. For each supplier city find the product offered in largest quantity?*/
SELECT table1.*
FROM (SELECT [Supplier City], [Product Name], [Total Transactions Quantity],
             ROW_NUMBER() OVER (PARTITION BY [Product Name] ORDER BY [Total Transactions Quantity] DESC) as seqnum
      FROM Tb_Final_Cube
      WHERE "Supplier Name" IS NULL AND
            "Supplier City" IS NOT NULL AND
            "Supplier State" IS NOT NULL AND
            "Product Packaging" IS NOT NULL AND
            "Product Name" IS NOT NULL AND
            "Product Category" IS NULL AND
            "Product Line" IS NULL 
      ) table1
WHERE seqnum = 1;

/* SUB-QUERY
SELECT [Supplier City], [Product Name], [Total Transactions Quantity]
FROM Tb_Final_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS NULL
AND "Product Line" IS NULL 
*/






/*9. For each product find the city where it is offered at the lowest price?
(7 points)*/
SELECT table1.*
FROM (SELECT [Supplier City], [Product Name], [Min Price],
             ROW_NUMBER() OVER (PARTITION BY [Product Name] ORDER BY [Min Price] ASC) as seqnum
      FROM Tb_Final_Cube
      WHERE "Supplier Name" IS NULL
		AND "Supplier City" IS NOT NULL
		AND "Supplier State" IS NOT NULL
		AND "Product Packaging" IS NOT NULL
		AND "Product Name" IS NOT NULL
		AND "Product Category" IS NULL
		AND "Product Line" IS NULL
      ) table1
WHERE seqnum = 1;



/* SUB-QUERY */
SELECT [Supplier City], [Product Name], [Min Price] 
FROM Tb_Final_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL
AND "Product Category" IS NULL
AND "Product Line" IS NULL

