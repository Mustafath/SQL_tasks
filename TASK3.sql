--- Задача с книги "SQL: Быстрое погружение" (SQLite)


/*Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книг),
написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде.
Самым популярным считать жанр, общее количество экземпляров книг которого на складе максимально.*/


/* Result:
  +-----------------------+------------------+------------+--------+--------+
  | title                 | name_author      | name_genre | price  | amount |
  +-----------------------+------------------+------------+--------+--------+
  | Белая гвардия         | Булгаков М.А.    | Роман      | 540.50 | 5      |
  | Братья Карамазовы     | Достоевский Ф.М. | Роман      | 799.01 | 3      |
  | Игрок                 | Достоевский Ф.М. | Роман      | 480.50 | 10     |
  | Идиот                 | Достоевский Ф.М. | Роман      | 460.00 | 10     |
  | Лирика                | Пастернак Б.Л.   | Поэзия     | 518.99 | 10     |
  | Мастер и Маргарита    | Булгаков М.А.    | Роман      | 670.99 | 3      |
  | Стихотворения и поэмы | Есенин С.А.      | Поэзия     | 650.00 | 15     |
  | Черный человек        | Есенин С.А.      | Поэзия     | 570.20 | 6      |
  +-----------------------+------------------+------------+--------+--------+ */

--- Code:

SELECT
    book.title,
    author.name_author,
    genre.name_genre,
    book.price,
    book.amount
FROM
    author
        INNER JOIN book ON author.author_id = book.author_id
        INNER JOIN genre ON genre.genre_id = book.genre_id
WHERE
    genre.name_genre IN (
        select
            genre.name_genre
        from 
            genre inner join book on genre.genre_id = book.genre_id
        group by
            genre.name_genre
        having
            sum(book.amount) = (
                select
                    sum(book.amount)
                from
                    genre inner join book on genre.genre_id = book.genre_id
                group by
                    genre.genre_id
                order by 1 DESC
                limit 1
            )
    )
ORDER BY
    book.title



--- P.S. Сама база данных в файле sTunes.db этого репозитория
