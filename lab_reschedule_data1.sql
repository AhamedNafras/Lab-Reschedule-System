CREATE TABLE IF NOT EXISTS Users (
    UserID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(20),
    Email VARCHAR(100)
);

INSERT INTO Users (UserID, Name, Role, Email) VALUES
('U001', 'Nimal Perera', 'Student', 'nimal@eng.jfn.ac.lk'),
('U002', 'Kavindu Silva', 'Student', 'kavindu@eng.jfn.ac.lk'),
('U003', 'Dr. Ramesh', 'Coordinator', 'ramesh@eng.jfn.ac.lk'),
('U004', 'Prof. Sutharsan', 'Coordinator', 'sutharsan@eng.jfn.ac.lk'),
('U005', 'Ruwanthi Fernando', 'Student', 'ruwanthi@eng.jfn.ac.lk'),
('U006', 'Tharindu Jayasuriya', 'Student', 'tharindu@eng.jfn.ac.lk'),
('U007', 'Ayesha Nazeer', 'Student', 'ayesha@eng.jfn.ac.lk'),
('U008', 'Dr. Kamal', 'Coordinator', 'kamal@eng.jfn.ac.lk'),
('U009', 'Hashan Madushanka', 'Student', 'hashan@eng.jfn.ac.lk'),
('U010', 'Isuri Dissanayake', 'Student', 'isuri@eng.jfn.ac.lk');


CREATE TABLE IF NOT EXISTS Labs (
    LabID VARCHAR(10) PRIMARY KEY,
    LabName VARCHAR(100),
    Location VARCHAR(50),
    AvailabilityStatus VARCHAR(20)
);

INSERT INTO Labs (LabID, LabName, Location, AvailabilityStatus) VALUES
('L001', 'DSP Lab', 'Block A', 'Available'),
('L002', 'Embedded Systems Lab', 'Block B', 'Not Available'),
('L003', 'Power Electronics Lab', 'Block C', 'Available'),
('L004', 'Control Systems Lab', 'Block A', 'Available'),
('L005', 'Computer Architecture Lab', 'Block D', 'Not Available'),
('L006', 'VLSI Lab', 'Block E', 'Available'),
('L007', 'Communications Lab', 'Block C', 'Available'),
('L008', 'Mechatronics Lab', 'Block B', 'Available'),
('L009', 'Circuits Lab', 'Block F', 'Not Available'),
('L010', 'Microprocessors Lab', 'Block E', 'Available');


CREATE TABLE IF NOT EXISTS Lab_Schedule (
    ScheduleID VARCHAR(10) PRIMARY KEY,
    LabID VARCHAR(10),
    CoordinatorID VARCHAR(10),
    TimeSlot VARCHAR(20),
    Date DATE,
    FOREIGN KEY (LabID) REFERENCES Labs(LabID),
    FOREIGN KEY (CoordinatorID) REFERENCES Users(UserID)
);

INSERT INTO Lab_Schedule VALUES
('S001', 'L001', 'U003', '08:00-10:00', '2025-06-01'),
('S002', 'L002', 'U004', '10:00-12:00', '2025-06-01'),
('S003', 'L003', 'U003', '12:00-14:00', '2025-06-02'),
('S004', 'L004', 'U004', '14:00-16:00', '2025-06-03'),
('S005', 'L005', 'U008', '08:00-10:00', '2025-06-04'),
('S006', 'L006', 'U003', '10:00-12:00', '2025-06-04'),
('S007', 'L007', 'U008', '12:00-14:00', '2025-06-05'),
('S008', 'L008', 'U004', '14:00-16:00', '2025-06-06'),
('S009', 'L009', 'U003', '08:00-10:00', '2025-06-06'),
('S010', 'L010', 'U008', '10:00-12:00', '2025-06-07');


CREATE TABLE IF NOT EXISTS Attendance (
    AttendanceID VARCHAR(10) PRIMARY KEY,
    StudentID VARCHAR(10),
    ScheduleID VARCHAR(10),
    AttendanceStatus VARCHAR(20),
    FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    FOREIGN KEY (ScheduleID) REFERENCES Lab_Schedule(ScheduleID)
);

INSERT INTO Attendance VALUES
('A001', 'U001', 'S001', 'Present'),
('A002', 'U002', 'S002', 'Absent'),
('A003', 'U005', 'S003', 'Present'),
('A004', 'U006', 'S004', 'Late'),
('A005', 'U007', 'S005', 'Present'),
('A006', 'U009', 'S006', 'Absent'),
('A007', 'U010', 'S007', 'Present'),
('A008', 'U001', 'S008', 'Absent'),
('A009', 'U002', 'S009', 'Present'),
('A010', 'U005', 'S010', 'Present');


CREATE TABLE IF NOT EXISTS Reschedule_Request (
    RequestID VARCHAR(10) PRIMARY KEY,
    StudentID VARCHAR(10),
    ScheduleID VARCHAR(10),
    Reason VARCHAR(100),
    ApprovalLetter VARCHAR(5),
    Status VARCHAR(20),
    SubmittedDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Users(UserID),
    FOREIGN KEY (ScheduleID) REFERENCES Lab_Schedule(ScheduleID)
);

INSERT INTO Reschedule_Request VALUES
('R001', 'U001', 'S001', 'Medical issue', 'Yes', 'Approved', '2025-06-01'),
('R002', 'U002', 'S002', 'Family event', 'No', 'Pending', '2025-06-01'),
('R003', 'U005', 'S003', 'Personal', 'Yes', 'Rejected', '2025-06-02'),
('R004', 'U006', 'S004', 'Travel', 'Yes', 'Approved', '2025-06-03'),
('R005', 'U007', 'S005', 'Illness', 'No', 'Pending', '2025-06-04'),
('R006', 'U009', 'S006', 'Emergency', 'Yes', 'Approved', '2025-06-04'),
('R007', 'U010', 'S007', 'Conflict', 'No', 'Rejected', '2025-06-05'),
('R008', 'U001', 'S008', 'Religious', 'Yes', 'Pending', '2025-06-06'),
('R009', 'U002', 'S009', 'Other reason', 'No', 'Approved', '2025-06-06'),
('R010', 'U005', 'S010', 'Double booking', 'Yes', 'Pending', '2025-06-07');


CREATE TABLE IF NOT EXISTS Logs (
    LogID VARCHAR(10) PRIMARY KEY,
    RequestID VARCHAR(10),
    Action VARCHAR(20),
    PerformedBy VARCHAR(10),
    Timestamp DATETIME,
    FOREIGN KEY (RequestID) REFERENCES Reschedule_Request(RequestID),
    FOREIGN KEY (PerformedBy) REFERENCES Users(UserID)
);

INSERT INTO Logs VALUES
('LG01', 'R001', 'Submitted', 'U001', '2025-06-01 10:00:00'),
('LG02', 'R001', 'Approved', 'U003', '2025-06-01 11:00:00'),
('LG03', 'R002', 'Submitted', 'U002', '2025-06-01 12:00:00'),
('LG04', 'R003', 'Submitted', 'U005', '2025-06-02 09:30:00'),
('LG05', 'R003', 'Rejected', 'U004', '2025-06-02 10:30:00'),
('LG06', 'R004', 'Submitted', 'U006', '2025-06-03 08:45:00'),
('LG07', 'R004', 'Approved', 'U003', '2025-06-03 09:45:00'),
('LG08', 'R005', 'Submitted', 'U007', '2025-06-04 11:00:00'),
('LG09', 'R006', 'Submitted', 'U009', '2025-06-04 13:00:00'),
('LG10', 'R006', 'Approved', 'U008', '2025-06-04 14:00:00');


CREATE TABLE IF NOT EXISTS Notifications (
    NotificationID VARCHAR(10) PRIMARY KEY,
    RequestID VARCHAR(10),
    RecipientID VARCHAR(10),
    Message VARCHAR(100),
    SentDate DATE,
    FOREIGN KEY (RequestID) REFERENCES Reschedule_Request(RequestID),
    FOREIGN KEY (RecipientID) REFERENCES Users(UserID)
);

INSERT INTO Notifications VALUES
('N001', 'R001', 'U001', 'Request Approved', '2025-06-01'),
('N002', 'R002', 'U002', 'Request Received', '2025-06-01'),
('N003', 'R003', 'U005', 'Request Rejected', '2025-06-02'),
('N004', 'R004', 'U006', 'Request Approved', '2025-06-03'),
('N005', 'R005', 'U007', 'Request Under Review', '2025-06-04'),
('N006', 'R006', 'U009', 'Request Approved', '2025-06-04'),
('N007', 'R007', 'U010', 'Request Rejected', '2025-06-05'),
('N008', 'R008', 'U001', 'Request Under Review', '2025-06-06'),
('N009', 'R009', 'U002', 'Request Approved', '2025-06-06'),
('N010', 'R010', 'U005', 'Request Under Review', '2025-06-07');


