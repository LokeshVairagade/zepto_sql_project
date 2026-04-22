# zepto_sql_project
## project Query

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

