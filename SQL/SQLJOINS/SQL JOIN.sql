--CROSS JOIN
select COUNT(*) from udusx.users t1 
CROSS JOIN udusx.groups t2

--INNER JOIN
SELECT * FROM udusx.users t1
INNER JOIN udusx.membership t2
ON t1.user_id = t2.user_id

--LEFT JOIN 
SELECT * FROM udusx.membership t1
LEFT JOIN udusx.users t2
ON t1.user_id = t2.user_id

--RIGHT JOIN
SELECT * FROM udusx.membership t1
RIGHT JOIN udusx.users t2
ON t1.user_id = t2.user_id

--FULL OUTER JOIN
--cannot perform im MySQL
SELECT * FROM udusx.membership t1
FULL OUTER JOIN udusx.users t2
ON t1.user_id = t2.user_id
-----
SELECT * FROM udusx.membership t1
LEFT JOIN udusx.users t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM udusx.membership t1
RIGHT JOIN udusx.users t2
ON t1.user_id = t2.user_id

--SET OPERATOR
--UNION
SELECT * FROM udusx.person1
 UNION
SELECT * FROM udusx.person2

--INTERSECTION
SELECT * FROM udusx.person1
 INTERSECT
SELECT * FROM udusx.person2

--EXCEPT
SELECT * FROM udusx.person1
 EXCEPT
SELECT * FROM udusx.person2

--SELF JOIN
SELECT * FROM udusx.users t1
JOIN udusx.users t2
ON t1.city = t2.user_id

--JOIN on 2 or more cOLUMNS
SELECT * FROM udusx.students t1
JOIN udusx.class t2
ON t1.class_id = t2.class_id AND t1.enrollment_year = t2.class_year

--JOINONG MORE THAN 2 TABLES
SELECT * FROM udus.order_details t1
JOIN udus.orders t2
ON t1.order_id =t2.order_id
JOIN udus.users t3
ON  t2.user_id = t3.user_id

--Practice QUESTIONS
--1 Find all profitable orders 
SELECT t1.order_id,SUM(t1.profit) profit FROM udus.order_details t1
JOIN udus.orders t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING profit >0
ORDER BY profit DESC
--2 Find the customer who has placed the max number of orders 
SELECT t1.quantity,t2.user_id,COUNT(t1.quantity) cquantity FROM udus.order_details t1
JOIN udus.orders t2
ON t1.order_id = t2.order_id
GROUP BY user_id
ORDER BY cquantity DESC 
LIMIT 1

--3 Which is the most profitable category 
SELECT category,SUM(profit) p FROM udus.order_details t1
JOIN udusx.category t2
ON t1.category_id = t2.category_id
GROUP BY t2.vertical
HAVING p >0
ORDER BY P DESC 
LIMIT 1

--4 Which is the most profitable state 
SELECT t2.state,SUM(profit) p FROM udus.orders t1
JOIN udus.order_details t2
ON t1.order_id = t2.order_id
JOIN udus.users1 t3
ON t1.user_id = t2.user_id
GROUP BY t2.state
HAVING p >0
ORDER BY P DESC 
LIMIT 1

--5 Find all categories with profits higher than 5000 
SELECT category, SUM(profit) P FROM udus.order_details t1
JOIN udus.category t2
ON t1.category_id = t2.category_id 
GROUP BY category
HAVING p >5000
ORDER BY P DESC