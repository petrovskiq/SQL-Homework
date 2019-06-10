--Homework requirement 1a/2
--Create new procedure called CreateGrade
--Procedure should create only Grade header info (not Grade Details) 
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)
--Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)


GO
CREATE PROCEDURE dbo.CreateGrade(@StudentID INT, @CourseID SMALLINT, @TeacherID SMALLINT, @Grade TINYINT, @CreatedDate DATETIME)
AS
BEGIN

INSERT INTO dbo.Grade (StudentID, CourseID, TeacherID, Grade, CreatedDate)
VALUES (@StudentID, @CourseID, @TeacherID, @Grade, @CreatedDate)

SELECT COUNT(*) AS TotalGradesForTheStudent
FROM dbo.Grade
WHERE StudentID = @StudentID

SELECT MAX(Grade) AS MaxGradeForTheStudent
FROM dbo.Grade
WHERE StudentID = @StudentID
AND TeacherID = @TeacherID
END

GO
EXECUTE dbo.CreateGrade 
@StudentID = 7, 
@CourseID = 7, 
@TeacherID = 79, 
@Grade = 10, 
@CreatedDate = '1999-07-06 00:00:00.000'


--Homework requirement 1b/2
--Create new procedure called CreateGradeDetail
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
--Output from this procedure should be resultset with SUM of GradePoints calculated with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade


GO
CREATE OR ALTER PROCEDURE dbo.CreateGradeDetail(@GradeID INT, @AchievementTypeID TINYINT, @AchievementPoints TINYINT, @AchievementMaxPoints TINYINT, @AchievementDate DATETIME)
AS
BEGIN
DECLARE @GradePoints DECIMAL(18,2)
BEGIN TRY
	INSERT INTO dbo.GradeDetails(GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
	VALUES (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)
END TRY
BEGIN CATCH
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SET @GradePoints =
(
	SELECT SUM(AchievementPoints / AchievementMaxPoints * A.ParticipationRate)
	FROM dbo.GradeDetails GD
	INNER JOIN dbo.AchievementType A ON A.ID = GD.AchievementTypeID
)

SELECT S.FirstName AS Name, S.LastName AS Surname, CONVERT(INT, @GradePoints) AS [Grade Points]
FROM dbo.GradeDetails GD
INNER JOIN Grade G ON G.ID = GD.GradeID
INNER JOIN Student S ON S.ID = G.StudentID
WHERE GD.GradeID = @GradeID

END
GO

EXECUTE dbo.CreateGradeDetail
@GradeID = 20122, 
@AchievementTypeID = 5, 
@AchievementPoints = 79, 
@AchievementMaxPoints = 100, 
@AchievementDate = '2002-02-24 00:00:00.000'


--Homework requirement 2/2
--Add error handling on CreateGradeDetail procedure
--Test the error handling by inserting not-existing values for AchievementTypeID


EXECUTE dbo.CreateGradeDetail
@GradeID = 20122, 
@AchievementTypeID = 15, 
@AchievementPoints = 79, 
@AchievementMaxPoints = 100, 
@AchievementDate = '2002-02-24 00:00:00.000'