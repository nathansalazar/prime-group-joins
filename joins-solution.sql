
--1. Get all customers and their addresses.
SELECT "first_name", "last_name", "street", "city", "state", "zip", "address_type" FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id";

--2. Get all orders and their line items (orders, quantity and product).
SELECT "first_name", "last_name", "street", "city", "state", "zip", "order_date", "quantity", "description", "quantity"*"unit_price" AS "Order_Cost"
FROM "customers"
JOIN "addresses" ON "customers"."id" = "addresses"."customer_id"
JOIN "orders" ON "orders"."address_id"="addresses"."id"
JOIN "line_items" ON "orders"."id"="line_items"."order_id"
JOIN "products" ON "products"."id"="line_items"."product_id";

--3. Which warehouses have cheetos?
SELECT "warehouse", "warehouse"."id","warehouse_product"."warehouse_id", "warehouse_product"."product_id", "products"."id", "products"."description"
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_product"."warehouse_id"="warehouse"."id"
JOIN "products" ON "warehouse_product"."product_id"="products"."id"
WHERE "description"='cheetos';

--4. Which warehouses have diet pepsi?
SELECT "warehouse", "warehouse"."id","warehouse_product"."warehouse_id", "warehouse_product"."product_id", "products"."id", "products"."description"
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse_product"."warehouse_id"="warehouse"."id"
JOIN "products" ON "warehouse_product"."product_id"="products"."id"
WHERE "description"='diet pepsi';

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "first_name", "last_name",  COUNT("last_name") AS "Separate_Orders", SUM("quantity") AS "Total_Products_Ordered"
FROM "customers"
JOIN "addresses" ON "addresses"."customer_id"="customers"."id"
JOIN "orders" ON "orders"."address_id"="addresses"."id"
JOIN "line_items" ON "line_items"."order_id"="orders"."id"
GROUP BY "first_name", "last_name";

--6. How many customers do we have?
SELECT COUNT("id") FROM "customers";

--7. How many products do we carry
SELECT COUNT("id") FROM "products";

--8. What is the total available on-hand quantity of diet pepsi?
SELECT "description", SUM("on_hand") AS "In_Stock"
FROM "products" 
JOIN "warehouse_product" ON "products"."id"="warehouse_product"."product_id"
JOIN "warehouse" ON "warehouse"."id"="warehouse_product"."warehouse_id"
WHERE "description"='diet pepsi' GROUP BY "description";
