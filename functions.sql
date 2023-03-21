--wypisywanie planu zajec na dany dzien 

CREATE FUNCTION classes_schedule (@day NVARCHAR(20))
RETURNS @schedule TABLE(
    [hour] NVARCHAR(50),
    [name] NVARCHAR(50),
    duration NVARCHAR(50),
    employee NVARCHAR(50)
)
AS
BEGIN
    IF @day NOT IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')
    BEGIN
        INSERT INTO @schedule VALUES('empty', 'empty', 'empty', 'empty')
    END
    ELSE
    BEGIN
    INSERT INTO @schedule 
        SELECT CONVERT(NVARCHAR(50), Classes.day), Classes.name, CONVERT(NVARCHAR(50), Classes.duration),
        CONCAT(Users.[first name], ' ', Users.[second name]) FROM Classes
        JOIN Users ON Classes.employeeID = Users.employeeID
        WHERE @day = Classes.[day]
        ORDER BY Claseses.[hour]
    END
    RETURN 
END