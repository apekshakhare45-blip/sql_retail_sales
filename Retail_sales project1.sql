use sql_project_p1;

-- DATA OVERVIEW --
select * from retail_sales;

select * from retail_sales
limit 10;

select count(*) from retail_sales;

-- DATA CEANING --
select * from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

-- DATA EXPLORATION --
-- How many sales do we had?
select count(*) as total_sale from retail_sales;

-- How many unique customers do we have?
select count( distinct customer_id) from retail_sales;

-- How many categories do we have?
select distinct category from retail_sales;

-- Data Analysis & Bussiness Key Problems & Answers
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

-- END OF PROJECT--

