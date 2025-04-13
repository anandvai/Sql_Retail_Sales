-- create table

CREATE TABLE retail_sales
(
	transactions_id	INT PRIMARY KEY ,
	sale_date	DATE,
	sale_time  TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(25),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT ,
	total_sale FLOAT

);

-- show the record of table

SELECT * FROM retail_sales;


-- count or verify the number of rows

SELECT COUNT(*) FROM retail_sales;


------------ Data cleaning ----------


-- check the null values in any columns
SELECT * FROM retail_sales
WHERE 
      transactions_id is null
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
	  quantiy is null
	  or
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null;
    




-- delete the record which have null value 
DELETE FROM retail_sales
WHERE 
      transactions_id is null
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
	  quantiy is null
	  or
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null;


-- Data	Exploration 

-- 1. how amny sales we have ?
select count(*)  as total_sales from retail_sales;



-- 2.how many unique we have ?

select count(distinct customer_id) as Total_unique_customer from retail_sales;


-- 3.how many distinct category product?
select distinct category as unique_category from retail_sales;


-- Data Analysis  & Business Problems & Answers



-- Q1.write a sql query to retrive all the columns for sales made on '2022-11-05'


select * from retail_sales
where sale_date = '2022-11-05';

-- Q2.write a sql query to retrive all transactions where the category is 'clothing ' and quantity sold is more than 10  in month  of  Nov-2022

select * from retail_sales;

select * from retail_sales
where category = 'clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantiy >= 2;

 
-- Q3.write a sql query to calculate total sales (total_sales) for each category;

select category ,
sum(total_sale) as Total_Sales ,
count(*) as Total_orders 
from  retail_sales
group by category 
order by Total_sales desc;


-- Q4.write a sql query to find the average age of customers who purchased items from the 'Beauty' category .

select round(avg(age),2) as Avg_sales 
from retail_sales
where category = 'Beauty';


-- Q5.write a sql query to find all tranctions  where the total_sales is greater than 1000.

select * from retail_sales  
where total_sale > 1000;

-- Q6.write a sql query to find the  total number  of tranction (transction_id) made by each gender in each category 

select category ,gender,count(transactions_id) as Total_tranaction from retail_sales
group by category,gender
order by 1;



-- Q7.write a sql query to calculate the average sales for each month and also find the best selling month in each year .




select Year,Months,avg_Sales from
(
select extract(year from  sale_date) as Year,
extract(month from sale_date) as Months,
avg(total_sale) as avg_Sales,
rank() over(partition by extract(year from sale_date) 
order by avg(total_sale) desc) as rank
from retail_sales
group by Year,Months) as t1
where rank = 1




-- Q8.write a sql query to find the top 5 customers  based on the highest total sales;
select * from retail_sales;



select customer_id,sum(total_sale) as Total_sales
from retail_sales
group by customer_id
order by Total_sales desc
limit 5;


-- Q9.write a sql query to find the number of unique customers who have purchased  items from each category
select * from retail_sales;


select category,
count(distinct customer_id)  as count_of_unique_customer
from retail_sales
group by category ;



-- Q10.write a sql query to create each shift and number of orders (example Morning  <=12 ,afternoon between 12 and 17 ,evening >17)
select * from retail_sales;


WITH hourly_sale	
as 
(
select *,
         CASE 
		     WHEN EXTRACT(HOUR FROM sale_time)  < 12 THEN 'Morning'
			 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			 ELSE 'Evening '
		  END as Shift
from retail_sales
)
SELECT shift,
       COUNT(*) AS Totals_orders
	   from hourly_sale
	   group by shift



-- End of project ---



  



