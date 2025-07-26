DROP DATABASE IF EXISTS ParkingManagement;
CREATE DATABASE ParkingManagement;
USE ParkingManagement;

CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY AUTO_INCREMENT,
    LicensePlate VARCHAR(15) NOT NULL UNIQUE,
    VehicleType VARCHAR(20),
    OwnerName VARCHAR(50)
);
CREATE TABLE ParkingSlots (
    SlotID INT PRIMARY KEY AUTO_INCREMENT,
    SlotNumber VARCHAR(100) NOT NULL UNIQUE,
    Status VARCHAR(10) CHECK (Status IN ('Available', 'Occupied'))
);
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleID INT,
    SlotID INT,
    EntryTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    ExitTime DATETIME,
    ExitCharge DECIMAL(10,2),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    FOREIGN KEY (SlotID) REFERENCES ParkingSlots(SlotID)
);

INSERT INTO ParkingSlots (SlotNumber, Status) VALUES
('A', 'Available'),
('B', 'Available'),
('C', 'Available');

INSERT INTO Vehicles (LicensePlate, VehicleType, OwnerName) VALUES
('TN01AB1234', 'Car', 'John Doe'),
('TN02XY5678', 'Bike', 'Alice Smith');

INSERT INTO Transactions (VehicleID, SlotID, EntryTime) VALUES
(1, 1, NOW());
SELECT * FROM ParkingSlots WHERE Status = 'Available';
INSERT INTO Transactions (VehicleID, SlotID, EntryTime) VALUES (1, 1, NOW());
UPDATE ParkingSlots SET Status = 'Occupied' WHERE SlotID = 1;
UPDATE Transactions SET ExitTime = NOW(), ExitCharge = 100 WHERE TransactionID = 1;
UPDATE ParkingSlots SET Status = 'Available' WHERE SlotID = (SELECT SlotID FROM Transactions WHERE TransactionID = 1);
SELECT 
    VehicleID, SlotID, EntryTime, 
    COALESCE(ExitTime, 'Still Parked') AS ExitTime, 
    COALESCE(ExitCharge, 'Pending') AS ExitCharge
FROM Transactions;