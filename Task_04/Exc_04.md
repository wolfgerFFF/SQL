Задание 1: Список всех книг с количеством заказов
Получите список всех книг вместе с именем автора, категорией и количеством заказов
каждой книги.

```sql
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
```
Задание 2: Заказы от определенных перевозчиков
Получите список всех заказов, разделив их на те, которые были доставлены
перевозчиком 'СДЕК', и те, которые были доставлены другими перевозчиками.
В результате запроса будут столбцы:
● order_id: идентификатор заказа
● customer_id: идентификатор клиента
● order_date: дата заказа
● shipper_name: имя перевозчика

```sql
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
```
Задание 3: Количество заказов у каждого клиента
Получите список всех клиентов и количество их заказов. Включите клиентов, которые
не делали заказов.

```sql
SELECT
c.customer_name,
COUNT(o.order_id) AS order_count
FROM
Customers c
LEFT JOIN
Orders o ON c.customer_id = o.customer_id
GROUP BY
c.customer_name;
```
Задание 4: Клиенты без заказов
Получите список всех клиентов, которые ничего не заказывали.
В результате запроса будет один столбец:
● customer_name: имя клиента

```sql
SELECT c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```
Задание 5: Заказы с высокой стоимостью
Создайте новую таблицу HighValueOrders, которая будет содержать заказы на
сумму более 500. Включите идентификатор заказа, идентификатор клиента и сумму
заказа.
В результате запроса будут столбцы:
● order_id: идентификатор заказа
● customer_id: идентификатор клиента
● total_amount: сумма заказа

```sql
CREATE TABLE HighValueOrders (
order_id INT,
customer_id INT,
total_amount DECIMAL(10, 2)
);
INSERT INTO HighValueOrders (order_id, customer_id, total_amount)
SELECT
order_id,
customer_id,
total_amount
FROM
Orders
WHERE
total_amount > 500;
SELECT * FROM HighValueOrders;
```


