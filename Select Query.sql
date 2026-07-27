--Show the name and price of every product.
SELECT product_name, base_price
FROM Products;

--Find all products priced above $500.
SELECT product_name, base_price
FROM Products
WHERE base_price > 500;

--Find products in category 7 (Home & Kitchen) priced under $100.
SELECT product_name, base_price
FROM Products
WHERE category_id = 7 AND base_price < 100;

--Find products made by Apple or Samsung.
SELECT product_name, brand
FROM Products
WHERE brand = 'Apple' OR brand = 'Samsung';

--Find all products that are NOT in the Books category (category_id 8).
SELECT product_name, category_id
FROM Products
WHERE NOT category_id = 8;

--Find products belonging to Mobile Phones, Laptops, or Electronics (category IDs 1, 2, 3).
SELECT product_name, category_id
FROM Products
WHERE category_id IN (1, 2, 3);

--Find products priced between $50 and $200.
SELECT product_name, base_price
FROM Products
WHERE base_price BETWEEN 50 AND 200;

--Find all products with "Pro" anywhere in the name.
SELECT product_name
FROM Products
WHERE product_name LIKE '%Pro%';

--Find all users with a Gmail address, regardless of case.
SELECT first_name, email
FROM Users
WHERE email ILIKE '%GMAIL%';

--List every unique brand sold on the platform.
SELECT DISTINCT brand
FROM Products;

--List all products from most expensive to cheapest.
SELECT product_name, base_price
FROM Products
ORDER BY base_price DESC;

--List order items sorted by order_id, and within each order, by quantity (highest first).
SELECT order_id, variant_id, quantity
FROM Order_Items
ORDER BY order_id ASC, quantity DESC;

--Find the 5 cheapest products.
SELECT product_name, base_price
FROM Products
ORDER BY base_price ASC
LIMIT 5;

--Show product names and prices, but label the columns "Item" and "Price ($)".
SELECT product_name AS "Item", base_price AS "Price ($)"
FROM Products;