create database sqlproject;

use sqlproject;

select * from online_retail;

alter table online_retail 
rename column ï»¿InvoiceNo to InvoiceNo;

alter table online_retail modify column InvoiceNo Varchar(30);

select invoiceno from online_retail;

select distinct(invoiceno) from online_retail;

update online_retail 
set invoiceno = replace(invoiceno, 'C', '')
where invoiceno like 'C%';

select invoiceno from online_retail where invoiceno like 'c%' and invoiceno like'C%';

select invoiceno from online_retail;

---------------------------------------------------

select count(stockcode) from online_retail where trim(stockcode)='' ;

select distinct(stockcode) from online_retail;

alter table online_retail modify Stockcode varchar(20);
----------------------------------------------------

select product from online_retail ;

select count(product) from online_retail where trim(description)='' ;

select * from online_retail where trim(description)='' ;

update online_retail 
set Product ='Unknown Product'
where trim(Product) = '' ; 

alter table online_retail 
rename column Description to Product;

alter table online_retail 
modify column Product varchar(50);

------------------------------------------------------------

select quantity from online_retail;

select distinct(quantity) from online_retail;

SELECT count(quantity) FROM online_retail where trim(quantity) = '';

alter table online_retail add column TransactionType Varchar(10) After Quantity;

Update online_retail
set TransactionType = case
when quantity > 0 then 'Sold'
else
'Returned'
end;

select * from online_retail;

-----------------------------------------------

select invoicedate from online_retail;

select invoicedate from online_retail where trim(invoicedate) = '';

UPDATE online_retail
SET InvoiceDate = STR_TO_DATE(InvoiceDate, '%d-%m-%Y');

----------------------------------------------------

select unitprice from online_retail;

select unitprice from online_retail where trim(unitprice) = '';

alter table online_retail
modify column UnitPrice double;

------------------------------------------------------

SELECT customerid from online_retail;

select count(customerid) from online_retail where trim(customerid) = '';

select distinct(invoiceno) from online_retail where  trim(customerid) = '' ;

select * from online_retail where invoiceno = 537240;
select * from online_retail where invoiceno = 540821;


update online_retail 
set CustomerId = 'Guest'
where trim(CustomerId) = '';

alter table online_retail 
modify column CustomerId varchar(20);

-----------------------------------------------------

select country from online_retail;

select distinct(country) from online_retail;

select count(country), country 
from online_retail 
group by country
order by count(country) desc
limit 1; 

select * from online_retail where trim(country) ='' or country = 'unspecified';

update online_retail 
set country = ( select max_country 
from ( select country as max_country 
from online_retail 
where trim(country) ='' or country = 'unspecified'
group by country
order by count(country) desc
limit 1) as max ); 

select * from online_retail;

-----------------------------------------------------------

UPDATE online_retail
SET Quantity = ABS(Quantity);

select * from online_retail where transactiontype = 'returned';

alter table online_retail add Column TotalPrice Int After UnitPrice;

Update online_retail 
set TotalPrice = Quantity * UnitPrice;

select * from online_retail;