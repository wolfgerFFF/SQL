Задание 1: Получение заказов по сотруднику
Создайте хранимую процедуру GetEmployeeOrders, которая принимает
идентификатор сотрудника в качестве параметра и возвращает все заказы,
обработанные этим сотрудником.
В результате запроса будут столбцы:
● order_id: идентификатор заказа
● order_date: дата заказа
● customer_name: имя клиента

CREATE PROCEDURE GetEmployeeOrders(IN emp_id INT)
BEGIN
SELECT
o.order_id,
o.order_date,
c.customer_name
FROM
Orders o
JOIN
Customers c ON o.customer_id = c.customer_id
WHERE
o.employee_id = emp_id;
END;
CALL GetEmployeeOrders(1);

Задание 2: Создание представления для суммы заказов по сотрудникам
Создайте представление EmployeeOrderSummary, которое покажет общую сумму
заказов для каждого сотрудника.
В результате запроса будут столбцы:
● employee_name: имя сотрудника
● total_sales: общая сумма заказов

CREATE VIEW EmployeeOrderSummary AS
SELECT
e.employee_name,
SUM(o.total_amount) AS total_sales
FROM
Employees e
JOIN
Orders o ON e.employee_id = o.employee_id
GROUP BY
e.employee_name;
SELECT * FROM EmployeeOrderSummary;

Задание 3: Использование оконных функций для ранжирования заказов
Ранжируйте заказы каждого сотрудника на основе суммы заказа (total_amount).
В результате запроса будут столбцы:
● employee_name: имя сотрудника
● order_id: идентификатор заказа
● total_amount: сумма заказа
● order_rank: ранг заказа по сумме для каждого сотрудника
SELECT
e.employee_name,
o.order_id,
o.total_amount,
RANK() OVER (PARTITION BY e.employee_id ORDER BY o.total_amount
DESC) AS order_rank
FROM
Employees e
JOIN
Orders o ON e.employee_id = o.employee_id;

Задание 4: Получение предыдущего и следующего заказа для каждого заказа
Используйте оконные функции для получения предыдущего и следующего заказа для
каждого заказа на основе даты заказа.
В результате запроса будут столбцы:
● order_id: идентификатор заказа
● order_date: дата заказа
● prev_order_date: дата предыдущего заказа
● next_order_date: дата следующего заказа

SELECT
order_id,
order_date,
LAG(order_date) OVER (ORDER BY order_date) AS prev_order_date,
LEAD(order_date) OVER (ORDER BY order_date) AS next_order_date
FROM
Orders;

Задание 5: Аналитические функции для среднего, минимального и
максимального значения заказов
Используйте оконные функции для получения среднего, минимального и
максимального значения суммы заказов для каждого сотрудника.
В результате запроса будут столбцы:
● employee_name: имя сотрудника
● order_id: идентификатор заказа
● total_amount: сумма заказа
● avg_amount: средняя сумма заказа для каждого сотрудника
● min_amount: минимальная сумма заказа для каждого сотрудника
● max_amount: максимальная сумма заказа для каждого сотрудника

SELECT
e.employee_name,
o.order_id,
o.total_amount,
AVG(o.total_amount) OVER (PARTITION BY e.employee_id) AS
avg_amount,
MIN(o.total_amount) OVER (PARTITION BY e.employee_id) AS
min_amount,
MAX(o.total_amount) OVER (PARTITION BY e.employee_id) AS
max_amount
FROM
Employees e
JOIN
Orders o ON e.employee_id = o.employee_id;

Задание 6: Комплексный анализ заказов
Создайте представление OrderAnalysis, которое будет содержать информацию о
каждом заказе, включая имя сотрудника, имя клиента, ранг заказа по сумме для
каждого сотрудника, среднюю, минимальную и максимальную сумму заказов для
каждого сотрудника, а также даты предыдущего и следующего заказов.
В результате запроса будут столбцы:
● employee_name: имя сотрудника
● customer_name: имя клиента
● order_id: идентификатор заказа
● total_amount: сумма заказа
● order_rank: ранг заказа по сумме для каждого сотрудника
● avg_amount: средняя сумма заказа для каждого сотрудника
● min_amount: минимальная сумма заказа для каждого сотрудника
● max_amount: максимальная сумма заказа для каждого сотрудника
● prev_order_date: дата предыдущего заказа
● next_order_date: дата следующего заказа

CREATE VIEW OrderAnalysis AS
SELECT
e.employee_name,
c.customer_name,
o.order_id,
o.total_amount,
RANK() OVER (PARTITION BY e.employee_id ORDER BY o.total_amount
DESC) AS order_rank,
AVG(o.total_amount) OVER (PARTITION BY e.employee_id) AS
avg_amount,
MIN(o.total_amount) OVER (PARTITION BY e.employee_id) AS
min_amount,
MAX(o.total_amount) OVER (PARTITION BY e.employee_id) AS
max_amount,
LAG(o.order_date) OVER (ORDER BY o.order_date) AS
prev_order_date,
LEAD(o.order_date) OVER (ORDER BY o.order_date) AS
next_order_date
FROM
Employees e
JOIN
Orders o ON e.employee_id = o.employee_id
JOIN
Customers c ON o.customer_id = c.customer_id;
SELECT * FROM OrderAnalysis;


