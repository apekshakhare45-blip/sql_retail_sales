# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.
5. ## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
CREATE DATABASE `sql_project_p1`;
Data imported from excel.

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:
-- Q.1 Write a SQL query to retrieve all coloumns for sales made om '2022-11-05'?
select * from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity said is more than 4 in the month of nov_2022.
select * from retail_sales
where category = 'clothing'
and quantity >= 4
and sale_date >= '2022-11-01'
and sale_date <  '2022-12-01';

-- Q.3 Write a SQL query to calculate the total sales for each category.
select category, sum(total_sale) from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customer who purchased items fromthe beauty category?
select round(avg(age),2) from retail_sales
where category = 'beauty';

-- Q.5 Write a SQL query to find all the transactions where total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender,count(transactions_id) as total_Sales
from retail_sales
group by category, gender
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select * from
   (select 
   year(sale_date) as year,
   month(sale_date)as month,
   avg(total_sale) as avg_sale,
   rank() over(partition by year(sale_date) order by avg(total_sale)desc) as rnk
   from retail_sales
   group by year(sale_date), month(sale_date)) as copy
where rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
select customer_id, sum(total_sale)
from retail_sales
group by customer_id
order by 2 desc
limit 5;
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id)
from retail_sales
group by category;
 
-- Q.10 Write SQL query to create each shift and number of orders.
with hourly_sales
as
(select *,
case
    when hour(sale_time) < 12 then "morning"
    when  hour(sale_time) between 12 and 17 then "afernoon"
    else "evening"
end as shift
from retail_sales)
select shift, count(*) as total_orders
from hourly_Sales
group by shift;

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

-- end--
