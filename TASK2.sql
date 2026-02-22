--- Задача с книги "SQL: Быстрое погружение" (SQLite)

/* Table with information about workers with format:
EmployeeId  |  FullName  |  Age  |	BirthDate  |  CelebrationDate  |  Work experience		
*/


SELECT 
	EmployeeId,
	FirstName || " " || LastName AS "FullName", 
	STRFTIME("%Y-%m-%d", "now") - DATE(BirthDate) AS "Age",	
	DATE(BirthDate) AS "BirthDate", 
	STRFTIME("%Y", "now") || "-" || SUBSTR(STRFTIME("%d-%m-%Y", BirthDate, "start of month"), 1, 5)
		AS "CelebrationDate",	
	STRFTIME("%Y-%m-%d", "now") - DATE(HireDate) AS "Years in the Company" 
		
FROM	
	employees


--- P.S. Сама база данных в файле sTunes.db этого репозитория
