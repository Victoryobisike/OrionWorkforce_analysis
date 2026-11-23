# Orion Data Systems Workforce Analytics Report

## Executive Summary 
Orion Data Systems employs **107** staff across **11** active departments and **25** countries, with a total salary cost of **$691,400** and an average salary of **$6,462**. Nearly half of the workforce (47.7%, or 51 employees) earns above the company average, while 45.8% (49 employees) falls into the Low salary band (under $5,000).
Three patterns stand out. Headcount is heavily concentrated in Shipping (45 staff) and Sales (34 staff), which together make up 73.8% of all employees, whereas 16 registered departments in the database have zero assigned staff. Pay varies widely across functions: Executive leads with an average salary of $19,333, while Shipping averages just $3,476;nearly six times lower. Geographically, Switzerland leads both department presence (5 departments) and total payroll ($75,100 across 11 staff). Auditing inactive departments, reviewing entry-level Shipping pay, and balancing global payroll allocation give leadership clear levers for workforce planning.

## Business Context 
Orion Data Systems is a multinational consulting and technology firm headquartered in San Francisco with offices across Europe, Asia, and the Americas. As the organization manages employees across multiple countries, departments, and job roles, the HR & Strategy team needed reliable answers to core workforce questions. Management required a structured MySQL database analysis to evaluate department headcount, salary distributions, leadership spans, global payroll costs, and open job role gaps. 

## Objectives
-	How are employees distributed across departments, and which department has the highest headcount?
-	What is the average salary per department, and which departments rank highest and lowest?
-	How do employees split across Low (<$5,000), Medium ($5,000–$10,000), and High (>$10,000) salary bands, and who earns above the company average?
-	Which countries host the most departments and carry the highest total payroll cost?
-	Which job titles average over $12,000, and are there any job roles in the company with zero assigned employees? 

## Data Overview 
The data consists of four relational CSV tables loaded into a MySQL schema named capstone: 
-	employees: 107 rows across 11 columns (employee_id, emp_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_name, department_id, country_id), covering hire dates from June to October 1987.
-	departments: 27 rows across 4 columns (department_id, department_name, manager_id, location_id), of which 11 have assigned employees.
-	jobs: 19 rows across 4 columns (job_id, job_title, min_salary, max_salary), all actively staffed.
-	countries: 25 rows across 3 columns (country_id, country_name, region), spanning Europe, Asia, the Americas, Africa, and Oceania. 

## Key Findings
-	Total company payroll is $691,400 across 107 employees, with an average salary of $6,462 and a median salary of $6,200 (ranging from $2,100 to $24,000).
-	Shipping (45 employees; 42.1%) and Sales (34 employees; 31.8%) account for nearly three-quarters of total headcount, while 16 listed departments have zero staff.
-	Executive has the highest average salary ($19,333), whereas Shipping has the lowest ($3,476) among active departments.
-	49 employees (45.8%) fall into the Low salary band (<$5,000), 43 (40.2%) into Medium ($5,000–$10,000), and 15 (14.0%) into High (>$10,000).
-	51 employees (47.7%) earn above the company-wide average salary of $6,462.
-	Four job titles average above $12,000: President ($24,000), Administration Vice President ($17,000), Marketing Manager ($13,000), and Sales Manager ($12,200).
-	Switzerland leads all 25 countries in both active departments (5) and total salary cost ($75,100), followed by Italy ($52,100) and Israel ($45,200).
-	All 19 job roles in the jobs table have at least one employee assigned, leaving zero unfilled job role gaps. 

## Database Schema & Entity-Relationship Diagram (ERD)
The capstone MySQL database uses a normalized relational structure centered on the employees table (107 records) linked via foreign keys to three lookup tables: departments (department_id), jobs (job_id), and countries (country_id). A self-referencing relationship between departments.manager_id and employees.employee_id also maps department heads directly to their reporting teams.

![ERD](<Orion Systems ERD.png>)

**[View Complete SQL Script (`Victory_Obisike_wk6.sql`)](https://github.com/YourUsername/Your-Repo-Name/blob/main/Victory_Obisike_wk6.sql)**


Data Cleaning and Transformation 
All steps were completed in MySQL inside the capstone schema: 
-	Created the capstone database schema and imported employees.csv, departments.csv, jobs.csv, and countries.csv as structured relational tables. 
-	Verified primary key and row integrity across all four tables: confirmed 107 unique employee_id records, 27 unique department_id records, 19 unique job_id records, and 25 unique country_id records with zero duplicate rows and zero null values.
-	Validated relational joins across foreign keys (department_id, job_id, country_id, and self-referencing manager_id) using INNER JOIN, LEFT JOIN, and RIGHT JOIN to ensure accurate aggregation without dropping unassigned departments or job roles. 
-	Applied ROUND() formatting to average salary outputs and used CASE logic to group individual salaries into clean compensation tiers. 

## Detailed Findings & Analysis
### Workforce Distribution & Department Leadership 
Across the 27 departments in the database, only 11 actively employ staff, led by operational and revenue-generating teams:
-	Shipping: 45 employees (Manager: Adam Fripp)
-	Sales: 34 employees (Manager: John Russell)
-	Finance: 6 employees (Manager: Nancy Greenberg)
-	Purchasing: 6 employees (Manager: Den Raphaely)
-	IT: 5 employees (Manager: Alexander Hunold)
-	Executive: 3 employees (Manager: Steven King)
-	Accounting: 2 employees (Manager: Shelley Higgins)
-	Marketing: 2 employees (Manager: Michael Hartstein)
-	Administration (Jennifer Whalen), Human Resources (Susan Mavris), and Public Relations (Hermann Baer): 1 employee each.
The remaining 16 departments (including Payroll, Recruiting, IT Support, Operations, Manufacturing, and Treasury) have zero employees assigned.
### Department Salary Comparison & Top Earners
Average pay differs sharply between leadership/corporate teams and operational units:
-	Highest Average Salaries: Executive ($19,333), Accounting ($10,150), Public Relations ($10,000), Marketing ($9,500), Sales ($8,956), and Finance ($8,600).
-	Mid-to-Lower Average Salaries: Human Resources ($6,500), IT ($5,760), Administration ($4,400), Purchasing ($4,150), and Shipping ($3,476).
Using ROW_NUMBER() partitioned by department, Steven King ($24,000, Executive) ranks as the highest-paid employee overall, followed by Neena Kochhar and Lex De Haan ($17,000 each, Executive), John Russell ($14,000, Sales), Karen Partners ($13,500, Sales), and Michael Hartstein ($13,000, Marketing).
### Salary Bands & Job Role Analysis
-	Low (<$5,000): 49 employees (45.8%), concentrated heavily in Shipping and Purchasing.
-	Medium ($5,000–$10,000): 43 employees (40.2%), spanning Sales, IT, Finance, and mid-level specialists.
-	High (>$10,000): 15 employees (14.0%), led by senior managers and executives.
Four job titles exceed the $12,000 average salary threshold: President ($24,000; 1 employee), Administration Vice President ($17,000; 2 employees), Marketing Manager ($13,000; 1 employee), and Sales Manager ($12,200; 5 employees). A RIGHT JOIN between employees and jobs confirmed zero unassigned job roles across all 19 titles. 
### Country-Level Footprint & Payroll Cost 
Orion Data Systems operates across 25 countries, with Europe and Asia driving the largest share of payroll:
-	Top Countries by Department Count: Switzerland leads with 5 active departments (11 employees), followed by Italy (4 departments; 7 employees), Japan (4 departments; 5 employees), the United States (4 departments; 5 employees), and Australia (4 departments; 4 employees).
-	Top Countries by Total Salary Cost: Switzerland ($75,100), Italy ($52,100), Israel ($45,200), Argentina ($43,600), China ($42,400), Egypt ($41,600), Brazil ($38,000), Belgium ($33,600), Japan ($33,600), India ($32,800), and the United States ($31,600).
-	Smallest Payroll Footprints: United Kingdom ($2,200; 1 employee), France ($2,500; 1 employee), Zambia ($9,500; 2 employees), and Nigeria ($10,000; 1 employee).

## Recommendations
-	**Review manager span of control in Shipping and Sales: Shipping (45 staff under Adam Fripp) and Sales (34 staff under John Russell) carry heavy supervision loads**; adding team leads or assistant managers would prevent operational bottlenecks.
-	**Audit the 16 unstaffed departments**: Confirm whether departments like Recruiting, Payroll, Treasury, and IT Helpdesk are legacy placeholders to be archived or upcoming expansion units awaiting hiring.
-	**Benchmark Shipping and Purchasing pay bands**: With 45.8% of the company earning under $5,000 and Shipping averaging $3,476, HR should review entry-level pay against regional market rates to protect retention.
-	**Evaluate geographic payroll concentration**: Switzerland ($75,100) and Italy ($52,100) account for 18.4% of global payroll despite having only 18 staff combined; leadership should align regional headcount with revenue output across key hubs like the United States and Asia.

## Tools Used
-	**MySQL**: relational database schema creation (capstone), table querying, and data validation 
-	**SQL Analytical Techniques**: multi-table joins (INNER, LEFT, RIGHT), subqueries, Common Table Expressions (WITH), CASE statements, aggregate functions (COUNT, AVG, SUM), and window functions (ROW_NUMBER() OVER) 

## Conclusion 
Orion Data Systems maintains a well-structured workforce across **25** countries with zero unassigned job roles and a **$691,400** payroll. However, headcount is heavily concentrated in Shipping and Sales, 16 listed departments remain unstaffed, and wide pay gaps separate executive and operational teams. Balancing manager spans of control, cleaning up inactive departments, and reviewing entry-level compensation give HR and Strategy a clear path to stronger workforce efficiency.

