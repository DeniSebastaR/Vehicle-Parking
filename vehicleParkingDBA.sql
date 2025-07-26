DROP DATABASE IF EXISTS vehicleparkingDB;
CREATE DATABASE VehicleParkingDB;
USE VehicleParkingDB;

CREATE TABLE Vehicle (
    vehicle_no VARCHAR(20) PRIMARY KEY,
    type VARCHAR(10),
    owner_name VARCHAR(100)
);

CREATE TABLE Slot (
    slot_id INT PRIMARY KEY,
    type VARCHAR(10),  -- e.g., 'bike', 'car'
    is_available BOOLEAN
);

CREATE TABLE Parking (
    parking_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_no VARCHAR(20),
    slot_id INT,
    entry_time DATETIME,
    exit_time DATETIME,
    charge DECIMAL(10,2),
    FOREIGN KEY (vehicle_no) REFERENCES Vehicle(vehicle_no),
    FOREIGN KEY (slot_id) REFERENCES Slot(slot_id)
);

INSERT INTO Slot VALUES (1, 'car', TRUE), (2, 'car', TRUE), (3, 'bike', TRUE);

INSERT INTO Vehicle VALUES ('TN01AB1234', 'car', 'Arjun Kumar');

SELECT slot_id FROM Slot WHERE type = 'car' AND is_available = TRUE LIMIT 1;

INSERT INTO Parking (vehicle_no, slot_id, entry_time)
VALUES ('TN01AB1234', 1, NOW());

UPDATE Slot SET is_available = FALSE WHERE slot_id = 1;

UPDATE Parking
SET exit_time = NOW(),
    charge = TIMESTAMPDIFF(HOUR, entry_time, NOW()) * 20
WHERE vehicle_no = 'TN01AB1234' AND exit_time IS NULL;

UPDATE Slot
SET is_available = TRUE
WHERE slot_id = (SELECT slot_id FROM Parking WHERE vehicle_no = 'TN01AB1234' ORDER BY parking_id DESC LIMIT 1);
SELECT v.vehicle_no, v.type, p.entry_time, s.slot_id
FROM Vehicle v
JOIN Parking p ON v.vehicle_no = p.vehicle_no
JOIN Slot s ON p.slot_id = s.slot_id
WHERE p.exit_time IS NULL;
