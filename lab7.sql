Create Procedure Fib(@n INT)
AS
BEGIN
	DECLARE @numbers TABLE(number INT)
	DECLARE @n1 int = 0,  @n2 INT = 1,  @i INT = 0,  @temp INT
	INSERT INTO @numbers VALUES (@n1), (@n2)
	WHILE (@i < @n)
	BEGIN 			
		INSERT INTO @numbers VALUES (@n2 + @n1)
		SET @temp = @n2
		SET @n2 = @n2 + @n1
		SET @n1 = @temp
		SET @i += 1
	END	
	SELECT * FROM @numbers
END

EXEC Fib 43