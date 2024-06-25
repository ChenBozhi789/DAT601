-- Create FlightStreamDB Database
USE master;
GO
DROP DATABASE IF EXISTS FlightStreamDB;
GO
CREATE DATABASE FlightStreamDB;
GO
USE FlightStreamDB;

-- Create Table
-- Create Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Number VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL UNiQUE
);

-- Create MaintenanceTechnician table
CREATE TABLE MaintenanceTechnician (
    MaintenanceID INT PRIMARY KEY,
    Date DATE  NOT NULL,
    Status VARCHAR(50) DEFAULT 'Active',
);

-- Create SalesPerson table
CREATE TABLE SalesPerson (
    SalesPersonID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    MaxDiscount DECIMAL CHECK (MaxDiscount > 0)
);

-- Create AdministrativeExecutive table
CREATE TABLE AdministrativeExecutive (
    AdministrativeExecutiveID INT PRIMARY KEY
);

-- Create MaintenanceRecord table
CREATE TABLE MaintenanceRecord (
    RecordID INT PRIMARY KEY,
    MaintainDate DATE NOT NULL
);

-- Create Subscriber table
CREATE TABLE Subscriber (
    SubscriberID INT PRIMARY KEY,
    SalesPersonID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Number VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);

-- Create Contract table
CREATE TABLE DataScoop (
    DataScoopID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Status VARCHAR(50) NOT NULL
);

CREATE TABLE Contract (
    ContractID INT PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Discount DECIMAL(5, 2) CHECK (Discount > 0),
    OrganisationName VARCHAR(100),
    DataScoopID INT NOT NULL, 
    SalesPersonID INT NOT NULL,
    FOREIGN KEY (DataScoopID) REFERENCES DataScoop(DataScoopID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);

CREATE TABLE Gold (
    GoldID INT PRIMARY KEY
);

CREATE TABLE Platinum (
    PlatinumID INT PRIMARY KEY
);

CREATE TABLE SuperPlatinum (
    SuperPlatinumID INT PRIMARY KEY
);

CREATE TABLE Data (
    DataID INT PRIMARY KEY,
    DataScoopID INT NOT NULL,
    Date DATE NOT NULL,
    Latitude FLOAT NOT NULL,
    Longitude FLOAT NOT NULL,
    Temperature FLOAT NOT NULL,
    Humidity FLOAT NOT NULL,
    AmbientLightStrength FLOAT NOT NULL,
    OrganicSpectralDate DATE NOT NULL,
    FOREIGN KEY (DataScoopID) REFERENCES DataScoop(DataScoopID),
);

CREATE TABLE Zones (
    ZonesID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Type VARCHAR(20) NOT NULL
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Number VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

CREATE TABLE Part (
    PartID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE VideoStream (
    VideoStreamID INT PRIMARY KEY,
    DataScoopID INT NOT NULL,
    FOREIGN KEY (DataScoopID) REFERENCES DataScoop(DataScoopID)
);

/* Connect table */
CREATE TABLE MaintenanceTechnicianMaintenanceRecord (
    MaintenanceID INT,
    RecordID INT,
    PRIMARY KEY (MaintenanceID, RecordID),
    FOREIGN KEY (MaintenanceID) REFERENCES MaintenanceTechnician(MaintenanceID),
    FOREIGN KEY (RecordID) REFERENCES MaintenanceRecord(RecordID)
);

CREATE TABLE MaintenanceRecordPart (
    RecordID INT,
    PartID INT,
    PRIMARY KEY (RecordID, PartID),
    FOREIGN KEY (RecordID) REFERENCES MaintenanceRecord(RecordID),
    FOREIGN KEY (PartID) REFERENCES Part(PartID)
);

CREATE TABLE MaintenanceRecordDataScoop (
    RecordID INT,
    DataScoopID INT,
    PRIMARY KEY (RecordID, DataScoopID),
    FOREIGN KEY (RecordID) REFERENCES MaintenanceRecord(RecordID),
    FOREIGN KEY (DataScoopID) REFERENCES DataScoop(DataScoopID)
);

CREATE TABLE DataScoopZone (
    DataScoopID INT,
    ZonesID INT,
    PRIMARY KEY (ZonesID, DataScoopID),
    FOREIGN KEY (DataScoopID) REFERENCES DataScoop(DataScoopID),
    FOREIGN KEY (ZonesID) REFERENCES Zones(ZonesID)
);

CREATE TABLE SupplierPart (
    SupplierID INT,
    PartID INT,
    PRIMARY KEY (SupplierID, PartID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (PartID) REFERENCES Part(PartID)
);

INSERT INTO Employee (EmployeeID, FirstName, LastName, Number, Email) VALUES (10001, 'John', 'Doe', '555-1234', 'john.doe@example.com');
INSERT INTO Employee (EmployeeID, FirstName, LastName, Number, Email) VALUES (10002, 'Jane', 'Smith', '555-5678', 'jane.smith@example.com');
INSERT INTO Employee (EmployeeID, FirstName, LastName, Number, Email) VALUES (10003, 'Robert', 'Johnson', '555-9101', 'robert.johnson@example.com');
INSERT INTO Employee (EmployeeID, FirstName, LastName, Number, Email) VALUES (10004, 'Emily', 'Davis', '555-1122', 'emily.davis@example.com');
INSERT INTO Employee (EmployeeID, FirstName, LastName, Number, Email) VALUES (10005, 'Michael', 'Brown', '555-3344', 'michael.brown@example.com');

INSERT INTO MaintenanceTechnician (MaintenanceID, Date, Status) VALUES (100001, '2023-01-15', 'Active');
INSERT INTO MaintenanceTechnician (MaintenanceID, Date, Status) VALUES (100002, '2023-02-20', 'Inactive');
INSERT INTO MaintenanceTechnician (MaintenanceID, Date, Status) VALUES (100003, '2023-03-10', 'Active');
INSERT INTO MaintenanceTechnician (MaintenanceID, Date, Status) VALUES (100004, '2023-04-05', 'Active');
INSERT INTO MaintenanceTechnician (MaintenanceID, Date, Status) VALUES (100005, '2023-05-25', 'Inactive');

INSERT INTO SalesPerson (SalesPersonID, MaxDiscount, FirstName, LastName) VALUES (200001, 5.0, 'John', 'Doe');
INSERT INTO SalesPerson (SalesPersonID, MaxDiscount, FirstName, LastName) VALUES (200002, 2.5, 'Jane', 'Smith');
INSERT INTO SalesPerson (SalesPersonID, MaxDiscount, FirstName, LastName) VALUES (200003, 2.0, 'Robert', 'Johnson');
INSERT INTO SalesPerson (SalesPersonID, MaxDiscount, FirstName, LastName) VALUES (200004, 5.0, 'Emily', 'Davis');
INSERT INTO SalesPerson (SalesPersonID, MaxDiscount, FirstName, LastName) VALUES (200005, 1.0, 'Michael', 'Brown');

INSERT INTO AdministrativeExecutive (AdministrativeExecutiveID) VALUES (300001);
INSERT INTO AdministrativeExecutive (AdministrativeExecutiveID) VALUES (300002);
INSERT INTO AdministrativeExecutive (AdministrativeExecutiveID) VALUES (300003);
INSERT INTO AdministrativeExecutive (AdministrativeExecutiveID) VALUES (300004);
INSERT INTO AdministrativeExecutive (AdministrativeExecutiveID) VALUES (300005);

INSERT INTO Supplier (SupplierID, Name, Price, Status, Number, Email, Location) VALUES (400001, 'SupplierOne', 100.00, 'Active', '555-1234', 'supplier1@example.com', 'New York');
INSERT INTO Supplier (SupplierID, Name, Price, Status, Number, Email, Location) VALUES (400002, 'SupplierTwo', 150.00, 'Inactive', '555-5678', 'supplier2@example.com', 'Los Angeles');
INSERT INTO Supplier (SupplierID, Name, Price, Status, Number, Email, Location) VALUES (400003, 'SupplierThree', 200.00, 'Active', '555-9101', 'supplier3@example.com', 'London');
INSERT INTO Supplier (SupplierID, Name, Price, Status, Number, Email, Location) VALUES (400004, 'SupplierFour', 250.00, 'Active', '555-1122', 'supplier4@example.com', 'Paris');
INSERT INTO Supplier (SupplierID, Name, Price, Status, Number, Email, Location) VALUES (400005, 'SupplierFive', 300.00, 'Inactive', '555-3344', 'supplier5@example.com', 'Tokyo');

INSERT INTO Subscriber (SubscriberID, SalesPersonID, FirstName, LastName, Number, Email, Address, StartDate, EndDate, Type) VALUES (001, 200001, 'Alice', 'Walker', '555-2233', 'alice.walker@example.com', '123 Main St, New York, NY 10001','2023-01-01', '2024-01-01', 'Gold');
INSERT INTO Subscriber (SubscriberID, SalesPersonID, FirstName, LastName, Number, Email, Address, StartDate, EndDate, Type) VALUES (002, 200002, 'Bob', 'Marley', '555-3344', 'bob.marley@example.com', '456 Maple Ave, Los Angeles, CA 90001','2023-02-01', '2024-02-01', 'Platinum');
INSERT INTO Subscriber (SubscriberID, SalesPersonID, FirstName, LastName, Number, Email, Address, StartDate, EndDate, Type) VALUES (003, 200003, 'Charlie', 'Garcia', '555-4455', 'charlie.garcia@example.com', '789 Oak St, Chicago, IL 60601','2023-03-01', '2024-03-01', 'SuperPlatinum');
INSERT INTO Subscriber (SubscriberID, SalesPersonID, FirstName, LastName, Number, Email, Address, StartDate, EndDate, Type) VALUES (004, 200004, 'Diana', 'Ross', '555-5566', 'diana.ross@example.com', '101 Pine Rd, Houston, TX 77001','2023-04-01', '2024-04-01', 'Gold');
INSERT INTO Subscriber (SubscriberID, SalesPersonID, FirstName, LastName, Number, Email, Address, StartDate, EndDate, Type) VALUES (005, 200005, 'Eve', 'Black', '555-6677', 'eve.black@example.com', '202 Birch Ln, San Francisco, CA 94101','2023-05-01', '2024-05-01', 'Platinum');

INSERT INTO MaintenanceRecord (RecordID, MaintainDate) VALUES (2001, '2023-06-01');
INSERT INTO MaintenanceRecord (RecordID, MaintainDate) VALUES (2002, '2023-06-15');
INSERT INTO MaintenanceRecord (RecordID, MaintainDate) VALUES (2003, '2023-07-01');
INSERT INTO MaintenanceRecord (RecordID, MaintainDate) VALUES (2004, '2023-07-15');
INSERT INTO MaintenanceRecord (RecordID, MaintainDate) VALUES (2005, '2023-08-01');

INSERT INTO Gold (GoldID) VALUES (3001);
INSERT INTO Gold (GoldID) VALUES (3002);
INSERT INTO Gold (GoldID) VALUES (3003);
INSERT INTO Gold (GoldID) VALUES (3004);
INSERT INTO Gold (GoldID) VALUES (3005);

INSERT INTO Platinum (PlatinumID) VALUES (4001);
INSERT INTO Platinum (PlatinumID) VALUES (4002);
INSERT INTO Platinum (PlatinumID) VALUES (4003);
INSERT INTO Platinum (PlatinumID) VALUES (4004);
INSERT INTO Platinum (PlatinumID) VALUES (4005);

INSERT INTO SuperPlatinum (SuperPlatinumID) VALUES (5001);
INSERT INTO SuperPlatinum (SuperPlatinumID) VALUES (5002);
INSERT INTO SuperPlatinum (SuperPlatinumID) VALUES (5003);
INSERT INTO SuperPlatinum (SuperPlatinumID) VALUES (5004);
INSERT INTO SuperPlatinum (SuperPlatinumID) VALUES (5005);

INSERT INTO DataScoop (DataScoopID, Date, Status) VALUES (1000001, '2023-01-01', 'Active');
INSERT INTO DataScoop (DataScoopID, Date, Status) VALUES (1000002, '2023-01-02', 'Inactive');
INSERT INTO DataScoop (DataScoopID, Date, Status) VALUES (1000003, '2023-01-03', 'Active');
INSERT INTO DataScoop (DataScoopID, Date, Status) VALUES (1000004, '2023-01-04', 'Inactive');
INSERT INTO DataScoop (DataScoopID, Date, Status) VALUES (1000005, '2023-01-05', 'Active');

INSERT INTO Contract (ContractID, StartDate, EndDate, Price, Discount, OrganisationName, DataScoopID, SalesPersonID) VALUES (1001, '2023-01-01', '2023-12-31', 10000.00, 5.00, 'TechCorp', 1000001, 200001);
INSERT INTO Contract (ContractID, StartDate, EndDate, Price, Discount, OrganisationName, DataScoopID, SalesPersonID) VALUES (1002, '2023-02-01', '2023-12-31', 15000.00, 2.00, 'HealthInc', 1000002, 200002);
INSERT INTO Contract (ContractID, StartDate, EndDate, Price, Discount, OrganisationName, DataScoopID, SalesPersonID) VALUES (1003, '2023-03-01', '2023-12-31', 20000.00, 3.00, 'EduTech', 1000003, 200003);
INSERT INTO Contract (ContractID, StartDate, EndDate, Price, Discount, OrganisationName, DataScoopID, SalesPersonID) VALUES (1004, '2023-04-01', '2023-12-31', 25000.00, 4.00, 'FinSadwe', 1000004, 200004);
INSERT INTO Contract (ContractID, StartDate, EndDate, Price, Discount, OrganisationName, DataScoopID, SalesPersonID) VALUES (1005, '2023-05-01', '2023-12-31', 30000.00, 1.00, 'RetailCo', 1000005, 200005);

INSERT INTO Data (DataID, DataScoopID, Date, Latitude, Longitude, Temperature, Humidity, AmbientLightStrength, OrganicSpectralDate) VALUES (2000001, 1000001, '2023-01-01', 40.7128, -74.0060, 15.5, 60.0, 200.0, '2023-01-02');
INSERT INTO Data (DataID, DataScoopID, Date, Latitude, Longitude, Temperature, Humidity, AmbientLightStrength, OrganicSpectralDate) VALUES (2000002, 1000002, '2023-01-02', 34.0522, -118.2437, 20.0, 55.0, 180.0, '2023-01-03');
INSERT INTO Data (DataID, DataScoopID, Date, Latitude, Longitude, Temperature, Humidity, AmbientLightStrength, OrganicSpectralDate) VALUES (2000003, 1000003, '2023-01-03', 51.5074, -0.1278, 10.0, 70.0, 220.0, '2023-01-04');
INSERT INTO Data (DataID, DataScoopID, Date, Latitude, Longitude, Temperature, Humidity, AmbientLightStrength, OrganicSpectralDate) VALUES (2000004, 1000004, '2023-01-04', 48.8566, 2.3522, 12.5, 65.0, 190.0, '2023-01-05');
INSERT INTO Data (DataID, DataScoopID, Date, Latitude, Longitude, Temperature, Humidity, AmbientLightStrength, OrganicSpectralDate) VALUES (2000005, 1000005, '2023-01-05', 35.6895, 139.6917, 18.0, 50.0, 170.0, '2023-01-06');

INSERT INTO Zones (ZonesID, Name, Type) VALUES (3000001, 'ZoneA', 'Jungle');
INSERT INTO Zones (ZonesID, Name, Type) VALUES (3000002, 'ZoneB', 'Forest');
INSERT INTO Zones (ZonesID, Name, Type) VALUES (3000003, 'ZoneC', 'Savannahs');
INSERT INTO Zones (ZonesID, Name, Type) VALUES (3000004, 'ZoneD', 'Mountain');
INSERT INTO Zones (ZonesID, Name, Type) VALUES (3000005, 'ZoneE', 'Desert');

INSERT INTO Part (PartID, Name) VALUES (4000001, 'PartA');
INSERT INTO Part (PartID, Name) VALUES (4000002, 'PartB');
INSERT INTO Part (PartID, Name) VALUES (4000003, 'PartC');
INSERT INTO Part (PartID, Name) VALUES (4000004, 'PartD');
INSERT INTO Part (PartID, Name) VALUES (4000005, 'PartE');

INSERT INTO VideoStream (VideoStreamID, DataScoopID) VALUES (5000001, 1000001);
INSERT INTO VideoStream (VideoStreamID, DataScoopID) VALUES (5000002, 1000002);
INSERT INTO VideoStream (VideoStreamID, DataScoopID) VALUES (5000003, 1000003);
INSERT INTO VideoStream (VideoStreamID, DataScoopID) VALUES (5000004, 1000004);
INSERT INTO VideoStream (VideoStreamID, DataScoopID) VALUES (5000005, 1000005);

INSERT INTO MaintenanceTechnicianMaintenanceRecord (MaintenanceID, RecordID) VALUES (100001, 2001);
INSERT INTO MaintenanceTechnicianMaintenanceRecord (MaintenanceID, RecordID) VALUES (100002, 2002);
INSERT INTO MaintenanceTechnicianMaintenanceRecord (MaintenanceID, RecordID) VALUES (100003, 2003);
INSERT INTO MaintenanceTechnicianMaintenanceRecord (MaintenanceID, RecordID) VALUES (100004, 2004);
INSERT INTO MaintenanceTechnicianMaintenanceRecord (MaintenanceID, RecordID) VALUES (100005, 2005);

INSERT INTO MaintenanceRecordPart (RecordID, PartID) VALUES (2001, 4000001);
INSERT INTO MaintenanceRecordPart (RecordID, PartID) VALUES (2002, 4000002);
INSERT INTO MaintenanceRecordPart (RecordID, PartID) VALUES (2003, 4000003);
INSERT INTO MaintenanceRecordPart (RecordID, PartID) VALUES (2004, 4000004);
INSERT INTO MaintenanceRecordPart (RecordID, PartID) VALUES (2005, 4000005);

INSERT INTO MaintenanceRecordDataScoop (RecordID, DataScoopID) VALUES (2001, 1000001);
INSERT INTO MaintenanceRecordDataScoop (RecordID, DataScoopID) VALUES (2002, 1000002);
INSERT INTO MaintenanceRecordDataScoop (RecordID, DataScoopID) VALUES (2003, 1000003);
INSERT INTO MaintenanceRecordDataScoop (RecordID, DataScoopID) VALUES (2004, 1000004);
INSERT INTO MaintenanceRecordDataScoop (RecordID, DataScoopID) VALUES (2005, 1000005);

INSERT INTO DataScoopZone (DataScoopID, ZonesID) VALUES (1000001, 3000001);
INSERT INTO DataScoopZone (DataScoopID, ZonesID) VALUES (1000002, 3000002);
INSERT INTO DataScoopZone (DataScoopID, ZonesID) VALUES (1000003, 3000003);
INSERT INTO DataScoopZone (DataScoopID, ZonesID) VALUES (1000004, 3000004);
INSERT INTO DataScoopZone (DataScoopID, ZonesID) VALUES (1000005, 3000005);

INSERT INTO SupplierPart (SupplierID, PartID) VALUES (400001, 4000001);
INSERT INTO SupplierPart (SupplierID, PartID) VALUES (400002, 4000002);
INSERT INTO SupplierPart (SupplierID, PartID) VALUES (400003, 4000003);
INSERT INTO SupplierPart (SupplierID, PartID) VALUES (400004, 4000004);
INSERT INTO SupplierPart (SupplierID, PartID) VALUES (400005, 4000005);

-- REQUIRED PROCESSES/TRANSACTIONS
-- Transaction a
CREATE PROCEDURE SubscribeToDataScoop
    @SalesPersonID INT,
    @SubscriberID INT,
    @Discount DECIMAL(5, 2),
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Number VARCHAR(20),
    @Email VARCHAR(100),
    @Address VARCHAR(50),
    @StartDate DATE,
    @EndDate DATE,
    @Type VARCHAR(50),
    @DataScoopID INT
AS
BEGIN
    INSERT INTO Subscriber (SubscriberID, SalesPersonID, FirstName, LastName, Number, Email, Address, StartDate, EndDate, Type) VALUES (@SubscriberID, @SalesPersonID, @FirstName, @LastName, @Number, @Email, @Address, @StartDate, @EndDate, @Type);
    DECLARE @SubscriberID INT = SCOPE_IDENTITY();

    INSERT INTO Contract (ContractID, StartDate, EndDate, Price, Discount, OrganisationName, DataScoopID, SalesPersonID) 
    VALUES (@SubscriberID, @StartDate, @EndDate, NULL, @Discount, @FirstName + ' ' + @LastName, @DataScoopID, @SalesPersonID);
END;

EXEC SubscribeToDataScoop 
    @SalesPersonID = 200001, 
    @SubscriberID = 001,
    @Discount = 5.00, 
    @FirstName = 'Alice', 
    @LastName = 'Walker', 
    @Number = '555-2233', 
    @Email = 'alice.walker@example.com', 
    @Address = '123 Main St, New York, NY 10001', 
    @StartDate = '2023-01-01', 
    @EndDate = '2024-01-01', 
    @Type = 'Gold', 
    @DataScoopID = 1000001;

-- Transaction b
CREATE PROCEDURE GetSubscribersBySalesPerson
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50)
AS
BEGIN
	SELECT 
		SalesPerson.FirstName AS SubscriberFirstName,
		SalesPerson.LastName AS SubscriberLastName,
		SalesPerson.MaxDiscount AS DiscountPercent,
		Subscriber.Address
	FROM 
		SalesPerson
	JOIN 
		Subscriber ON SalesPerson.SalesPersonID = Subscriber.SalesPersonID
	WHERE 
		SalesPerson.FirstName = @FirstName AND SalesPerson.LastName = @LastName;
END;
GO

-- Execute
EXEC GetSubscribersBySalesPerson 'Jane', 'Smith';

-- Transaction c


-- Transaction d
-- List the DataScoop locations in the current contract
CREATE PROCEDURE ListDataScoopLocation
AS
BEGIN
    SELECT 
		Contract.OrganisationName, 
        DataScoop.DataScoopID, 
        Data.Latitude, 
        Data.Longitude
    FROM 
		Contract
    INNER JOIN 
		DataScoop ON Contract.DataScoopID = DataScoop.DataScoopID
    INNER JOIN 
		Data ON DataScoop.DataScoopID = Data.DataScoopID
END

-- Transaction e
CREATE PROCEDURE ListDataCollectedByContract
    @OrganisationName VARCHAR(100)
AS
BEGIN
    SELECT 
        Contract.OrganisationName, 
        Data.DataScoopID, 
        Data.Temperature, 
        Data.Humidity, 
        Data.AmbientLightStrength, 
    FROM 
        Contract
    JOIN 
        Data ON Contract.DataScoopID = Data.DataScoopID
    WHERE 
        Contract.OrganisationName = @OrganisationName;
END;

-- Transaction f
CREATE PROCEDURE ListSubscribersViewingLiveStream
AS
BEGIN
    SELECT 
        DataScoop.DataScoopID, 
        Subscriber.FirstName + ' ' + Subscriber.LastName AS SubscriberName, 
        VideoStream.VideoStreamID AS StreamID
    FROM 
        DataScoop
    JOIN 
        Subscriber ON DataScoop.DataScoopID = Subscriber.SalesPersonID
    JOIN 
        VideoStream ON DataScoop.DataScoopID = VideoStream.DataScoopID
END;
GO

EXEC ListSubscribersViewingLiveStream;

-- Transaction g
CREATE PROCEDURE ListSuppliersForDataScoop
    @DataScoopID INT
AS
BEGIN
    SELECT 
        Supplier.Name AS SupplierName,
        Part.Name AS PartName
    FROM 
        DataScoop
    INNER JOIN 
        MaintenanceRecordDataScoop ON DataScoop.DataScoopID = MaintenanceRecordDataScoop.DataScoopID
    INNER JOIN 
        MaintenanceRecordPart ON MaintenanceRecordDataScoop.RecordID = MaintenanceRecordPart.RecordID
    INNER JOIN 
        Part ON MaintenanceRecordPart.PartID = Part.PartID
    INNER JOIN 
        SupplierPart ON Part.PartID = SupplierPart.PartID
    INNER JOIN 
        Supplier ON SupplierPart.SupplierID = Supplier.SupplierID
    WHERE 
        DataScoop.DataScoopID = @DataScoopID;
END;
GO

EXEC ListSuppliersForDataScoop @DataScoopID = 1000001;

-- Transaction h

-- Transaction i

-- Transaction j
CREATE PROCEDURE TotalCostOfReplacedParts
AS
BEGIN
    SELECT 
        DataScoop.DataScoopID,
        SUM(Supplier.Price) AS TotalCost
    FROM 
        MaintenanceRecordDataScoop
    INNER JOIN 
        MaintenanceRecordPart ON MaintenanceRecordDataScoop.RecordID = MaintenanceRecordPart.RecordID
    INNER JOIN 
        Part ON MaintenanceRecordPart.PartID = Part.PartID
    INNER JOIN 
        SupplierPart ON Part.PartID = SupplierPart.PartID
    INNER JOIN 
        Supplier ON SupplierPart.SupplierID = Supplier.SupplierID
    INNER JOIN 
        DataScoop ON MaintenanceRecordDataScoop.DataScoopID = DataScoop.DataScoopID
    GROUP BY 
        DataScoop.DataScoopID;
END;
GO