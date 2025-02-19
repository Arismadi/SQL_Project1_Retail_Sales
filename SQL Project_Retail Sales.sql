select *
from retail_Sales;

select Count(*)
from retail_Sales;

# 2. Data Cleaning and Exploriation
# Delete the duplicate data
select count(distinct customer_id) from retail_Sales;
select count(distinct cogs) from retail_Sales; 


#Find the null values
select * 
from retail_Sales 
where ï»¿transactions_id is null  or sale_date is null 
or sale_time is null or customer_id is null or gender is null 
or age is null or category is null or quantiy is null 
or price_per_unit is null or cogs is null or total_sale is null;

# Deleted the null data
Delete from retail_Sales
where ï»¿transactions_id is null  or sale_date is null 
or sale_time is null or customer_id is null or gender is null 
or age is null or category is null or quantiy is null 
or price_per_unit is null or cogs is null or total_sale is null;


-- Data Exploration 
-- how many sales we have?
select count(total_sale) from retail_sales;

-- -- how many unique customer and category we have?
select count( distinct customer_id )from retail_sales; 

select count(distinct category) from retail_sales;
select distinct category from retail_sales; # Menampilkan jenis categorynya

-- We can explore with our self using another data in dataset


-- 3. Data Analyst and aswer the question from the manager
-- THE QUESTION
-- 1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
-- 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
-- 3 Write a SQL query to calculate the total sales (total_sale) for each category.:
-- 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
-- 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
-- 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
-- 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
-- 8 Write a SQL query to find the top 5 customers based on the highest total sales
-- 9 Write a SQL query to find the number of unique customers who purchased items from each category.:
-- 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

-- ANSWER NOMOR 1  Write a SQL query to retrieve all columns for sales made on '2022-11-05:
Select * from retail_sales 
where sale_date = "2022-11-05";

-- ANSWER NOMOR 2  Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 1 in the month of Nov-2022:
select * from retail_sales 
where 
category = 'Clothing'
    AND 
    sale_date >= '2022-11-01' and sale_date <= '2022-12-01' #or DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantiy >= 4;

-- Answer no 3 write a SQL query to calculate the total sales (total_sale) for each category.:
select category ,
sum(total_sale) as net_sale, 
count(*) as total_order
from retail_sales
group by category;

-- No 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select 
	round(avg(age),2) as average_age
from retail_sales
where category ='Beauty';

-- No 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *
	from retail_sales
where total_sale >= 1000;

-- No 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,
count(*) as total_trans
from retail_sales
group by category,gender
order by category;

-- No 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    year, month, avg_sales
FROM 
(
    SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_sales,
RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) desc)
FROM retail_sales 
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
limit 1;

-- No 8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, 
sum(total_sale) as net_sales
from retail_sales
group by customer_id
order by net_sales desc
limit 5;

-- 9 Write a SQL query to find the number of unique customers who purchased items from each category.:
select category,
count(distinct customer_id) as cnt_customer
from retail_sales
group by category;

-- 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale as
(select *,
	CASE
    when EXTRACT(HOUR FROM sale_time) < 12 then "Morning"
    when EXTRACT(HOUR FROM sale_time) between 12 and 17 then "Afternoon"
    else "Evening"
end as shift
from retail_sales
)
select shift, count(*) as total_Order
from hourly_sale
group by shift; 


























 