--01.Calculate the count of all grades in the system
SELECT COUNT(Grade) AS Total
FROM Grade

--02.Calculate the count of all grades per Teacher in the system
SELECT T.ID AS [Teacher ID], T.FirstName, T.LastName, COUNT(TeacherID) AS [Total grades]
FROM Grade G JOIN Teacher T
ON G.TeacherID = T.ID
GROUP BY  T.ID, T.FirstName, T.LastName
ORDER BY T.ID ASC

--03.Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT T.ID AS [Teacher ID], T.FirstName, T.LastName, COUNT(TeacherID) AS [Total grades]
FROM Grade G JOIN Teacher T
ON G.TeacherID = T.ID
WHERE G.StudentID <= 100
GROUP BY  T.ID, T.FirstName, T.LastName
ORDER BY T.ID ASC

--04.Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT G.StudentID, S.FirstName, S.LastName, Max(Grade) AS [Max grade], AVG(Grade) AS [Average grade]
FROM Grade G JOIN Student S
ON G.StudentID = S.ID
GROUP BY G.StudentID, S.FirstName, S.LastName
ORDER BY G.StudentID

-- 05.Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT T.ID AS [Teacher ID], T.FirstName, T.LastName, COUNT(TeacherID) AS [Total grades]
FROM Grade G JOIN Teacher T
ON G.TeacherID = T.ID
GROUP BY  T.ID, T.FirstName, T.LastName
HAVING COUNT(TeacherID) > 200
ORDER BY T.ID ASC

--06.Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
SELECT T.ID AS [Teacher ID], T.FirstName, T.LastName, COUNT(TeacherID) AS [Total grades]
FROM Grade G JOIN Teacher T
ON G.TeacherID = T.ID
WHERE G.StudentID <= 100
GROUP BY  T.ID, T.FirstName, T.LastName
HAVING COUNT(TeacherID) > 50
ORDER BY T.ID ASC

--07.Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
SELECT G.StudentID, S.FirstName, S.LastName, COUNT(Grade) AS [Grade count], Max(Grade) AS [Max grade], AVG(Grade) AS [Average grade]
FROM Grade G JOIN Student S
ON G.StudentID = S.ID
GROUP BY G.StudentID, S.FirstName, S.LastName
HAVING MAX(Grade) = AVG(Grade)
ORDER BY G.StudentID

--08.List Student First Name and Last Name next to the other details from previous query
SELECT S.FirstName, S.LastName, COUNT(Grade) AS [Grade count], Max(Grade) AS [Max grade], AVG(Grade) AS [Average grade]
FROM Grade G JOIN Student S
ON G.StudentID = S.ID
GROUP BY S.FirstName, S.LastName
HAVING MAX(Grade) = AVG(Grade)
ORDER BY S.FirstName