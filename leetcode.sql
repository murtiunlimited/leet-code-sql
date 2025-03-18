-- 1757. Recyclable and Low Fat Products
SELECT 
product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y'
-- 584. Find Customer Referee
SELECT
name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL
-- 595. Big Countries 
SELECT 
name,
population,
area
FROM World
WHERE (area>=3000000) OR (population>=25000000)
-- 1148. Article Views I
SELECT DISTINCT
author_id AS id
FROM Views 
WHERE (author_id=viewer_id)
ORDER BY author_id ASC
-- 1683. Invalid Tweets
SELECT 
tweet_id
FROM Tweets
WHERE (LENGTH(content) > 15)
-- 1378. Replace Employee ID With The Unique Identifier
SELECT
EmployeeUNI.unique_id,
Employees.name
FROM Employees
LEFT JOIN EmployeeUNI ON Employees.id=EmployeeUNI.id
-- 1068. Product Sales Analysis I
SELECT
Product.product_name,
Sales.year,
Sales.price
    
-- 1581. Customer Who Visited but Did Not Make Any Transactions
SELECT Visits.customer_id,
COUNT(Visits.visit_id) AS count_no_trans
FROM Transactions
RIGHT JOIN Visits ON Transactions.visit_id = Visits.visit_id
WHERE Transactions.transaction_id IS NULL
GROUP BY Visits.customer_id
FROM Sales
LEFT JOIN Product ON Sales.product_id=Product.product_id
    
-- 197. Rising Temperature 
SELECT id
FROM (
    SELECT id, temperature, LAG(temperature) OVER (ORDER BY recordDate) AS prev_temperature
    FROM Weather
) AS Subquery
WHERE temperature > prev_temperature;

-- 577. Employee Bonus
SELECT 
Employee.name,
Bonus.bonus
FROM Employee
LEFT JOIN Bonus ON Employee.empID = Bonus.empId
WHERE bonus < 1000 OR bonus IS null
-- 1280. Students and Examinations
SELECT Students.student_id, Students.student_name, Subjects.subject_name,
count(Examinations.subject_name) as attended_exams
from students
JOIN Subjects
LEFT JOIN Examinations ON Students.student_id = Examinations.student_id AND Subjects.subject_name = Examinations.subject_name
GROUP BY Students.student_id, Subjects.subject_name;
-- 570. Managers with at Least 5 Direct Reports
-- self join
SELECT TableA.name
FROM Employee TableA 
INNER JOIN Employee TableB ON TableA.id=TableB.managerId
GROUP BY TableA.id
HAVING COUNT(TableB.id)>=5
-- 1934. Confirmation Rate
SELECT 
Signups.user_id,
ROUND(COALESCE((COUNT(CASE WHEN action='confirmed' THEN 1 END) / COUNT(Confirmations.user_id) ) ,0),2)AS confirmation_rate
FROM Signups
LEFT JOIN Confirmations ON Signups.user_id = Confirmations.user_id
GROUP BY Signups.user_id

-- 620. Not Boring Movies
SELECT * FROM Cinema
WHERE (id%2=1) AND (description <> 'boring')
ORDER BY rating DESC 
-- 1251. Average Selling Price
SELECT Prices.product_id, 
       COALESCE(ROUND((SUM(UnitsSold.units * Prices.price)) / (SUM(UnitsSold.units)),2),0) AS average_price
FROM Prices
LEFT JOIN UnitsSold
    ON Prices.product_id = UnitsSold.product_id
    AND UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
GROUP BY Prices.product_id;
-- 1075. Project Employees I
SELECT
Project.Project_id AS project_id, ROUND((SUM(Employee.experience_years) / COUNT(Employee.employee_id)),2) AS average_years
from Project
LEFT join Employee ON Project.employee_id = Employee.employee_id
GROUP BY Project_id
-- 1633. Percentage of Users Attended a Contest
Select
contest_id,
ROUND((COUNT(Register.contest_id) / (SELECT count(Users.user_id) FROM Users))*100,2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;
-- 1211. Queries Quality and Percentage
SELECT
query_name,
ROUND(SUM(rating/position) / COUNT(query_name),2) AS quality,
ROUND((SUM(if(rating<3,1,0)) / COUNT(query_name))*100,2) AS poor_query_percentage
FROM Queries
GROUP BY query_name
-- 1193. Monthly Transactions I
SELECT 
DATE_FORMAT(trans_date, '%Y-%m') AS month,
country,
count(*) AS trans_count,
SUM(state='approved') AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state='approved' THEN amount ELSE 0 END ) AS approved_total_amount
FROM Transactions
GROUP BY month, country
-- 1174. Immediate Food Delivery II
SELECT ROUND((SUM(IF(order_date = customer_pref_delivery_date,1,0)) / COUNT(*)) * 100,2) AS immediate_percentage
FROM Delivery WHERE (customer_id, order_date) IN (
SELECT customer_id, MIN(order_date) AS order_date
FROM Delivery
GROUP BY customer_id
)
-- 2356. Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id,
count(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id
-- 1141. User Activity for the Past 30 Days I
SELECT
activity_date AS day,
COUNT(CASE WHEN activity_type='open_session' OR activity_type='scroll_down'
OR activity_type='send_message' THEN session_id END) AS active_users
FROM Activity
GROUP BY day
-- 596. Classes More Than 5 Students
SELECT
class
FROM Courses
GROUP BY class
HAVING count(class) >=5
-- 1729. Find Followers Count
WITH CTE AS (
SELECT
TableA.user_id AS users_id,
TableA.follower_id AS follower_id,
TableB.user_id AS follower_to_user
FROM Followers AS TableA
INNER JOIN Followers AS TableB
ON TableA.user_id = TableB.follower_id
)
SELECT 
    CTE.follower_to_user AS user_id,
    COUNT(CTE.follower_id) AS followers_count
FROM CTE
GROUP BY user_id;
-- 619. Biggest Single Number
WITH CTE AS (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) < 2
)
SELECT MAX(CTE.num) AS num
FROM CTE;
-- 1045. Customers Who Bought All Products
SELECT customer_id
FROM

(SELECT
  customer_id,
  COUNT(DISTINCT product_key) AS Products_Bought
FROM Customer
GROUP BY customer_id
) AS derived_table

WHERE Products_Bought = (SELECT COUNT(*) FROM Product);
-- 1731. The Number of Employees Which Report to Each Employee
SELECT AVG(age) FROM Employees
-- 610. Triangle Judgement
SELECT
x,
y,
z,
CASE 
WHEN x>0 AND y>0 AND x+y>z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No' 
END AS Triangle
FROM Triangle
-- 1978. Employees Whose Manager Left the Company
WITH CTE AS (SELECT
  a.employee_id,
  a.name,
  a.manager_id,
  a.salary,
  b.name AS manager_name
FROM Employees a
LEFT JOIN Employees b ON a.manager_id = b.employee_id
WHERE a.manager_id IS NOT NULL AND b.employee_id IS NULL AND a.salary < 30000
)
SELECT CTE.employee_id
FROM CTE
ORDER BY CTE.employee_id
-- 196. Delete Duplicate Emails
WITH CTE AS (
  SELECT MIN(id) AS id
  FROM Person
  GROUP BY email
)

DELETE FROM Person
where ID NOT IN (select id from CTE)
-- 1484. Group Sold Products By The Date
SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products
FROM 
    Activities
GROUP BY 
    sell_date;
-- 1517. Find Users With Valid E-Mails
SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode[.]com$');
-- 1527. Patients With a Condition
SELECT * FROM Patients p
WHERE p.conditions LIKE "DIAB1%" OR p.conditions LIKE "% DIAB1%"
-- 1667. Fix Names in a Table
SELECT u.user_id, CONCAT(UPPER(LEFT(u.name, 1)), LOWER(SUBSTRING(u.name, 2))) AS name
FROM Users u
ORDER BY u.user_id
-- 1341. Movie Rating
SELECT results
FROM (SELECT MovieRating.user_id, COUNT(MovieRating.user_id) AS rating_count, Users.name as results FROM MovieRating
RIGHT JOIN Users ON MovieRating.user_id = Users.user_id
GROUP BY user_id
ORDER BY COUNT(MovieRating.user_id) DESC , name ASC
Limit 1) AS Subquery
UNION ALL
SELECT Title FROM( 
SELECT MovieRating.movie_id, Movies.title AS Title, AVG(MovieRating.rating) as avg_rating
FROM MovieRating
RIGHT JOIN Movies ON MovieRating.movie_id = Movies.movie_id
WHERE MONTH(created_at) = 2 AND YEAR(MovieRating.created_at) = 2020
GROUP BY movie_id
ORDER BY avg_rating DESC, Movies.title ASC  
LIMIT 1
) AS sinquery


