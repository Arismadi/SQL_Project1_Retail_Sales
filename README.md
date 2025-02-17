# SQL_Project1_Retail_Sales
## Project Overview
#### Project Title : Retail Sales Analysis
#### Database : p1_retail_sales
#### Table : retail_sales
This project aims to demonstrate SQL skills and techniques in data analysis specifically to explore, clean, and analyze retail sales data. The project consisted of setting up a retail sales database, performing exploratory data analysis (EDA), and answering business questions through specific SQL queries.

## Project Objectives
#### 1) Set Up the Database :
Prepare a database for this project from previously available data
#### 2) Data Cleaning 
identify and delete null,missing values or duplicate data from database
#### 3) Exploratory Data Analysis (EDA) 
carry out data exploration to better understand the dataset
#### 4) Business Question Analysis
Using SQL queries to answer several business questions related to this retail sales project
## Project Structure
## 1) Database Set UP : 
+ **Database Creation** : The first step to start this project is create the database entitled **`p1_retail_db`**
+ **Tables Creation** : The table used in this project is entitled **`retail_sales`** which consists of several columns, such as ï»¿transactions_id, sale_date, sale_time,
customer_id, gender, age, category, quantity, price_per_unit, cogs,
total_sale.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    ï»¿transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(100),
    age INT,
    category VARCHAR(100),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
## 2) Data Exploration and Cleaning 
+ **Cleaning Data** : Find the null values from dataset and remove them.
```sql
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
```
+ **Find Unique Data** : Using distinct function to know is there any duplicates data from dataset
```sql
select count(*) from retail_sales; #How much data we have in dataset
select distinct category from retail_sales; #Find unique value in category dataset
select count(distinct category) from retail_sales; #Explore how much the kind of unique value in category dataset
# You can explore another column using this code by yourself
```
## 3) Exploration Data Analysis
This process is carried out by answering several questions related to the dataset with the aim of deepening understanding regarding the dataset
### 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
```sql
Select * from retail_sales 
where sale_date = "2022-11-05";
```
### 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 1 in the month of Nov-2022
```sql
select * from retail_sales 
where 
category = 'Clothing'
    AND 
    sale_date >= '2022-11-01' and sale_date <= '2022-12-01' # or DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' (we can use it)
    AND
    quantiy >= 4;
```
### 3. write a SQL query to calculate the total sales (total_sale) for each category.:
```sql
select category ,
sum(total_sale) as net_sale, 
count(*) as total_order
from retail_sales
group by category;
```
### 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
```sql
select 
	round(avg(age),2) as average_age
from retail_sales
where category ='Beauty';
```
### 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
```SQL
select *
	from retail_sales
where total_sale >= 1000;
```
### 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```SQL
select category,gender,
count(*) as total_trans
from retail_sales
group by category,gender
order by category;
```
### 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
```SQL
SELECT 
    year, month, avg_sales
FROM 
(
    SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
AVG(total_sale) AS avg_sales,
RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) desc) as ranked
FROM retail_sales 
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
where ranked = 1;
```

### 8. Write a SQL query to find the top 5 customers based on the highest total sales 
```sql
select customer_id, 
sum(total_sale) as net_sales
from retail_sales
group by customer_id
order by net_sales desc
limit 5;
```
### 9.Write a SQL query to find the number of unique customers who purchased items from each category.:
```sql
select category,
count(distinct customer_id) as cnt_customer
from retail_sales
group by category;
```
### 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
```sql
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
```

## **CONCLUSION**
This project is a form of direct application of the use of SQL for data analysis which consists of creating databases and tables, cleaning data, exploring and analyzing data, and answering several business questions using SQL queries. Through this project, it is hoped that we can improve our ability to process data using SQL and can help businesses make better decisions.

  




