--Suma wydatkow

GO
CREATE VIEW [all expensess] AS
    SELECT SUM(cost) AS [sum of expensess] FROM Expenses

--licba osob z danym karnetem 

GO
CREATE VIEW [persons per pass] AS
    SELECT [name] AS "pass name", users AS "amount of users" FROM Passes 
    ORDER BY users DESC

--wypisuje urzytkownikow ktorzy maja danego dnia urodziny

GO 
CREATE VIEW [birthday] AS
    SELECT [first name], [e-mail] FROM Users
    WHERE DAY(GETDATE()) = DAY([birth date])
    AND MONTH(GETDATE()) = MONTH([birth date])

--dane dotyczace pracownikow 

GO 
CREATE VIEW [employees personal data] AS
    SELECT Users.[first name], Users.[second name], Users.sex, position, salary,
    Users.[birth date], Users.[number], Users.[e-mail] FROM Employees
    JOIN Users ON Employees.employeeID = Users.ID
    ORDER BY [first name], [second name]
GO

--dane dotyczace czlonkow klubu 

GO
CREATE VIEW [members personal data] AS
    SELECT Users.[first name], Users.[second name], Users.sex, Users.[birth date],
    Passes.[name], Users.[number], Users.[e-mail], [next payment] FROM Members
    JOIN Users ON Users.ID = Members.userID
    JOIN Passes ON Passes.PassID = Members.passID
    ORDER BY [firs name], [second name]
GO

--przychody z karentow w obecnym dniu  

GO 
CREATE VIEW [earnings from passes] AS   
    SELECT [payment date],
    COUNT((SELECT paymentID FROM Payments
    WHERE CONVERT(DATE, GETDATE()) = [payment date])) AS "number of ticekt sold",
    SUM((SELECT amount FROM Payments
    WHERE CONVERT(DATE, GETDATE()) = [payment date])) AS "income" FROM Payments
GO

--lista sprzetow z informacjami o producencie

GO
CREATE VIEW [equipment data] AS
    SELECT [name], amount, Producents.[company name], Producents.number FROM Equipment
    JOIN Producents ON Equipment.producentID = Producents.producentID
    ORDER BY name
GO

--lista produktow z informacjami o producencie

GO
CREATE VIEW [supply data] AS
    SELECT [name], amount, Producents.[company name], Producents.number FROM Supply
    JOIN Producents ON Supply.producentID = Producents.producentID
    ORDER BY name
GO


--dane do platnosci przy pobieraniu srodkow czlonkow ktorzy danego dnia placa za karnet

GO
CREATE VIEW [payment data] AS
    SELECT Users.[first name], Users.[second name], Passes.[name], Passes.price, [credit card] FROM Members 
    JOIN Users ON Users.ID = Members.userID
    JOIN Passes ON Passes.passID = Members.passID
    WHERE nextPayment = CONVERT(DATE, GETDATE())
    ORDER BY [first name], [second name]
GOt