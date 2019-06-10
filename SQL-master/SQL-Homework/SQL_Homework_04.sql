-------------------------------------------------------------------------------------------------------------
--Homework requirement 1/3
--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students having FirstName same as the variable
--Declare table variable that will contain StudentId, StudentName and DateOfBirth
--Fill the table variable with all Female students
--Declare temp table that will contain LastName and EnrolledDate columns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve the students from the table which last name is with 7 characters
--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName and LastName are the same
-------------------------------------------------------------------------------------------------------------

declare @FirstName nvarchar(20)
set @FirstName = 'Antonio'

select *
from Student
where FirstName = @FirstName
go

declare @FemaleSt table
(StudentID int, StudentName nvarchar(20), DateOfBirth date)

insert into @FemaleSt
select ID, FirstName, DateOfBirth
from Student
where Gender='f'

select *
from @FemaleSt
go

create table #MaleStudentsA
(LastName nvarchar(20), EnrollDate date)

insert into #MaleStudentsA
select LastName,EnrolledDate
from Student
where Gender='m' and FirstName like 'A%'

select *
from #MaleStudentsA
where len(LastName)=7
go

-------------------------------------------------------------------------------------------------------------
--Homework requirement 2/3
--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:
--StudentCardNumber without “sc-”
--“ – “
--First character of student FirstName
--“.”
--Student LastName
-------------------------------------------------------------------------------------------------------------

create function dbo.fn_FormatStudentName(@StudentId int)
returns nvarchar(2000)
as
begin

declare @Result nvarchar(2000)

select @Result = SUBSTRING(StudentCardNumber, 4, 5) + ' - ' + LEFT(FirstName, 3) + '.' + LastName
from Student
where ID=@StudentId

return @Result
end
go

select *,dbo.fn_FormatStudentName(1) as [Function outcome]
from Student
where ID=1
go

-------------------------------------------------------------------------------------------------------------
--Homework requirement 3/3
--Create multi-statement table value function that for specific Teacher and Course will return list 
--of students (FirstName, LastName) who passed the exam, together with Grade and CreatedDate
-------------------------------------------------------------------------------------------------------------

create function dbo.fn_StudentsWhoPassed (@TeacherID int, @CourseID int)
returns @TableResult table 
(FirstName nvarchar(20), LastName nvarchar(20), Grade int, CreatedDate datetime)
as 
begin

insert into @TableResult
select S.FirstName as StudentsFirstName, S.LastName as StudentsLastName, Grade, CreatedDate as CreatedDate
from Grade G
inner join Teacher T on t.ID=g.TeacherID
inner join Course C on c.ID=g.CourseID
inner join Student S on s.ID=g.StudentID
where t.ID=@TeacherID and c.ID=CourseID
group by s.FirstName,s.LastName,Grade,CreatedDate
order by Grade

return
end

go

declare @TeacherID int
set @TeacherID=7

declare @CourseID int
set @CourseID=7

select *
from dbo.fn_StudentsWhoPassed(@TeacherID, @CourseID)