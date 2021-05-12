USE AdventureWorks2019

Select * from Person.Person


CREATE TRIGGER upper_lastName
ON Person.Person
WITH ENCRYPTION
AFTER INSERT
AS
BEGIN
DECLARE @LastName VARCHAR(MAX)
SELECT @LastName = LastName FROM Person.Person
UPDATE  Person.Person SET LastName=UPPER(@LastName) WHERE LastName=@LastName
END
GO

INSERT INTO Person.Person(PersonType, FirstName, MiddleName, LastName) VALUES ('IN', 'Anna', 'K', 'Dmowska')