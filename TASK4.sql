--- Ссылка на саму задачу (Интерактивный тренажер по SQL):
--- https://stepik.org/lesson/308891/step/14?unit=291017

/*Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы.
Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде.
Название столбцов: Год, Месяц, Сумма.*/

/* Result:
+------+----------+---------+
| Год  | Месяц    | Сумма   |
+------+----------+---------+
| 2019 | February | 5626.30 |
| 2020 | February | 3309.37 |
| 2019 | March    | 6857.50 |
| 2020 | March    | 2131.49 |
+------+----------+---------+ */

--- Code:


/* SELECT запрос для получения данных по 2019 году */

SELECT
    YEAR(date_payment) AS "Год",
    MONTHNAME(date_payment) AS "Месяц",
    SUM(price * amount) AS "Сумма"
FROM
    buy_archive
GROUP BY 2, 1

UNION /* Объединяем результаты */

/* SELECT запрос для получения данных по 2020 году */

SELECT 
    YEAR(buy_step.date_step_end) AS "Год",
    MONTHNAME(buy_step.date_step_end) AS "Месяц",
    SUM(book.price * buy_book.amount) AS "Сумма"
FROM
    buy
        INNER JOIN buy_step USING(buy_id)
        INNER JOIN buy_book USING(buy_id)
        INNER JOIN book USING(book_id)
WHERE
    buy_step.step_id = 1 AND buy_step.date_step_end IS NOT NULL
GROUP BY 2, 1
ORDER BY 2, 1
