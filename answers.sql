-- Use the salesdb database
USE salesdb;

-- =========================================================
-- Question 1 : Achieving 1NF
-- ---------------------------------------------------------
-- Problem: ProductDetail table has a multi-valued column (Products).
-- Goal: Each row should represent ONE product for an order.
--
-- Steps:
-- 1. Create a new table ProductDetail_1NF with separate rows
--    for each product instead of comma-separated values.
-- 2. Insert the decomposed data.
-- =========================================================

-- 1. Create the normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID      INT,
    CustomerName VARCHAR(100),
    Product      VARCHAR(100)
);

-- 2. Insert one row per product
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe',  'Laptop'),
(101, 'John Doe',  'Mouse'),
(102, 'Jane Smith','Tablet'),
(102, 'Jane Smith','Keyboard'),
(102, 'Jane Smith','Mouse'),
(103, 'Emily Clark','Phone');

-- Optional: View the result
SELECT * FROM ProductDetail_1NF;


-- =========================================================
-- Question 2 : Achieving 2NF
-- ---------------------------------------------------------
-- Problem: OrderDetails table is in 1NF but not 2NF.
--          CustomerName depends only on OrderID
--          (partial dependency on a composite key OrderID+Product).
--
-- Goal: Split into:
--    a) Orders table (OrderID, CustomerName)
--    b) OrderItems table (OrderID, Product, Quantity)
-- so that every non-key column depends on the whole primary key.
-- =========================================================

-- a) Create Orders table
CREATE TABLE Orders_2NF (
    OrderID      INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- b) Create OrderItems table
CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- c) Insert unique orders into Orders_2NF
INSERT INTO Orders_2NF (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- d) Insert order-item details into OrderItems_2NF
INSERT INTO OrderItems_2NF (OrderID, Product, Quantity) VALUES
(101, 'Laptop',   2),
(101, 'Mouse',    1),
(102, 'Tablet',   3),
(102, 'Keyboard', 1),
(102, 'Mouse',    2),
(103, 'Phone',    1);

-- View the results
SELECT * FROM Orders_2NF;
SELECT * FROM OrderItems_2NF;
