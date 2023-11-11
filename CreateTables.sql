-- Create Customer Table
CREATE TABLE Customer (
    CustomerName VARCHAR(255),
    Address VARCHAR(255),
    Category INT,
    PRIMARY KEY (CustomerName)
);

-- Create Assembly Table
CREATE TABLE Assembly (
    AssemblyID INT PRIMARY KEY,
    DateOrdered DATE,
    AssemblyDetails VARCHAR(255)
);

-- Create Process Table
CREATE TABLE Process (
    ProcessID INT PRIMARY KEY,
    ProcessData VARCHAR(255)
);

-- Create ProcessFit Table
CREATE TABLE ProcessFit (
    ProcessTypeID INT PRIMARY KEY,
    FitType VARCHAR(255),
    FOREIGN KEY (ProcessTypeID) REFERENCES Process(ProcessID)
);

-- Create ProcessPaint Table
CREATE TABLE ProcessPaint (
    ProcessTypeID INT PRIMARY KEY,
    PaintType VARCHAR(255),
    PaintMethod VARCHAR(255),
    FOREIGN KEY (ProcessTypeID) REFERENCES Process(ProcessID)
);

-- Create ProcessCut Table
CREATE TABLE ProcessCut (
    ProcessTypeID INT PRIMARY KEY,
    CuttingType VARCHAR(255),
    CuttingMachine VARCHAR(255),
    FOREIGN KEY (ProcessTypeID) REFERENCES Process(ProcessID)
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
    FitID INT PRIMARY KEY,
    JobTypeID INT,
    LaborTime FLOAT,
    FOREIGN KEY (JobTypeID) REFERENCES Job(JobID)
);

-- Create JobPaint Table
CREATE TABLE JobPaint (
    PaintID INT PRIMARY KEY,
    JobTypeID INT,
    Color VARCHAR(255),
    Volume FLOAT,
    LaborTime FLOAT,
    FOREIGN KEY (JobTypeID) REFERENCES Job(JobID)
);

-- Create JobCut Table
CREATE TABLE JobCut (
    CutID INT PRIMARY KEY,
    JobTypeID INT,
    MachineType VARCHAR(255),
    Material VARCHAR(255),
    LaborTime FLOAT,
    FOREIGN KEY (JobTypeID) REFERENCES Job(JobID)
);

-- Create Transaction Table
CREATE TABLE Transaction (
    TransactionNumber INT PRIMARY KEY,
    SupCost FLOAT
);

-- Create Account Table
CREATE TABLE Account (
    AccountNumber INT PRIMARY KEY,
    DateCreated DATE,
    Category VARCHAR(255)
);

-- Create AccountType Table
CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY,
    AccountTypeName VARCHAR(255)
);

-- Create Relationships

-- AccountHas Relationship
CREATE TABLE AccountHas (
    AccountNumber INT,
    AccountTypeID INT,
    PRIMARY KEY (AccountNumber, AccountTypeID),
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber),
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID)
);

-- Updates Relationship
CREATE TABLE Updates (
    AccountNumber INT,
    TransactionNumber INT,
    PRIMARY KEY (AccountNumber, TransactionNumber),
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber),
    FOREIGN KEY (TransactionNumber) REFERENCES Transaction(TransactionNumber)
);

-- CostRecorded Relationship
CREATE TABLE CostRecorded (
    TransactionNumber INT,
    AssemblyID INT,
    DepartmentNumber INT,
    JobID INT,
    PRIMARY KEY (TransactionNumber, AssemblyID, DepartmentNumber, JobID),
    FOREIGN KEY (TransactionNumber) REFERENCES Transaction(TransactionNumber),
    FOREIGN KEY (AssemblyID) REFERENCES Assembly(AssemblyID),
    FOREIGN KEY (DepartmentNumber) REFERENCES Department(DepartmentNumber),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Order Relationship
CREATE TABLE Order (
    CustomerName VARCHAR(255),
    AssemblyID INT,
    PRIMARY KEY (CustomerName, AssemblyID),
    FOREIGN KEY (CustomerName) REFERENCES Customer(CustomerName),
    FOREIGN KEY (AssemblyID) REFERENCES Assembly(AssemblyID)
);

-- Manufactures Relationship
CREATE TABLE Manufactures (
    AssemblyID INT,
    ProcessID INT,
    PRIMARY KEY (AssemblyID, ProcessID),
    FOREIGN KEY (AssemblyID) REFERENCES Assembly(AssemblyID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);

-- Supervises Relationship
CREATE TABLE Supervises (
    DepartmentNumber INT,
    ProcessID INT,
    PRIMARY KEY (DepartmentNumber, ProcessID),
    FOREIGN KEY (DepartmentNumber) REFERENCES Department(DepartmentNumber),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);

-- Works Relationship
CREATE TABLE Works (
    ProcessID INT,
    JobID INT,
    PRIMARY KEY (ProcessID, JobID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);
