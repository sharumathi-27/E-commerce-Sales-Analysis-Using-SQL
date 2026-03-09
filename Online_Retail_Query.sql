select invoicedate, sum(totalprice) as revenue from online_retail
where transactiontype = 'returned' 
group by invoicedate 
order by revenue desc
limit 10;

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

