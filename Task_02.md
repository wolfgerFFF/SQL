Задание 1: Создание таблицы с жанрами книг
Создайте таблицу (сущность) с жанрами книг genres.
Перечень полей (атрибутов):
● id – числовой тип, автоинкремент, первичный ключ;
● name – строковый тип, обязательный к заполнению.
Заполните сущность genres данными

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

Задание 2: Создание таблицы с авторами
Создайте таблицу (сущность) с авторами authors.
Перечень полей (атрибутов):
● id – числовой тип, автоинкремент, первичный ключ;
● name – строковый тип, обязательный к заполнению.
Заполните сущность authors данными из таблицы books.
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);
INSERT INTO authors (name)
SELECT DISTINCT author
FROM books;
Задание 3: Добавление жанров и авторов в таблицу книг и вывод
книг по жанрам и авторам
Имеется таблица (сущность) с книгами books. У сущности имеются следующие поля
(атрибуты):
● id – идентификатор;
● title – название;
● author – автор;
● year – год издания;
● price – цена.
Создайте новые столбцы genre_id и author_id в таблице books и обновите
значения этих столбцов в соответствии с жанром и автором каждой книги:

--1. Добавление новых столбцов genre_id и author_id в таблицу books
ALTER TABLE books
ADD COLUMN genre_id INT,
ADD COLUMN author_id INT;
-- 2. Обновление genre_id в таблице books
UPDATE books
SET genre_id = (SELECT id FROM genres WHERE name = 'Художественная
литература')
WHERE title IN ('Убить пересмешника', '1984', 'Великий Гэтсби', 'Над
пропастью во ржи', 'Моби Дик');
UPDATE books
SET genre_id = (SELECT id FROM genres WHERE name = 'Нехудожественная
литература')
WHERE title IN ('Скотный двор', 'Почти на Каталонии');
UPDATE books
SET genre_id = (SELECT id FROM genres WHERE name = 'Детектив')
WHERE title = 'Собака Баскервилей';
UPDATE books
SET genre_id = (SELECT id FROM genres WHERE name = 'Биография')
WHERE title = 'Дневник Анны Франк';
UPDATE books
SET genre_id = (SELECT id FROM genres WHERE name = 'Наука')
WHERE title = 'Краткая история времени';
-- 3. Обновление author_id в таблице books
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Харпер Ли')
WHERE title = 'Убить пересмешника';
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Джордж
Оруэлл')
WHERE title IN ('1984', 'Скотный двор', 'Почти на Каталонии');
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Ф. Скотт
Фицджеральд')
WHERE title = 'Великий Гэтсби';
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Дж. Д.
Сэлинджер')
WHERE title = 'Над пропастью во ржи';
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Герман
Мелвилл')
WHERE title = 'Моби Дик';
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Артур Конан
Дойл')
WHERE title = 'Собака Баскервилей';
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Анна Франк')
WHERE title = 'Дневник Анны Франк';
UPDATE books
SET author_id = (SELECT id FROM authors WHERE name = 'Стивен
Хокинг')
WHERE title = 'Краткая история времени';
-- 4. Вывод названий книг, жанров и авторов
SELECT b.title AS book_title, g.name AS genre_name, a.name AS
author_name
FROM books b
JOIN genres g ON b.genre_id = g.id
JOIN authors a ON b.author_id = a.id;

Задание 4: Обновление цен на книги
Имеется таблица (сущность) с книгами books. У сущности имеются следующие поля
(атрибуты):
● id – идентификатор;
● title – название;
● author – автор;
● year – год издания;
● price – цена.
Необходимо увеличить цену на все книги, изданные до 2000 года, на 10%
UPDATE books
SET price = price * 1.10
WHERE year < 2000;

Задание 5: Выборка книг по средней цене жанра
Имеется таблица (сущность) с книгами books и таблица с жанрами genres. У
сущностей имеются следующие поля (атрибуты):
● books.id – идентификатор;
● books.title – название;
● books.author – автор;
● books.year – год издания;
● books.price – цена;
● books.genre_id – идентификатор жанра;
● genres.id – идентификатор;
● genres.name – название жанра.
Необходимо вывести название жанра и среднюю цену книг в этом жанре для жанров,
где средняя цена выше 300.
SELECT genres.name AS genre, AVG(books.price) AS average_price
FROM books
JOIN genres ON books.genre_id = genres.id
GROUP BY genres.name
HAVING AVG(books.price) > 300;
