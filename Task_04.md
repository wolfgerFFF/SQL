Задание 1: Список всех книг с количеством заказов
Получите список всех книг вместе с именем автора, категорией и количеством заказов
каждой книги.
В результате запроса будут столбцы:
● product_name: название книги
● author: имя автора
● category_name: название категории
● order_count: количество заказов этой книги

SELECT
p.product_name,
p.author,
c.category_name,
COUNT(od.order_id) AS order_count
FROM
Products p
INNER JOIN
Categories c ON p.category_id = c.category_id
LEFT JOIN
OrderDetails od ON p.product_id = od.product_id
GROUP BY
p.product_name, p.author, c.category_name;

Задание 2: Заказы от определенных перевозчиков
Получите список всех заказов, разделив их на те, которые были доставлены
перевозчиком 'СДЕК', и те, которые были доставлены другими перевозчиками.
В результате запроса будут столбцы:
● order_id: идентификатор заказа
● customer_id: идентификатор клиента
● order_date: дата заказа
● shipper_name: имя перевозчика

SELECT
order_id,
customer_id,
order_date,
total_amount,
CASE
WHEN shipper_id = (SELECT shipper_id FROM Shippers WHERE
shipper_name = 'СДЕК')
THEN 'Доставлено СДЕК'
ELSE 'Доставлено другим перевозчиком'
END AS delivery_status
FROM
Orders;

Задание 3: Количество заказов у каждого клиента
Получите список всех клиентов и количество их заказов. Включите клиентов, которые
не делали заказов.
В результате запроса будут столбцы:
● customer_name: имя клиента
● order_count: количество заказов
SELECT
c.customer_name,
COUNT(o.order_id) AS order_count
FROM
Customers c
LEFT JOIN
Orders o ON c.customer_id = o.customer_id
GROUP BY
c.customer_name;

Задание 4: Клиенты без заказов
Получите список всех клиентов, которые ничего не заказывали.
В результате запроса будет один столбец:
● customer_name: имя клиента
SELECT c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

Задание 5: Заказы с высокой стоимостью
Создайте новую таблицу HighValueOrders, которая будет содержать заказы на
сумму более 500. Включите идентификатор заказа, идентификатор клиента и сумму
заказа.
В результате запроса будут столбцы:
● order_id: идентификатор заказа
● customer_id: идентификатор клиента
● total_amount: сумма заказа

-- 1. Создание таблицы HighValueOrders
CREATE TABLE HighValueOrders (
order_id INT,
customer_id INT,
total_amount DECIMAL(10, 2)
);
-- 2. Вставка данных в HighValueOrders
INSERT INTO HighValueOrders (order_id, customer_id, total_amount)
SELECT
order_id,
customer_id,
total_amount
FROM
Orders
WHERE
total_amount > 500;
-- Просмотр данных из таблицы HighValueOrders
SELECT * FROM HighValueOrders;

Задание 6: Анализ продаж книг по категориям
Получите список всех категорий книг с суммой продаж, средней ценой книги,
минимальной и максимальной ценой книги, а также количеством уникальных заказов.
Отсортируйте по сумме продаж в порядке убывания и ограничьте результат первыми 5
строками.
В результате запроса будут столбцы:
● category_name: название категории
● total_sales: общая сумма продаж
● avg_price: средняя цена книги
● min_price: минимальная цена книги
● max_price: максимальная цена книги
● unique_orders: количество уникальных заказов

SELECT
c.category_name,
SUM(od.quantity * p.price) AS total_sales,
AVG(p.price) AS avg_price,
MIN(p.price) AS min_price,
MAX(p.price) AS max_price,
COUNT(DISTINCT od.order_id) AS unique_orders
FROM
Categories c
JOIN
Products p ON c.category_id = p.category_id
JOIN
OrderDetails od ON p.product_id = od.product_id
GROUP BY
c.category_name
ORDER BY
total_sales DESC
LIMIT 5;
