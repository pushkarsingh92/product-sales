SELECT * FROM TRANSACTIONS1
SELECT * FROM prod_cat_info1
SELECT * FROM Customer1

---ANS1
SELECT COUNT(*) FROM Transactions1
SELECT COUNT(*) FROM prod_cat_info1
SELECT COUNT(*) FROM  Customer1


---ANS2

SELECT * FROM TRANSACTIONS1 
WHERE QTY <0


--ANS3

SELECT *,CONVERT(DATE,TRAN_DATE,105) AS FORMATTED_DATE FROM Transactions1


---ANS4

SELECT *,DATEDIFF(DAY,TRAN_DATE, GETDATE()) AS TIME_RANGE FROM Transactions1 
SELECT DATEDIFF(YEAR,TRAN_DATE, GETDATE()) AS TIME_RANGE FROM Transactions1
SELECT DATEDIFF(MONTH,TRAN_DATE, GETDATE()) AS TIME_RANGE FROM Transactions1


---ANS5

SELECT PROD_CAT FROM prod_cat_info1
WHERE prod_subcat ='DIY'


----DATA ANALYSIS

--ANS 1

SELECT * FROM TRANSACTIONS1
SELECT * FROM prod_cat_info1
SELECT * FROM Customer1


SELECT TOP 5 Store_type, CUST_ID,COUNT(STORE_TYPE) AS CHANNEL_COUNT
FROM Transactions1
GROUP BY cust_id, Store_type
ORDER BY CHANNEL_COUNT DESC


---ANS2

SELECT  Gender, COUNT(GENDER) AS GENDER_COUNT FROM Customer1
GROUP BY Gender
ORDER BY GENDER_COUNT DESC


---ANS3


SELECT * FROM TRANSACTIONS1
SELECT * FROM prod_cat_info1
SELECT * FROM Customer1

SELECT city_code, COUNT(CITY_CODE) AS CITY_COUNT
FROM Customer1
GROUP BY city_code
ORDER BY CITY_COUNT DESC


---ANS 4
SELECT * FROM prod_cat_info1

select prod_cat, count(prod_subcat) as subcat_count 
from prod_cat_info1
group by prod_cat
order by subcat_count desc


---ANS5
SELECT top 3 qty,prod_cat, prod_subcat FROM TRANSACTIONS1
inner join 
prod_cat_info1
ON 
prod_subcat_code = prod_sub_cat_code
order by Qty desc


--ANS 6

SELECT prod_Cat ,sum(total_amt) as total_revenue FROM Transactions1
INNER JOIN 
prod_cat_info1
ON prod_subcat_code = prod_sub_cat_code
WHERE prod_cat IN('Electronics', 'Clothing')
group by prod_cat
order by total_revenue desc


--ANS 7
SELECT transaction_id, count(transaction_id) as revenue_count FROM Transactions1
WHERE Qty <0

group by transaction_id
order by revenue_count desc


select  top 3 transaction_id, count(transaction_id) as revenue_count from Transactions1
group by transaction_id
order by revenue_count desc
---7 the question not clear


---ANS8

SELECT store_type, SUM(total_amt) as total_revenue FROM Transactions1 AS A
INNER JOIN 
prod_cat_info1 AS B
ON
A.prod_cat_code= B.prod_cat_code AND A.prod_subcat_code = B.prod_sub_cat_code
where prod_cat in ('Electronics','Clothing') and  Store_type in('Flagship store')
group by Store_type
order by total_revenue desc


----Ans9


SELECT  top 1 * FROM TRANSACTIONS1
SELECT top 1 * FROM prod_cat_info1
SELECT top 1 * FROM Customer1


SELECT PROD_CAT, prod_subcat, gender,SUM(TOTAL_AMT) AS TOTAL_REVENUE FROM Transactions1  AS A
INNER JOIN prod_cat_info1 AS B ON A.prod_cat_code = B. prod_cat_code
INNER JOIN Customer1 AS C ON A.cust_id = C.customer_Id
WHERE Gender ='M' AND prod_cat='Electronics'
GROUP BY prod_cat, gender, prod_subcat
ORDER BY TOTAL_REVENUE DESC


---ANS 10

SELECT  top 1 * FROM TRANSACTIONS1
SELECT top 1 * FROM prod_cat_info1
SELECT top 1 * FROM Customer1

SELECT TOP 5 PROD_SUBCAT, 
SUM(CASE WHEN TOTAL_AMT>0 THEN TOTAL_AMT ELSE 0 END)/(SELECT SUM(TOTAL_AMT) FROM Transactions1 WHERE total_amt>0) * 100 AS [SALES%],
SUM(CASE WHEN TOTAL_AMT<0 THEN TOTAL_AMT ELSE 0 END)/(SELECT SUM(TOTAL_AMT) FROM Transactions1 WHERE total_amt<0) * 100 AS [RETURNS%]
 FROM  Transactions1 as T
INNER JOIN 
prod_cat_info1  as P
ON T.prod_cat_code = P.prod_cat_Code
group by prod_subcat
order by [SALES%] DESC



--Ans11

SELECT  top 1 * FROM TRANSACTIONS1
SELECT top 1 * FROM prod_cat_info1
SELECT top 1 * FROM Customer1

select *, 
SELECT DOB,Gender,SUM(TOTAL_AMT) AS TOTAL_REVENUE,DATEDIFF(YEAR,DOB, GETDATE()) AS AGE_IN_YEAR  from Transactions1 as T
inner join 
prod_cat_info1 as P
on 
T.prod_cat_code = P. prod_cat_code and T.prod_subcat_code = P.prod_sub_cat_code
inner join 
Customer1 as C
on 
T.cust_id= C. customer_Id
 WHERE  (DATEDIFF(YEAR,DOB, GETDATE())) BETWEEN 25 AND 35  AND (DATEDIFF(DAY,'2014-02-28',TRAN_DATE))<30
 GROUP BY Gender,DOB,total_amt 
 ORDER BY TOTAL_REVENUE DESC




--ANS12

SELECT  top 1 * FROM TRANSACTIONS1

SELECT top 1 * FROM prod_cat_info1
SELECT top 1 * FROM Customer1

SELECT TOP 3 prod_cat, SUM( TOTAL_AMT) AS TOTAL_REVENUE
FROM Transactions1 AS T
INNER JOIN 
prod_cat_info1 AS P
ON
T.prod_cat_code =P.prod_cat_code AND T.prod_subcat_code = P. prod_sub_cat_code
WHERE QTY<0 AND (DATEDIFF(DAY,'2014-02-28',TRAN_DATE))<90
 GROUP BY prod_cat
 ORDER BY TOTAL_REVENUE 


--ANS13

SELECT Store_type,prod_cat, SUM(TOTAL_AMT) AS TOTAL_REVENUE , SUM(QTY) AS TOTAL_QTY FROM Transactions1 AS T
INNER JOIN 
prod_cat_info1 AS P 
ON 
T.prod_cat_code= P. prod_cat_code AND T.prod_subcat_code= P.prod_sub_cat_code
WHERE QTY>0
GROUP BY STORE_TYPE, PROD_CAT
ORDER BY TOTAL_REVENUE DESC



--ANS14

SELECT prod_cat,AVG(TOTAL_AMT) AS AVERAGE_REVENUE FROM Transactions1  AS T
INNER JOIN prod_cat_info1 AS P
ON 
T.prod_cat_code= P. prod_cat_code AND T.prod_subcat_code= P.prod_sub_cat_code
GROUP BY prod_cat
HAVING AVG(TOTAL_AMT)>(SELECT AVG(TOTAL_AMT) AS AVERAGE_TOTAL_REVENUE FROM  Transactions1)
ORDER BY AVERAGE_REVENUE DESC


---ANS15



select   top  5 prod_cat from Transactions1  as T
inner join 
prod_cat_info1 as P
on 
T. prod_cat_code = P. prod_cat_code and T. prod_subcat_code = P. prod_sub_cat_code



select  prod_subcat,AVG(total_amt) as Average_amnt, sum(total_amt) as total_revenue  from Transactions1  as T
inner join 
prod_cat_info1 as P
on 
T. prod_cat_code = P. prod_cat_code and T. prod_subcat_code = P. prod_sub_cat_code
where prod_cat in 
(select   top  5 prod_cat from Transactions1  as T
inner join 
prod_cat_info1 as P
on 
T. prod_cat_code = P. prod_cat_code and T. prod_subcat_code = P. prod_sub_cat_code)
 
group by prod_subcat
