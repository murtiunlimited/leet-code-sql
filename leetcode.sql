-- 1 
SELECT 
product_id
FROM Products
WHERE low_fats = 'Y' AND recycleable = 'Y'
-- 2
SELECT
name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL
-- 3 
SELECT 
name,
population,
area
FROM World
WHERE (area>=3000000) OR (population>=25000000)
-- 4
SELECT DISTINCT
author_id AS id
FROM Views 
WHERE (author_id=viewer_id)
ORDER BY author_id ASC
-- 5
SELECT 
tweet_id
FROM Tweets
WHERE (LENGTH(content) > 15)
-- 6
SELECT
EmployeeUNI.unique_id,
Employees.name
FROM Employees
LEFT JOIN EmployeeUNI ON Employees.id=EmployeeUNI.id
-- 7
SELECT
Product.product_name,
Sales.year,
Sales.price
    
-- 8
SELECT Visits.customer_id,
COUNT(Visits.visit_id) AS count_no_trans
FROM Transactions
RIGHT JOIN Visits ON Transactions.visit_id = Visits.visit_id
WHERE Transactions.transaction_id IS NULL
GROUP BY Visits.customer_id
FROM Sales
LEFT JOIN Product ON Sales.product_id=Product.product_id
    
-- 9 
SELECT id
FROM (
    SELECT id, temperature, LAG(temperature) OVER (ORDER BY recordDate) AS prev_temperature
    FROM Weather
) AS Subquery
WHERE temperature > prev_temperature;

-- 11
SELECT 
Employee.name,
Bonus.bonus
FROM Employee
LEFT JOIN Bonus ON Employee.empID = Bonus.empId
WHERE bonus < 1000 OR bonus IS null

-- 13
-- self join
SELECT TableA.name
FROM Employee TableA 
INNER JOIN Employee TableB ON TableA.id=TableB.managerId
GROUP BY TableA.id
HAVING COUNT(TableB.id)>=5

-- 15
SELECT * FROM Cinema
WHERE (id%2=1) AND (description <> 'boring')
ORDER BY rating DESC 
-- 16
SELECT Prices.product_id, 
       COALESCE(ROUND((SUM(UnitsSold.units * Prices.price)) / (SUM(UnitsSold.units)),2),0) AS average_price
FROM Prices
LEFT JOIN UnitsSold
    ON Prices.product_id = UnitsSold.product_id
    AND UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
GROUP BY Prices.product_id;
-- 17
SELECT
Project.Project_id AS project_id, ROUND((SUM(Employee.experience_years) / COUNT(Employee.employee_id)),2) AS average_years
from Project
LEFT join Employee ON Project.employee_id = Employee.employee_id
GROUP BY Project_id
-- 18
Select
contest_id,
ROUND((COUNT(Register.contest_id) / (SELECT count(Users.user_id) FROM Users))*100,2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;
-- 19
SELECT
query_name,
ROUND(SUM(rating/position) / COUNT(query_name),2) AS quality,
ROUND((SUM(if(rating<3,1,0)) / COUNT(query_name))*100,2) AS poor_query_percentage
FROM Queries
GROUP BY query_name


