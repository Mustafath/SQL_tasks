--- Задача с книги "SQL: Быстрое погружение" (SQLite)
/* Нужно объединить таблицы "tracks" и "albums" через левое полное соединение и отобрать только те записи,
которые не имеют значения (NULL) под полем "Composer". В конце отсортировать записи по названию песни.*/



/*
1) LEFT JOIN "tracks" TABLE WITH "albums" TABLE  
AND 
2) SELECT TRACKS WITHOUT VALUE ON "Composer" COLUMN 
AND 
3) SORT BY TRACK NAME (ASCENDING)
*/

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


--- P.S. Файл самой базы данных в файле sTunes.db этого репозитория
