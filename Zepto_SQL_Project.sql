create table zepto(
sku_id Serial primary key,
category varchar(120),
name varchar(150) not null,
mrp numeric(8 ,2),
discountpercent numeric(5,2),
availableQuantity integer,
discountedsellingPrice numeric(8,2),
weightIngms integer,
outofstock boolean,
quantity integer
);

--data exploration

--count of rows
select count(*) from zepto;

--sample data
select * from zepto 
limit 10;

--null values
select * from zepto
where name is null
OR
category is null
OR
mrp is null
OR
discountpercent is null
OR
discountedsellingprice is null
OR
weightINgms is null
OR
availableQuantity is null
OR
outOfstock is null
OR
Quantity is null;

--different product categories
select distinct category
from zepto
order by category;

--products in stock vs out of stock
select outofstock,count(sku_id)
from zepto
GROUP by outOfstock;

--product names present multiple times
select name, count(sku_id) as "number of SKUs"
from zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

--data cleaning

--products with price = 0
select * from zepto
where mrp = 0 OR discountedsellingprice = 0;

delete from zepto
where mrp = 0;

--convert paise to rupees
update zepto
set mrp = mrp/100.0,
discountedsellingPrice = discountedsellingprice/100.0;

select mrp, discountedsellingprice from zepto;

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM zepto
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto;

--Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;