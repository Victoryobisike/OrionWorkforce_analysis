/* CAPSTONE BUSINESS PROJECT*/
USE capstone;

SELECT* FROM departments;
SELECT* FROM countries;
SELECT* FROM employees;
SELECT* FROM jobs;

-- WorkForce Distribution
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
GROUP BY d.department_name,d.department_id
ORDER BY employee_count DESC;

-- Salary Comparison
SELECT d.department_id,d.department_name,
       ROUND(AVG(e.salary),0) AS avg_salary
FROM departments AS d
LEFT JOIN employees AS e ON e.department_id = d.department_id
GROUP BY d.department_name,d.department_id;
-- Highest Average Salary
SELECT d.department_id,d.department_name,
       ROUND(AVG(e.salary),0) AS avg_salary
FROM departments AS d
LEFT JOIN employees AS e ON e.department_id = d.department_id
GROUP BY d.department_name,d.department_id
ORDER BY avg_salary DESC
LIMIT 1;
-- Lowest Average Salary
SELECT d.department_id,d.department_name,
       ROUND(AVG(e.salary),0) AS avg_salary
FROM departments AS d
LEFT JOIN employees AS e ON e.department_id = d.department_id
GROUP BY d.department_name,d.department_id
ORDER BY avg_salary ASC
LIMIT 1;

-- Salary Bands For Employees
SELECT 
      CASE 
         WHEN salary<5000 THEN 'Low'
         WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
         WHEN salary>10000 THEN 'High'
         ELSE 'No band'
	  END AS salary_band,
	  COUNT(employee_id) AS Number_of_employees
  FROM employees
  GROUP BY salary_band;
  
  -- Country Level Analysis
  SELECT c.country_id,c.country_name,
    COUNT(DISTINCT d.department_id) AS number_of_departments
FROM employees AS e
JOIN countries AS c ON e.country_id = c.country_id
JOIN departments AS d ON e.department_id = d.department_id
GROUP BY c.country_id, c.country_name
ORDER BY number_of_departments DESC;

-- High Earners
SELECT employee_id,emp_name,salary
FROM employees
WHERE salary>
	  (SELECT AVG(salary)
	  FROM employees);
      
-- Department Leaders
SELECT d.department_name,m.emp_name AS manager_name,
    COUNT(e.employee_id) AS employee_count
FROM departments AS d
INNER JOIN employees AS e ON d.department_id = e.department_id
INNER JOIN employees AS m ON d.manager_id = m.employee_id
GROUP BY d.department_id,d.department_name,m.employee_id,m.emp_name;

-- Job Role Analysis
WITH job_salary_analysis AS (
    SELECT j.job_title,
        AVG(e.salary) AS avg_salary
    FROM jobs AS j
    INNER JOIN employees AS e ON j.job_id = e.job_id
    GROUP BY j.job_id, j.job_title
)
SELECT job_title,avg_salary
FROM job_salary_analysis
HAVING avg_salary > 12000;

-- Employee Ranking
SELECT employee_id,emp_name,department_id,salary,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- Salary Growth Trend
SELECT c.country_name,
    SUM(e.salary) AS total_salary_cost
FROM employees AS e
INNER JOIN countries AS c ON e.country_id = c.country_id
GROUP BY c.country_id,c.country_name
ORDER BY total_salary_cost DESC;

-- Workforce Gaps
SELECT j.job_id,j.job_title
FROM employees AS e
RIGHT JOIN jobs AS j ON e.job_id = j.job_id
WHERE e.employee_id IS NULL;