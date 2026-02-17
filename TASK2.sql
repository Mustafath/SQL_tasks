--- Задача с книги "SQL: Быстрое погружение" (SQLite)



/* Table with information about workers with format:
EmployeeId  |  FullName  |  Age	BirthDate  |  CelebrationDate  |  Work experience		
*/

SELECT 
	EmployeeId, 	--- Worker's id 
	FirstName || " " || LastName AS "FullName", 	--- Fullname of worker
	STRFTIME("%Y-%m-%d", "now") - DATE(BirthDate) AS "Age",	
	DATE(BirthDate) AS "BirthDate", 	--- Real birtday of worker
	STRFTIME("%Y", "now") || "-" || SUBSTR(STRFTIME("%d-%m-%Y", BirthDate, "start of month"), 1, 5)
		AS "CelebrationDate",	--- Celebration date (first day of month)
	STRFTIME("%Y-%m-%d", "now") - DATE(HireDate) AS "Years in the Company" ---Work experience (years)
		
FROM	
	employees


--- P.S. Сама база данных в файле sTunes.db этого репозитория
