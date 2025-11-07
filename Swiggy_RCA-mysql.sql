-- Get monthly total orders for 2023 and 2024
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    COUNT(OrderID) AS total_orders
FROM orders_data
WHERE YEAR(OrderDate) IN (2023, 2024)
GROUP BY month
ORDER BY month;
##total  monthly orders for 2024
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS month,
    COUNT(DISTINCT o.OrderID) AS total_orders
FROM
    orders_data o
WHERE
    YEAR(o.OrderDate) = 2024
GROUP BY month
ORDER BY month;

##order by status(completed,cancelled,failed payment)
SELECT
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS month,
    o.status,
    COUNT(*) AS count_orders
FROM orders_data o
WHERE YEAR(o.OrderDate) = 2024
GROUP BY month, o.status
ORDER BY month, o.status;

##order per customer segment(new vs repeat,gender)
-- Step 1: Count total orders per customer
CREATE OR REPLACE VIEW customer_orders AS
SELECT
    CustomerID,
    COUNT(OrderID) AS total_orders
FROM orders_data
GROUP BY CustomerID;

-- Step 2: Classify as New vs Repeat
CREATE OR REPLACE VIEW customer_segment AS
SELECT
    c.CustomerID,
    c.Gender,
    CASE 
        WHEN co.total_orders = 1 THEN 'New'
        ELSE 'Repeat'
    END AS segment,
    co.total_orders
FROM customer_data c
JOIN customer_orders co
ON c.CustomerID = co.CustomerID;

##orders by month and status
CREATE OR REPLACE VIEW monthly_order_status AS
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    Status,
    COUNT(OrderID) AS TotalOrders
FROM orders_data
GROUP BY Month, Status
ORDER BY Month, Status;
##Restaurant_wise_orders
CREATE OR REPLACE VIEW restaurant_orders_monthly AS
SELECT
    o.RestaurantID,
    r.Name AS RestaurantName,
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    COUNT(o.OrderID) AS TotalOrders
FROM orders_data o
JOIN restaurant_data r ON o.RestaurantID = r.RestaurantID
GROUP BY o.RestaurantID, r.Name, Month
ORDER BY Month, TotalOrders DESC;
##delivery performance
CREATE OR REPLACE VIEW delivery_summary AS
SELECT
    d.DeliveryID,
    o.OrderID,
    DATE_FORMAT(d.DeliveryDate, '%Y-%m') AS Month,
    d.DeliveryStatus,
    TIMESTAMPDIFF(MINUTE, o.OrderDate, d.DeliveryDate) AS DeliveryTimeMinutes
FROM deliverytx_data d
JOIN orders_data o ON d.OrderID = o.OrderID;
##delivery performance
CREATE OR REPLACE VIEW delivery_summary AS
SELECT
    d.DeliveryID,
    o.OrderID,
    DATE_FORMAT(d.DeliveryDate, '%Y-%m') AS Month,
    d.DeliveryStatus,
    TIMESTAMPDIFF(MINUTE, o.OrderDate, d.DeliveryDate) AS DeliveryTimeMinutes
FROM deliverytx_data d
JOIN orders_data o ON d.OrderID = o.OrderID;

##RCA funnel analysis Jan2024-feb2024
-- Step 1A: Total orders per customer
CREATE OR REPLACE VIEW customer_orders AS
SELECT
    CustomerID,
    COUNT(OrderID) AS total_orders
FROM orders_data
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-02-29'
GROUP BY CustomerID;

-- Step 1B: New vs Repeat customers
CREATE OR REPLACE VIEW customer_segment AS
SELECT
    c.CustomerID,
    c.Gender,
    CASE 
        WHEN co.total_orders = 1 THEN 'New'
        ELSE 'Repeat'
    END AS Segment,
    co.total_orders
FROM customer_data c
JOIN customer_orders co
ON c.CustomerID = co.CustomerID;

##order by month and status
CREATE OR REPLACE VIEW monthly_orders_status AS
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    Status,
    COUNT(OrderID) AS TotalOrders
FROM orders_data
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-02-29'
GROUP BY Month, Status
ORDER BY Month, Status;
##restaurant performance(drop/growth)
CREATE OR REPLACE VIEW restaurant_orders_janfeb AS
SELECT
    o.RestaurantID,
    r.Name AS RestaurantName,
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    COUNT(o.OrderID) AS TotalOrders
FROM orders_data o
JOIN restaurant_data r ON o.RestaurantID = r.RestaurantID
WHERE o.OrderDate BETWEEN '2024-01-01' AND '2024-02-29'
GROUP BY o.RestaurantID, r.Name, Month
ORDER BY Month, TotalOrders DESC;
##delivery performance(delays/Cancellations)
CREATE OR REPLACE VIEW delivery_summary_janfeb AS
SELECT
    d.DeliveryID,
    o.OrderID,
    DATE_FORMAT(d.DeliveryDate, '%Y-%m') AS Month,
    d.DeliveryStatus,
    TIMESTAMPDIFF(MINUTE, o.OrderDate, d.DeliveryDate) AS DeliveryTimeMinutes
FROM deliverytx_data d
JOIN orders_data o ON d.OrderID = o.OrderID
WHERE d.DeliveryDate BETWEEN '2024-01-01' AND '2024-02-29';
##Cancellation per month
SELECT 
    Month,
    COUNT(DeliveryID) AS CancelledOrders
FROM delivery_summary_janfeb
WHERE DeliveryStatus = 'Canceled'
GROUP BY Month
ORDER BY Month;
##delivery failure /abandined/return 
SELECT 
    Month,
    DeliveryStatus,
    COUNT(DeliveryID) AS CountStatus
FROM delivery_summary_janfeb
WHERE DeliveryStatus IN ('Returned','Failed','Abandoned')
GROUP BY Month, DeliveryStatus
ORDER BY Month, DeliveryStatus;
##delivery time analysis(delivered only)
SELECT
    Month,
    ROUND(AVG(DeliveryTimeMinutes),2) AS AvgDeliveryTimeMinutes,
    MAX(DeliveryTimeMinutes) AS MaxDeliveryTimeMinutes,
    MIN(DeliveryTimeMinutes) AS MinDeliveryTimeMinutes
FROM delivery_summary_janfeb
WHERE DeliveryStatus = 'Delivered'
GROUP BY Month
ORDER BY Month;

##payment failures
CREATE OR REPLACE VIEW payment_summary_janfeb AS
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    PaymentMethod,
    COUNT(OrderID) AS TotalOrders,
    SUM(CASE WHEN Status != 'Completed' THEN 1 ELSE 0 END) AS FailedPayments
FROM orders_data
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-02-29'
GROUP BY Month, PaymentMethod;

