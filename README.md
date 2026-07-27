# Task-3-Writing-Basic-SELECT-Queries
## Tech stack

- **PostgreSQL** (developed and tested using pgAdmin)

## Schema overview

| Table | Purpose |
|---|---|
| `Users` | Registered customer accounts |
| `User_Addresses` | Shipping/billing addresses linked to a user |
| `Categories` | Product categories, supports nested sub-categories |
| `Products` | Base product info (name, brand, category) |
| `Product_Variants` | Size/color/SKU-level variants of a product |
| `Orders` | Customer orders, linked to a shipping address |
| `Order_Items` | Line items within an order, referencing a specific variant |
| `Inventory` | Stock quantity per variant, one row per variant |

**refer the link for database and tables:**

## Practice queries: SQL fundamentals

A set of 15 single-table queries covering `SELECT`, `WHERE`, comparison/logical operators, `DISTINCT`, sorting, and aliasing. No joins — each query runs against one table only.

<details>
<summary><b>1. Show the name and price of every product</b></summary>

```sql
SELECT product_name, base_price
FROM Products;
```
</details>

<details>
<summary><b>2. Find all products priced above $500</b></summary>

```sql
SELECT product_name, base_price
FROM Products
WHERE base_price > 500;
```
</details>

<details>
<summary><b>3. Find products in category 7 (Home & Kitchen) priced under $100</b></summary>

```sql
SELECT product_name, base_price
FROM Products
WHERE category_id = 7 AND base_price < 100;
```
</details>

<details>
<summary><b>4. Find products made by Apple or Samsung</b></summary>

```sql
SELECT product_name, brand
FROM Products
WHERE brand = 'Apple' OR brand = 'Samsung';
```
</details>

<details>
<summary><b>5. Find all products that are NOT in the Books category</b></summary>

```sql
SELECT product_name, category_id
FROM Products
WHERE NOT category_id = 8;
```
</details>

<details>
<summary><b>6. Find products belonging to Mobile Phones, Laptops, or Electronics</b></summary>

```sql
SELECT product_name, category_id
FROM Products
WHERE category_id IN (1, 2, 3);
```
</details>

<details>
<summary><b>7. Find products priced between $50 and $200</b></summary>

```sql
SELECT product_name, base_price
FROM Products
WHERE base_price BETWEEN 50 AND 200;
```
</details>

<details>
<summary><b>8. Find all products with "Pro" anywhere in the name</b></summary>

```sql
SELECT product_name
FROM Products
WHERE product_name LIKE '%Pro%';
```
</details>

<details>
<summary><b>9. Find all users with a Gmail address, regardless of case</b></summary>

```sql
SELECT first_name, email
FROM Users
WHERE email ILIKE '%GMAIL%';
```
</details>

<details>
<summary><b>10. List every unique brand sold on the platform</b></summary>

```sql
SELECT DISTINCT brand
FROM Products;
```
</details>

<details>
<summary><b>11. List all products from most expensive to cheapest</b></summary>

```sql
SELECT product_name, base_price
FROM Products
ORDER BY base_price DESC;
```
</details>

<details>
<summary><b>12. Sort order items by order_id, and within each order, by quantity (highest first)</b></summary>

```sql
SELECT order_id, variant_id, quantity
FROM Order_Items
ORDER BY order_id ASC, quantity DESC;
```
</details>

<details>
<summary><b>13. Find the 5 cheapest products</b></summary>

```sql
SELECT product_name, base_price
FROM Products
ORDER BY base_price ASC
LIMIT 5;
```
</details>

<details>
<summary><b>14. Show product names and prices with friendly column labels</b></summary>

```sql
SELECT product_name AS "Item", base_price AS "Price ($)"
FROM Products;
```
</details>

<details>
<summary><b>15. Find the top 3 most expensive Electronics-category products, with friendly column names</b></summary>

```sql
SELECT product_name AS "Product", base_price AS "Price"
FROM Products
WHERE category_id = 1
ORDER BY base_price DESC
LIMIT 3;
```
</details>

### Key concepts explained

**Most commonly confused:**

- **`WHERE NOT` vs `!=`** — `WHERE NOT category_id = 8` and `WHERE category_id != 8` return the same result, but `NOT` is a logical operator that can negate an entire condition (including combinations with `AND`/`OR`), while `!=` only negates a single equality check. Beginners often assume they're always interchangeable, but `NOT (condition1 AND condition2)` behaves differently from `NOT condition1 AND NOT condition2` (this is De Morgan's law in action).
- **`LIKE` vs `ILIKE`** — `LIKE` is case-sensitive, `ILIKE` is not. `WHERE email LIKE '%gmail%'` would miss `John@GMAIL.com`, but `ILIKE` would catch it. This trips people up because MySQL's `LIKE` is case-insensitive by default, but PostgreSQL's is not — a common surprise for anyone switching between databases.
- **`IN` vs chained `OR`** — `WHERE category_id IN (1, 2, 3)` and `WHERE category_id = 1 OR category_id = 2 OR category_id = 3` produce identical results. `IN` is just cleaner syntax, not a different operation — useful to know so you don't treat them as separate concepts.
- **`ORDER BY` with multiple columns** — the sort order depends on column position: `ORDER BY order_id ASC, quantity DESC` sorts all rows by `order_id` first, and only sorts by `quantity` *within* rows that share the same `order_id`. It does not sort by quantity first.
- **Aliases (`AS`) don't exist yet when `WHERE` runs** — a frequent beginner mistake is writing `WHERE "Price ($)" > 100` expecting the alias to work in `WHERE`. Aliases are applied when the row is displayed, which happens after `WHERE` filters rows — so you must repeat the original column name in `WHERE`.

**Most important to master:**

- **Execution order, not written order** — SQL is written as `SELECT → FROM → WHERE → ORDER BY → LIMIT`, but the database actually processes it as `FROM → WHERE → SELECT → ORDER BY → LIMIT`. Understanding this explains why aliases can't be used in `WHERE` but can be used in `ORDER BY`.
- **`WHERE` filters rows, not columns** — a very common early confusion is thinking `SELECT` "picks" the data and `WHERE` further narrows what's already picked. In reality `WHERE` decides which *rows* qualify, before `SELECT` decides which *columns* of those rows to display.
- **`LIMIT` without `ORDER BY` is unreliable** — `LIMIT 5` on its own returns *some* 5 rows, but without `ORDER BY` there's no guarantee which 5, or in what order, since PostgreSQL doesn't promise a default row order. Always pair `LIMIT` with `ORDER BY` when a specific result is expected (as in queries 13 and 15 above).
