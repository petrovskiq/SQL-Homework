create table Student
(
ID smallint identity(1,1) not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
DateOfBirth date not null,
EnrolledDate date not null,
Gender char not null,
NationalIDNumber int not null,
StudentCardNumber nvarchar(20) not null
);

create table Teacher(
ID smallint not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
DateOfBirth date not null,
AcademicRank nvarchar(50) not null,
HireDate date not null
);

create table Grade(
ID int not null,
StudentID int not null,
CourseID smallint not null,
TeacherID smallint not null,
Grade tinyint not null,
Comment nvarchar(100) null,
CreatedDate date not null
);


create table Course(
ID smallint not null,
Name nvarchar(50) not null,
Credit tinyint not null,
AcademicYear date not null,
Semester tinyint not null
);

create table AchievementType(
ID int not null,
Name nvarchar(50) not null,
Description nvarchar(250) not null,
ParticipationRate nvarchar(150) not null
);

create table GradeDetails(
ID int not null,
GradeID smallint not null,
AchievementTypeID smallint not null,
AchievementPoints int not null,
AchievementMaxPoints int not null,
AchievementDate date null,
);