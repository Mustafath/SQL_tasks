--- Ссылка на саму задачу (Интерактивный тренажер по SQL):
--- https://stepik.org/lesson/308891/step/15?unit=291017

/*Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за 2020 и 2019 год.
За 2020 год проданными считать те экземпляры, которые уже оплачены. Вычисляемые столбцы назвать Количество и Сумма.
Информацию отсортировать по убыванию стоимости.*/

/* Result:
+-----------------------+------------+---------+
| title                 | Количество | Сумма   |
+-----------------------+------------+---------+
| Братья Карамазовы     | 8          | 6247.20 |
| Мастер и Маргарита    | 6          | 4024.38 |
| Идиот                 | 5          | 2281.80 |
| Белая гвардия         | 3          | 1581.10 |
| Черный человек        | 2          | 1140.40 |
| Лирика                | 2          | 1037.98 |
| Игрок                 | 2          | 961.80  |
| Стихотворения и поэмы | 1          | 650.00  |
+-----------------------+------------+---------+ */

--- Code (option 1 - subquery, only output):
SELECT
    title,
    SUM(Количество) AS "Количество",
    SUM(Сумма) AS "Сумма"
FROM
    (SELECT
        book.title,
        COALESCE(SUM(buy_book.amount), 0) AS "Количество",
        COALESCE(SUM(buy_book.amount * book.price), 0.00) AS "Сумма"
    FROM
        book 
            LEFT JOIN buy_book USING(book_id)
            JOIN buy_step USING(buy_id)
    WHERE
        buy_step.step_id = 1 AND buy_step.date_step_end IS NOT NULL
    GROUP BY
        book.title

    UNION ALL

    SELECT
        book.title,
        COALESCE(SUM(buy_archive.amount), 0) AS "Количество",
        COALESCE(SUM(buy_archive.amount * buy_archive.price), 0.00) AS "Сумма"
    FROM
        buy_archive
            INNER JOIN book USING(book_id)
    GROUP BY
        book.title) AS temp
GROUP BY
    title
ORDER BY
    3 DESC;



--- Code (option 2 - temporary table, with saved report table):
CREATE TABLE temp_table AS 
    SELECT
        book.title,
        COALESCE(SUM(buy_book.amount), 0) AS "Количество",
        COALESCE(SUM(buy_book.amount * book.price), 0.00) AS "Сумма"
    FROM
        book 
            LEFT JOIN buy_book USING(book_id)
            JOIN buy_step USING(buy_id)
    WHERE
        buy_step.step_id = 1 AND buy_step.date_step_end IS NOT NULL
    GROUP BY
        book.title

    UNION ALL

    SELECT
        book.title,
        COALESCE(SUM(buy_archive.amount), 0) AS "Количество",
        COALESCE(SUM(buy_archive.amount * buy_archive.price), 0.00) AS "Сумма"
    FROM
        buy_archive
            INNER JOIN book USING(book_id)
    GROUP BY
        book.title;

CREATE TABLE sales_report AS
    SELECT
        title,
        SUM(Количество) AS "Количество",
        SUM(Сумма) AS "Сумма"
    FROM
        temp_table
    GROUP BY
        title
    ORDER BY
        3 DESC;
       
DROP TABLE temp_table;

ALTER TABLE sales_report COMMENT = "Таблица-отчёт по проданным экземплярам и выручке по каждой книге (2019-2020 годы вместе взятые)";

SELECT * FROM sales_report;
