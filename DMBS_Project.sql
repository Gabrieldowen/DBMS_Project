-- Drop before creating
DROP TABLE IF EXISTS JobFit;
DROP TABLE IF EXISTS JobPaint;
DROP TABLE IF EXISTS JobCut;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS Process;
DROP TABLE IF EXISTS ProcessFit;
DROP TABLE IF EXISTS ProcessPaint;
DROP TABLE IF EXISTS ProcessCut;
DROP TABLE IF EXISTS ProcessType;
DROP TABLE IF EXISTS ProcessInfo;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Assembly;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS AccountType;
DROP TABLE IF EXISTS CostTransaction;



-- Create Customer Table
CREATE TABLE Customer (
    CustomerName VARCHAR(255) PRIMARY KEY,
    [Address] VARCHAR(255),
    Category INT CHECK (Category BETWEEN 1 AND 10),
);

-- Create Assembly Table
CREATE TABLE Assembly (
    AssemblyID INT PRIMARY KEY,
    DateOrdered DATE,
    AssemblyDetails VARCHAR(255),
    CustomerName VARCHAR(255),
    FOREIGN KEY (CustomerName) REFERENCES Customer(CustomerName)
);

-- Create Department Table
CREATE TABLE Department (
    DepartmentNumber INT PRIMARY KEY,
    DepartmentData VARCHAR(255)
);


CREATE TABLE ProcessType(
    ProcessTypeID INT PRIMARY KEY,
    ProcessType VARCHAR(20)
)

-- Insert the types
INSERT INTO ProcessType(ProcessTypeID, ProcessType)
VALUES (1, 'Fit'), (2, 'Cut'), (3, 'Paint')
/*
-- Create ProcessFit Table
CREATE TABLE ProcessFit (
    ProcessID INT PRIMARY KEY,
    FitType VARCHAR(255)
);

-- Create ProcessPaint Table
CREATE TABLE ProcessPaint (
    ProcessID INT PRIMARY KEY,
    PaintType VARCHAR(255),
    PaintMethod VARCHAR(255)
);

-- Create ProcessCut Table
CREATE TABLE ProcessCut (
    ProcessID INT PRIMARY KEY,
    CuttingType VARCHAR(255),
    CuttingMachine VARCHAR(255)
);
*/

CREATE TABLE ProcessInfo (
    ProcessInfoID INT PRIMARY KEY,
    Attr1 VARCHAR(255),
    Attr2 VARCHAR(255)
);
-- Create Process Table
CREATE TABLE Process (
    ProcessID INT PRIMARY KEY,
    ProcessData VARCHAR(255),
    ProcessInfoID INT,
    ProcessTypeID INT, 
    DepartmentNumber INT,
    FOREIGN KEY (DepartmentNumber) REFERENCES Department(DepartmentNumber),
    FOREIGN KEY (ProcessTypeID) REFERENCES ProcessType(ProcessTypeID),
    FOREIGN KEY (ProcessInfoID) REFERENCES ProcessInfo(ProcessInfoID) ON DELETE CASCADE, 
);



-- Create Job Table
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    JobDateStart DATE,
    JobDateEnd DATE,
    JobTypeID INT
);

-- Create JobFit Table
CREATE TABLE JobFit (
    JobTypeID INT,
    LaborTime FLOAT,
    JobID INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create JobPaint Table
CREATE TABLE JobPaint (
    JobTypeID INT,
    Color VARCHAR(255),
    Volume FLOAT,
    LaborTime FLOAT,
    JobID INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create JobCut Table
CREATE TABLE JobCut (
    JobTypeID INT,
    MachineType VARCHAR(255),
    Material VARCHAR(255),
    LaborTime FLOAT,
    JobID INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create Transaction Table
CREATE TABLE CostTransaction (
    TransactionNumber INT PRIMARY KEY,
    SupCost FLOAT
);

-- Create AccountType Table
CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY,
    AccountTypeName VARCHAR(255)
);

-- Create Account Table
CREATE TABLE Account (
    AccountNumber INT PRIMARY KEY,
    DateCreated DATE,
    Category VARCHAR(255),
    AccountTypeID INT,
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID)
);

