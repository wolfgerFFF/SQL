Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10

DELIMITER $$ 

CREATE PROCEDURE even_numbers (IN count_number int, OUT result varchar(255))
BEGIN
  DECLARE i int DEFAULT 2;

  SET result = '';

  WHILE i < count_number DO
    SET result = CONCAT(result, CAST(i AS char), ' '); 
    SET i = i + 2;
  END WHILE;

END
$$

DELIMITER ;
