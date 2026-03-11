# 1. Total Revenue from All Sales 
SELECT SUM(TotalPrice) AS Total_Revenue 
FROM online_retail 
WHERE TransactionType = 'Sold'; 

# 2.Total Returns Value 
SELECT round(SUM(TotalPrice)) AS Total_Returns 
FROM online_retail WHERE TransactionType = 'Returned'; 

# 3.Country with Highest Sales 
SELECT Country, SUM(TotalPrice) AS Total_Sales 
FROM online_retail WHERE TransactionType = 'Sold' 
GROUP BY Country ORDER BY Total_Sales DESC LIMIT 5;

# 4. Net Revenue 
SELECT 
SUM(CASE WHEN TransactionType = 'Sold' THEN TotalPrice ELSE 0 END) - 
SUM(CASE WHEN TransactionType = 'Returned' THEN TotalPrice ELSE 0 END) AS Net_Revenue 
FROM online_retail; 

# 5. Country with Highest Returns 
SELECT Country, SUM(Totalprice) AS Total_Returns FROM online_retail 
WHERE Transactiontype = 'Returned' GROUP BY Country ORDER BY Total_Returns desC LIMIT 5; 

# 6. Top-Selling Product (by Revenue) 
SELECT Product, SUM(TotalPrice) AS Revenue FROM online_retail 
WHERE Transactiontype = 'Sold' 
GROUP BY Product ORDER BY Revenue DESC LIMIT 5; 

# 7. Most Returned Product 
SELECT Product, SUM(Quantity) AS Total_Returned FROM online_retail 
WHERE TransactionType = 'Returned' 
GROUP BY Product ORDER BY Total_Returned desc LIMIT 5;

# 8. Monthly Sales Trend 
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, 
SUM(TotalPrice) AS Monthly_Sales FROM online_retail 
WHERE Transactiontype = 'Sold' GROUP BY Year, Month ORDER BY Year, Month; 

# 9. Monthly Returns Trend 
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(TotalPrice) AS Monthly_Sales 
FROM online_retail WHERE Transactiontype = 'Returned' 
GROUP BY Year, Month ORDER BY Year, Month; 

# 10. Customers with Most Returns 
SELECT CustomerID, SUM(totalprice) AS Customer_Returns FROM online_retail 
WHERE Transactiontype = 'Sold' 
GROUP BY CustomerID 
ORDER BY Customer_Returns desc; 

# 11. Total Quantity Sold vs Returned 
SELECT SUM(CASE WHEN Transactiontype = 'Sold' THEN Quantity ELSE 0 END) AS Total_Sold, 
SUM(CASE WHEN Transactiontype = 'Returned' THEN Quantity ELSE 0 END) AS Total_Returned FROM online_retail; 

# 12. Top 5 Products Contributing to Losses (High Returns) 
SELECT Product, SUM(Totalprice) AS Loss FROM online_retail 
WHERE Transactiontype = 'Returned' 
GROUP BY Product ORDER BY Loss desc LIMIT 5; 

# 13. Products with Seasonal Trends 
SELECT Product, MONTH(InvoiceDate) AS Month, SUM(Quantity) AS Total_Sold 
FROM online_retail WHERE TransactionType = 'Sold' 
GROUP BY Product, Month ORDER BY Month, Total_Sold DESC; 

# 14. Total sales on Month wise 
SELECT MONTH(InvoiceDate) AS Month, SUM(Quantity) AS Total_Sold FROM online_retail
WHERE TransactionType = 'Sold' 
GROUP BY Month 
ORDER BY Month, Total_Sold DESC; 

# 15. Highest Revenue Days 
SELECT InvoiceDate, SUM(TotalPrice) AS Daily_Revenue FROM online_retail 
WHERE TransactionType = 'Sold' 
GROUP BY InvoiceDate 
ORDER BY Daily_Revenue DESC LIMIT 10; 

# 16. Returned Items Revenue Days 
select invoicedate, sum(totalprice) as revenue from online_retail 
where transactiontype = 'returned' 
group by invoicedate 
order by revenue desc limit 10;

# 17. Least revenue days
SELECT InvoiceDate,
       SUM(CASE WHEN TransactionType = 'Returned' THEN -TotalPrice
		ELSE TotalPrice END) AS Revenue
FROM online_retail
GROUP BY InvoiceDate
ORDER BY revenue asc
LIMIT 10;

# 18. Average Purchase Value per Customer
SELECT CustomerID, round(AVG(TotalPrice)) AS Avg_Purchase_Value
FROM online_retail
WHERE TransactionType = 'Sold'
GROUP BY CustomerID
ORDER BY Avg_Purchase_Value DESC
LIMIT 10;

# 19. Sales VS Returned Ration
SELECT Product, ROUND(
           SUM(CASE WHEN TransactionType = 'Returned' THEN Quantity ELSE 0 END) / 
           SUM(CASE WHEN TransactionType = 'Sold' THEN Quantity ELSE 0 END) * 100) AS Return_Rate
FROM online_retail
GROUP BY Product
ORDER BY Return_Rate DESC
LIMIT 10;


# 20. Customer Retention / Repeat Buyers
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Num_Orders
FROM online_retail
WHERE Transactiontype = 'Sold'
GROUP BY CustomerID
ORDER BY Num_Orders DESC
LIMIT 10;

# 21. Top 5 Countries by Net Revenue
SELECT Country, SUM(Totalprice) AS Net_Revenue
FROM online_retail
GROUP BY Country
ORDER BY Net_Revenue DESC
LIMIT 5;

# 22. Net Revenue Per Day
SELECT InvoiceDate,
       SUM(CASE WHEN TransactionType = 'Sold' THEN TotalPrice ELSE 0 END) -
       SUM(CASE WHEN TransactionType = 'Returned' THEN TotalPrice ELSE 0 END) AS Net_Revenue
FROM online_retail
GROUP BY InvoiceDate
ORDER BY Net_Revenue DESC
LIMIT 10;

# 23. Daily Sales vs Returns Analysis / Daily Revenue Summary
SELECT 
    InvoiceDate,
    SUM(CASE WHEN TransactionType = 'Sold' THEN TotalPrice ELSE 0 END) AS Total_Sales,
    SUM(CASE WHEN TransactionType = 'Returned' THEN TotalPrice ELSE 0 END) AS Total_Returns,
    SUM(CASE WHEN TransactionType = 'Sold' THEN TotalPrice 
             WHEN TransactionType = 'Returned' THEN -TotalPrice 
             ELSE 0 END) AS Net_Revenue
FROM online_retail
GROUP BY InvoiceDate
ORDER BY Net_Revenue DESC;  -- highest revenue first

