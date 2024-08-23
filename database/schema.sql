-- Create Users table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME2
);

-- Create Tasks table
CREATE TABLE Tasks (
    TaskID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('New', 'In Progress', 'Completed', 'On Hold')),
    Priority NVARCHAR(10) NOT NULL CHECK (Priority IN ('Low', 'Medium', 'High')),
    CreatedBy INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    DueDate DATETIME2,
    CompletedAt DATETIME2,
    Price DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- Create TaskAssignments table
CREATE TABLE TaskAssignments (
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    TaskID INT NOT NULL,
    AssignedTo INT NOT NULL,
    AssignedBy INT NOT NULL,
    AssignedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID),
    FOREIGN KEY (AssignedTo) REFERENCES Users(UserID),
    FOREIGN KEY (AssignedBy) REFERENCES Users(UserID)
);

-- Create Payments table
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    TaskID INT NOT NULL,
    PayerID INT NOT NULL,
    PayeeID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Completed', 'Failed')),
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID),
    FOREIGN KEY (PayerID) REFERENCES Users(UserID),
    FOREIGN KEY (PayeeID) REFERENCES Users(UserID)
);

-- Create indexes
CREATE INDEX IX_Tasks_Status ON Tasks(Status);
CREATE INDEX IX_Tasks_Priority ON Tasks(Priority);
CREATE INDEX IX_Tasks_DueDate ON Tasks(DueDate);
CREATE INDEX IX_Tasks_CompletedAt ON Tasks(CompletedAt);
CREATE INDEX IX_TaskAssignments_AssignedTo ON TaskAssignments(AssignedTo);
CREATE INDEX IX_TaskAssignments_AssignedBy ON TaskAssignments(AssignedBy);
CREATE INDEX IX_Payments_PayerID ON Payments(PayerID);
CREATE INDEX IX_Payments_PayeeID ON Payments(PayeeID);
CREATE INDEX IX_Payments_PaymentDate ON Payments(PaymentDate);