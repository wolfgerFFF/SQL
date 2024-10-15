Задание 1: Средний чек по заказам
Выведите средний чек (average_receipt) для заказов.
SELECT AVG(total_amount) AS average_receipt
FROM Orders;

Задание 2: Количество заказов по перевозчикам
Выведите имя перевозчика, месяц и год заказа, а также количество уникальных
заказов, доставленных каждым перевозчиком в каждый месяц и год.
SELECT
Shippers.shipper_name,
EXTRACT(YEAR FROM Orders.order_date) AS year,
EXTRACT(MONTH FROM Orders.order_date) AS month,
COUNT(DISTINCT Orders.order_id) AS unique_orders_count
FROM Orders
JOIN Shippers ON Orders.shipper_id = Shippers.shipper_id
GROUP BY
Shippers.shipper_name,
EXTRACT(YEAR FROM Orders.order_date),
EXTRACT(MONTH FROM Orders.order_date);

Задание 3: Продукты по цене
Выведите название и цену книг, которые стоят более 100 единиц. Отсортируйте
результат по цене в порядке убывания и ограничьте вывод 5 результатами.
SELECT
product_name,
price
FROM Products
WHERE price > 100
ORDER BY price DESC
LIMIT 5;

Задание 4: Количество заказов по категориям книг
Выведите категорию книг и количество заказов, которые содержат книги этой
категории. Показать только те категории, которые имеют больше одного заказа.
SELECT
Categories.category_name,
COUNT(DISTINCT Orders.order_id) AS order_count
FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
JOIN Categories ON Products.category_id = Categories.category_id
JOIN Orders ON OrderDetails.order_id = Orders.order_id
GROUP BY Categories.category_name
HAVING COUNT(DISTINCT Orders.order_id) > 1;

Задание 5: Сумма и количество заказов по клиентам
Выведите идентификатор клиента, имя клиента, сумму и количество его заказов.
Отсортируйте результат по идентификатору клиента.
SELECT
Customers.customer_id,
Customers.customer_name,
SUM(Orders.total_amount) AS total_amount,
COUNT(Orders.order_id) AS order_count
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
GROUP BY Customers.customer_id, Customers.customer_name
ORDER BY Customers.customer_id;
