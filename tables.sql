CREATE TABLE Users(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    [first name] NVARCHAR(50) NOT NULL,
    [second name] NVARCHAR(50) NOT NULL,
    sex NVARCHAR(1) NOT NULL,
    CHECK (sex = 'm' OR sex = 'f'),
    [birth date] DATE NOT NULL,
    [number] NVARCHAR(11) NOT NULL,
    CHECK (number NOT LIKE '%[^0-9]%'),
    [e-mail] NVARCHAR(50) NOT NULL
)

--KARNETYf

CREATE TABLE Passes(
    passID INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    price MONEY NOT NULL,
    [validity period] INT NOT NULL,
    [availability] BIT NOT NULL,
    users INT NOT NULL,
)

--CZLONKOWIE KLUBU

CREATE TABLE Members(
    userID INT REFERENCES Users PRIMARY KEY,
    passID INT REFERENCES Passes,
    [credit card] NVARCHAR(16) NOT NULL,
    CHECK ([credit card] NOT LIKE '%[^0-9]%'),
    [remaining payments] INT NOT NULL,
    [next payment] DATE,
    [expiry date] DATE
)

--Pracownicy

CREATE TABLE Employees(
    employeeID INT REFERENCES Users PRIMARY KEY,
    position NVARCHAR(50) NOT NULL,
    salary MONEY NOT NULL
)

--Platnosci

CREATE TABLE Payments(
    paymentID INT IDENTITY(1,1) PRIMARY KEY,
    userID INT REFERENCES Users NOT NULL,
    [payment date] DATE NOT NULL,
    passID INT REFERENCES Passes NOT NULL,
    amount MONEY NOT NULL
)

--Urlopy

CREATE TABLE Leaves(
    employeeID INT REFERENCES Employees,
    [start date] DATE NOT NULL,
    [end date] DATE NOT NULL,
    PRIMARY KEY(employeeID, [start date])
)

--Producenci 

CREATE TABLE Producents(
    producentID INT IDENTITY(1,1) PRIMARY KEY,
    [company name] NVARCHAR(50) NOT NULL,
    number NVARCHAR(11) NOT NULL,
    CHECK (number NOT LIKE '%[^0-9]%')
)

--Zaopatrzenie

CREATE TABLE Supply(
    productID INT IDENTITY(1,1) PRIMARY KEY,
    [product name] NVARCHAR(50) NOT NULL,
    amount INT NOT NULL,
    producentID INT REFERENCES Producents NOT NULL
)

--Wydatki

CREATE TABLE Expenses(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    cost MONEY NOT NULL
)

--Wyposazenie

CREATE TABLE Equipment(
    equipmentID INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    amount INT NOT NULL,
    producentID INT REFERENCES Producents NOT NULL
)

--Zajecia

CREATE TABLE Classes(
    classesID INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(50) NOT NULL,
    employeeID INT REFERENCES Employees NOT NULL,
    [day] NVARCHAR(20) NOT NULL,
    CHECK([day] IN ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')),
    [hour] TIME NOT NULL,
    CHECK ([hour] BETWEEN '7:00:00' AND '21:00:00'),
    duration TIME NOT NULL,
    CHECK (duration <= '2:00:00')
)