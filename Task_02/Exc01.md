Задание 1: Создание таблицы с жанрами книг
```sql
-- Удаление таблицы, если она существует
DROP TABLE IF EXISTS genres;
-- Создание таблицы genres
CREATE TABLE genres (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);
-- Вставка данных в таблицу genres
INSERT INTO genres (name) VALUES
('Художественная литература'),
('Нехудожественная литература'),
('Детектив'),
('Биография'),
('Наука');
```
Задание 2: Создание таблицы с авторами
Создайте таблицу (сущность) с авторами authors.
Перечень полей (атрибутов):
● id – числовой тип, автоинкремент, первичный ключ;
● name – строковый тип, обязательный к заполнению.
Заполните сущность authors данными из таблицы books.

```sql
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);
INSERT INTO authors (name)
SELECT DISTINCT author
FROM books;
```
