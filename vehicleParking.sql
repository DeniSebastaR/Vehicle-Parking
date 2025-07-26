-- 1. Create the Database
DROP DATABASE IF EXISTS VehicleParkingDB;
CREATE DATABASE VehicleParkingDB;
USE VehicleParkingDB;

-- 2. Create Tables

-- Vehicle Table
CREATE TABLE Vehicle (
    VehicleNumber VARCHAR(20) PRIMARY KEY,
    Type VARCHAR(10),  -- 'car' or 'bike'
    OwnerName VARCHAR(100)
);

-- Parking Slot Table
CREATE TABLE ParkingSlot (
    SlotID INT PRIMARY KEY,
    SlotType VARCHAR(10),  -- 'car' or 'bike'
    IsOccupied BOOLEAN DEFAULT FALSE
);

-- Parking Record Table
CREATE TABLE ParkingRecord (
    ParkingID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleNumber VARCHAR(20),
    SlotID INT,
    EntryTime DATETIME,
    ExitTime DATETIME,
    Charge DECIMAL(10,2),
    FOREIGN KEY (VehicleNumber) REFERENCES Vehicle(VehicleNumber),
    FOREIGN KEY (SlotID) REFERENCES ParkingSlot(SlotID)
);

-- 3. Insert Sample Data

-- Insert into ParkingSlot
INSERT INTO ParkingSlot VALUES
(1, 'car', FALSE),
(2, 'car', FALSE),
(3, 'bike', FALSE),
(4, 'bike', FALSE);

-- Insert into Vehicle
INSERT INTO Vehicle VALUES
('TN01AB1234', 'car', 'Arjun Kumar'),
('TN01CD5678', 'bike', 'Meera Reddy'),
('TN02XY9999', 'car', 'John Das');

-- Insert into ParkingRecord
-- Assume vehicle TN01AB1234 is parked in slot 1 from 9:00 to 11:00 (2 hours)
INSERT INTO ParkingRecord (VehicleNumber, SlotID, EntryTime, ExitTime, Charge) VALUES
('TN01AB1234', 1, '2025-05-09 09:00:00', '2025-05-09 11:00:00', 40.00),
('TN01CD5678', 3, '2025-05-09 10:00:00', NULL, NULL);  -- currently parked

-- Update slots to reflect occupancy
UPDATE ParkingSlot SET IsOccupied = TRUE WHERE SlotID IN (1, 3);

-- 4. Show All Table Details

-- Show all vehicles
SELECT * FROM Vehicle;

-- Show all slots
SELECT * FROM ParkingSlot;

-- Show all parking records
SELECT * FROM ParkingRecord;
