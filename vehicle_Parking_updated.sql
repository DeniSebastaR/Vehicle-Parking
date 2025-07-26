CREATE DATABASE IF NOT EXISTS vehicleparkingdb;
USE vehicleparkingdb;

CREATE TABLE Vehicle (
    VehicleNumber VARCHAR(20) PRIMARY KEY,
    Type VARCHAR(20),
    OwnerName VARCHAR(100)
);

CREATE TABLE ParkingSlot (
    SlotID INT PRIMARY KEY,
    SlotType VARCHAR(20),
    IsOccupied BOOLEAN DEFAULT FALSE
);

CREATE TABLE ParkingRecord (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleNumber VARCHAR(20),
    SlotID INT,
    EntryTime DATETIME,
    ExitTime DATETIME,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (VehicleNumber) REFERENCES Vehicle(VehicleNumber),
    FOREIGN KEY (SlotID) REFERENCES ParkingSlot(SlotID)
);
