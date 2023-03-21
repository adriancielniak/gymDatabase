--aktualizacja nowej daty platnosci i pozostalych platnosci po platnosci 

GO
CREATE TRIGGER new_paymant_date ON Payments
AFTER INSERT
AS  
    IF [remaining payments] > 0
        BEGIN
        UPDATE Members SET [next payment] = DATEADD(day, 30, [nextPayment]) 
        WHERE INSERTED.userID = Members.userID 
        END
    ELSE 
        BEGIN
            UPDATE Members
            SET [next payment] = NULL
            WHERE INSERTED.userID = Members.userID
        END
    UPDATE Members SET [remaing payments] = [remaining payments] - 1 
    WHERE INSERTED.userID = Members.userID
GO

--dodanie do wydatkow pensje pracownikow 

GO
CREATE TRIGGER dodaj_pensje ON Employees
AFTER INSERT 
AS
    UPDATE Expensess SET amount =
    (amount + (SELECT SUM(Employee.salary) FROM INSERTED, Employee WHERE Inserted.employeeID = Employee.employeeID))
    WHERE Expenses.[name] IN ('Salaries')
GO

--odejmij pensje od wydatkow

GO
CREATE TRIGGER odejmij_pensje ON Employees
AFTER DELETE 
AS
    UPDATE Expensess SET amount =
    (amount - (SELECT SUM(Employee.salary) FROM DELETED, Employee WHERE Inserted.employeeID = Employee.employeeID))
    WHERE Expenses.[name] IN ('Salaries')
GO

--zwiekszenie w danym karnecie liczby uzytkownikow

GO
CREATE TRIGGER add_user ON Members
AFTER INSERT 
AS
    IF(Inserted.passID IS NOT NULL)
    BEGIN
        UPDATE Passes SET Passes.users = Passes.users + 1
        WHERE Passes.passID = Inserted.passID
    END
GO

--zmniejszenie w danym karnceie liczy uzytkownikow


GO
CREATE TRIGGER remove_user ON Members
AFTER DELETE 
AS
    IF(Deleted.passID IS NOT NULL)
    BEGIN
        UPDATE Passes SET Passes.users = Passes.users + 1
        WHERE Passes.passID = Deleted.passID
    END
GO