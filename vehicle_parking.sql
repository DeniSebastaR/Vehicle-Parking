CREATE DATABASE parking_db;
USE parking_db;

CREATE TABLE parked_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_number VARCHAR(20) NOT NULL UNIQUE,
    owner_name VARCHAR(50) NOT NULL,
    vehicle_type ENUM('Car', 'Bike', 'Other') NOT NULL,
    slot_number INT NOT NULL UNIQUE
);
INSERT INTO parked_vehicles (vehicle_number, owner_name, vehicle_type, slot_number) VALUES 
('TN01AB1234', 'Ravi Kumar', 'Car', 101),
('KA05CD5678', 'Sita Sharma', 'Bike', 102),
('MH12EF9012', 'Arjun Mehta', 'Car', 103),
('DL04GH3456', 'Neha Verma', 'Other', 104);
ALTER TABLE parked_vehicles 
ADD COLUMN entry_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Time when the vehicle was parked
ADD COLUMN exit_time TIMESTAMP NULL,  -- Time when the vehicle left
ADD COLUMN contact_number VARCHAR(15) NOT NULL,  -- Owner's contact number
ADD COLUMN parking_fee DECIMAL(10,2) DEFAULT 0.00,  -- Parking fee charged
ADD COLUMN status ENUM('Parked', 'Exited') DEFAULT 'Parked',  -- Current status of the vehicle
ADD COLUMN vehicle_model VARCHAR(50),  -- Vehicle model name
ADD COLUMN duration INT DEFAULT 0;  -- Duration of parking in hours
UPDATE parked_vehicles 
SET exit_time = NOW(), 
    status = 'Exited', 
    duration = TIMESTAMPDIFF(HOUR, entry_time, NOW()), 
    parking_fee = duration * 10 
WHERE vehicle_number = 'TN01AB1234';
SELECT * FROM parked_vehicles;
