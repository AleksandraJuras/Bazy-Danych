USE AdventureWorks2019

--1. Blok anonimowy
BEGIN
DECLARE @mean AS INT
Select @mean = AVG(Rate) From HumanResources.EmployeePayHistory
PRINT 'The avarage rate is: ' + CAST(@mean AS VARCHAR(10))
SELECT Person.*, Rate FROM HumanResources.EmployeePayHistory
INNER JOIN Person.Person ON Person.BusinessEntityID = EmployeePayHistory.BusinessEntityID WHERE Rate < @mean
END

--2. Funkcja zwracjaca date ostatniego zamowienia
CREATE FUNCTION dbo.OrderDate(@par INT)

RETURNS DATE
AS
BEGIN RETURN (SELECT ShipDate FROM [AdventureWorks2019].Purchasing.PurchaseOrderHeader WHERE PurchaseOrderID = @par)
END

PRINT 'Ostatie zamowienie ma date:  '+ CAST(dbo.OrderDate(77) AS VARCHAR(15))


--3. Procedura sk³adowana
CREATE PROCEDURE GetItem
(@name VARCHAR(40))
AS
BEGIN
SET NOCOUNT ON
 
SELECT ProductID,ProductNumber, MakeFlag  FROM Production.Product
WHERE Name = @name
END

EXEC GetItem 'Blade'

DROP PROCEDURE GetItem

--4. Funkcja zwraca nr. karty kredytowej
CREATE FUNCTION CreditCardOrder(@par INT)

RETURNS VARCHAR(30)
AS
BEGIN RETURN (SELECT CardNumber FROM Sales.SalesOrderHeader 
INNER JOIN Sales.CreditCard ON SalesOrderHeader.CreditCardID = CreditCard.CreditCardID
WHERE SalesOrderID = @par)
END

PRINT dbo.CreditCardOrder(43660)

--5. Procedura dziel¹ca wraz z wypisaniem b³êdu
CREATE PROCEDURE Divide
(@num1 FLOAT, @num2 FLOAT)
AS
BEGIN
SET NOCOUNT ON;

IF (@num1 < @num2)
  BEGIN
	RAISERROR ('Niew³aœciwie zdefiniowa³eœ dane wejœciowe',0,0) 
   RETURN;
  END

  PRINT(@num1/@num2)
END

EXEC Divide 60,21

DROP PROCEDURE Divide

--6. Procedura NationalIDNumber
CREATE PROCEDURE FreeDays
(@nationalIDnumber VARCHAR(40))
AS
BEGIN
SET NOCOUNT ON
 
SELECT JobTitle, VacationHours, SickLeaveHours FROM HumanResources.Employee
WHERE NationalIDNumber = @nationalIDnumber
END

EXEC FreeDays'245797967'

DROP PROCEDURE FreeDays

Select * FROM HumanResources.Employee

--7.Kalkulator Walut
Select * from Sales.CurrencyRate ORDER BY CurrencyRateDate

CREATE PROCEDURE CurrencyCalc
(@amount FLOAT = NULL,
 @cur VARCHAR(5) = NULL,
 @date DATE = NULL)
AS
BEGIN
   DECLARE @p FLOAT;
   SET @p = NULL;

SET NOCOUNT ON

 SELECT  @p = @amount / AverageRate FROM Sales.CurrencyRate WHERE ToCurrencyCode = @cur AND CurrencyRateDate = @date
 PRINT   CAST(@amount AS VARCHAR(10)) + ' '+ @cur +' --> ' + CAST(@p AS VARCHAR(10)) + ' USD'

 SELECT  @p = @amount * AverageRate FROM Sales.CurrencyRate WHERE ToCurrencyCode = @cur AND CurrencyRateDate = @date
 PRINT   CAST(@amount AS VARCHAR(10)) + ' USD' +' --> ' + CAST(@p AS VARCHAR(10)) + ' ' + @cur

END

DROP PROCEDURE CurrencyCalc

EXEC CurrencyCalc 10,'CAD','2011-06-02'