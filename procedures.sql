--PROCEDURY 

--PLAN dla danego pracownika 

GO
CREATE PROC employee_classes
@first_name NVARCHAR(50),
@second_name NVARCHAR(50)
AS
    SELECT [name], [day], [hour], [duration] FROM Classes C
    JOIN Users U ON C.employeeID = U.ID
    WHERE U.[first name] = @first_name AND U.[second name] = @second_name
    ORDER BY
        CASE    
          WHEN C.[day] = 'monday' THEN 1
          WHEN C.[day] = 'tuesday' THEN 2
          WHEN C.[day] = 'wednesday' THEN 3
          WHEN C.[day] = 'thursday' THEN 4 
          WHEN C.[day] = 'friday' THEN 5 
          WHEN C.[day] = 'saturday' THEN 6
          WHEN C.[day] = 'sunday' Then 7
        END, [hour]
GO

--plan zajec danego dnia (co tutaj sie stalo, dalczego ja mam dwa razy to samo)

CREATE PROC zajecia_dnia
@dzien NVARCHAR(50)
AS 
    SELECT [name], [hour], [duration], U.[first name], U.[second name] FROM Classes C
    JOIN Users U ON C.employeeID = U.ID
    WHERE C.[day] = @dzien
    ORDER BY [hour], duration
GO

CREATE PROC passes_to
@amount MONEY
AS
    SELECT [name], price, [validity period], users FROM Passes
    WHERE price <= @amount AND availability = 1
    ORDER BY price DESC
GO

--wszystkie platnosci danej osoby

GO
CREATE PROC platnosci_osoby
@first_name NVARCHAR(50),
@second_name NVARCHAR(50)
AS
    SELECT [payment date], amount, Passes.[name] FROM Payments
    JOIN Passes ON Passes.passID = Payments.passID
    JOIN Users ON Users.ID = Payments.userID
    WHERE Users.[first name] = @first_name AND Users.[second name] = @second_name
    ORDER BY Payments.[payment date]
GO

--czlonkowie na litere

GO
CREATE PROC czlonek_na_litere
(@letter CHAR)
AS
    SELECT [first name], [second name] FROM Members
    JOIN Users ON User.ID = Members.userID
    WHERE [second name] LIKE @letter + '%'
    ORDER BY [first name]
GO

--urlopy danego pracownika

GO
CREATE PROC urlopy_pracownika
@firs_name NVARCHAR(50),
@second_name NVARCHAR(50)
AS
    SELECT [start date], [end date] FROM Urlopy
    JOIN Users ON Users.ID = Urlopy.employeeID
    WHERE Users.[first name] = @first_name AND Users.[second name] = @second_name
    ORDER BY [start date]
GO