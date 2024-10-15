1.Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

CREATE FUNCTION sec_to_day(seconds INT) 
RETURNS VARCHAR(250)
DETERMINISTIC
BEGIN
  DECLARE result VARCHAR(250);
  DECLARE days INT DEFAULT 0;
  DECLARE hours INT DEFAULT 0;
  DECLARE minutes INT DEFAULT 0;

  -- считаем дни
  IF seconds >= 86400 THEN
    SET days = seconds DIV 86400;
    SET seconds = seconds % 86400;
  END IF;

  -- считаем часы
  IF seconds >= 3600 THEN
    SET hours = seconds DIV 3600;
    SET seconds = seconds % 3600; 
  END IF;

  -- считаем минуты / секунды
  IF seconds >= 60 THEN
    SET minutes = seconds DIV 60;
    SET seconds = seconds % 60;
  END IF;
  
  SET result = CONCAT(
                    CAST(days AS CHAR), ' дней ',
                    CAST(hours AS CHAR), ' час ',
                    CAST(minutes AS CHAR), ' минут ');

  SET result = CONCAT(result, CAST(seconds AS CHAR), ' сек.');
  
  RETURN result;
END;
