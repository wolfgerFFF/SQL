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
