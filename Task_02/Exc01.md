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
