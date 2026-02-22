--- Задача с книги "SQL: Быстрое погружение" (SQLite)

/* Нужно объединить таблицы "tracks" и "albums" через левое полное соединение и отобрать только те записи,
которые не имеют значения (NULL) под полем "Composer". В конце отсортировать записи по названию песни.*/


SELECT 
	t.TrackId,
	t.Composer,
	t.Name,
	a.AlbumId,
	a.Title
FROM 
	tracks AS t
LEFT OUTER JOIN 
	albums AS a
ON
	t.AlbumId = a.AlbumId 
WHERE 
	t.Composer IS NULL --- Only tracks without composer
ORDER BY
	t.Name ---Sort by track name


--- P.S. Сама база данных в файле sTunes.db этого репозитория
