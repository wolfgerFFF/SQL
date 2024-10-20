DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS books;
-- Создание таблицы books
CREATE TABLE books (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
year INT NOT NULL,
price DECIMAL(10, 2) NOT NULL -- Убрали UNSIGNED
);
-- Вставка данных в таблицу books
INSERT INTO books (title, author, year, price) VALUES
('Убить пересмешника', 'Харпер Ли', 1960, 300.00),
('1984', 'Джордж Оруэлл', 1949, 250.00),
('Великий Гэтсби', 'Ф. Скотт Фицджеральд', 1925, 200.00),
('Над пропастью во ржи', 'Дж. Д. Сэлинджер', 1951, 280.00),
('Моби Дик', 'Герман Мелвилл', 1851, 400.00),
('Скотный двор', 'Джордж Оруэлл', 1945, 220.00),
('Почти на Каталонии', 'Джордж Оруэлл', 1938, 180.00);
