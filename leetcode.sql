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
