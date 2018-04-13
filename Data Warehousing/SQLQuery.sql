/*1 List full transaction data relating to suppliers from Madison and consumers from
Stevens Point where transaction value is higher than $10.000 (show supplier,
consumer and product names, quantity and price)?*/

SELECT S.NAME, C.NAME,P.NAME, T.Quantity, T.Price
FROM Tb_Supplier S, Tb_Consumer C, Tb_Product P, Tb_Transactions T
WHERE S.Supp_ID = T.Supp_ID
AND C.Con_ID = T.Con_ID
AND P.Prod_ID = T.Prod_ID
AND S.City = 'Madison'
/*AND C.City = 'Stevens Point'*/
AND T.Price > 10

/*stevens point is not one of the cities in Consumer's cities)*/


/*2 Name of suppliers offering both computers and oranges? (do not use set
operations)*/
SELECT S.Name 
FROM Tb_Supplier S
WHERE S.Supp_ID IN(
SELECT O.Supp_ID 
FROM Tb_Offers O, Tb_Product P
WHERE O.Prod_ID = P.Prod_ID
AND P.Name ='Computer') /*AND P.Name='Orange')*/

 /*shows nothing with AND Orange*/


 /*3 Name of suppliers from Wausau or offering computers or offering oranges?*/
SELECT S.NAME
FROM Tb_Supplier S, Tb_Product P, TB_Offers O
WHERE S.Supp_ID = O.Supp_ID AND P.Prod_ID = O.Prod_ID
AND S.City = 'Wausau' OR P.Name = 'Computer' OR P.Name = 'Orange'

/*4 Name of suppliers offering computer, auto and orange?*/
SELECT S.Name 
FROM Tb_Supplier S, Tb_Product P , TB_Offers O
WHERE S.Supp_ID = O.Supp_ID AND P.Prod_ID = O.Prod_ID
AND P.Name = 'Computer' AND P.Name = 'Auto' AND P.Name = 'Orange'

/*5 Name of products not offered in Chicago?*/
SELECT P.Name
FROM Tb_Supplier S, Tb_Product P , TB_Offers O
WHERE S.Supp_ID = O.Supp_ID AND P.Prod_ID = O.Prod_ID
AND S.CITY <> 'Chicago'

/*6 Name of consumers requesting only computers? */
SELECT C.NAME
FROM Tb_Consumer C, Tb_Product P, Tb_Requests R
WHERE C.Con_ID = R.Con_ID AND P.Prod_ID = R.Prod_ID AND P.Name = 'Computer'

/*7 Name of products offered by all suppliers? */
SELECT P.Name FROM Tb_Supplier S,Tb_Product P,TB_Offers O
WHERE S.Supp_ID = O.Supp_ID AND P.Prod_ID = O.Prod_ID

/* 8  Name of products sold in all cities except Stevens Point?*/
SELECT P.Name FROM Tb_Supplier S,Tb_Product P,TB_Offers O
WHERE S.Supp_ID = O.Supp_ID AND P.Prod_ID = O.Prod_ID
AND S.City <> 'Stevens Point' 

/* 9  Product name and supplier having the largest offer for that product?*/

SELECT DISTINCT P.Name, Supp_ID, Quantity
FROM Tb_Product P, Tb_Transactions T, Tb_Consumer C
WHERE P.Prod_ID=T.Prod_ID
 AND T.Con_ID= C.Con_ID
 AND Quantity >=ALL (SELECT Quantity
FROM TB_Offers
WHERE Prod_ID=P.Prod_ID)


/*10. Product name and city where that product sold in largest quantity?*/

SELECT DISTINCT P.Name, City, Quantity
FROM Tb_Product P, Tb_Transactions, Tb_Consumer
WHERE P.Prod_ID=Tb_Transactions.Prod_ID
 AND Tb_Transactions.Con_ID= Tb_Consumer.Con_ID
 AND Quantity >=ALL (SELECT Quantity
FROM Tb_Transactions
WHERE Prod_ID=P.Prod_ID)