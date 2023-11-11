-- Create Customer Table
CREATE TABLE Customer (
    CustomerName VARCHAR(255),
    [Address] VARCHAR(255),
    Category INT,
);

-- Create Assembly Table
CREATE TABLE Assembly (
    AssemblyID INT PRIMARY KEY,
    DateOrdered DATE,
    AssemblyDetails VARCHAR(255),
    CustomerName VARCHAR(255),
    FOREIGN KEY (CustomerName) REFERENCES Customer(CustomerName)
);

-- Create Process Table
CREATE TABLE Process (
    ProcessID INT PRIMARY KEY,
    ProcessData VARCHAR(255)
);

-- Create ProcessFit Table
CREATE TABLE ProcessFit (
    FitType VARCHAR(255),
    ProcessID INT,
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);

-- Create ProcessPaint Table
CREATE TABLE ProcessPaint (
    PaintType VARCHAR(255),
    PaintMethod VARCHAR(255),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);

-- Create ProcessCut Table
CREATE TABLE ProcessCut (
    CuttingType VARCHAR(255),
    CuttingMachine VARCHAR(255),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
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
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create JobPaint Table
CREATE TABLE JobPaint (
    JobTypeID INT,
    Color VARCHAR(255),
    Volume FLOAT,
    LaborTime FLOAT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create JobCut Table
CREATE TABLE JobCut (
    JobTypeID INT,
    MachineType VARCHAR(255),
    Material VARCHAR(255),
    LaborTime FLOAT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create Transaction Table
CREATE TABLE CostTransaction (
    TransactionNumber INT PRIMARY KEY,
    SupCost FLOAT
);

-- Create Account Table
CREATE TABLE Account (
    AccountNumber INT PRIMARY KEY,
    DateCreated DATE,
    Category VARCHAR(255)
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID)
);

-- Create AccountType Table
CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY,
    AccountTypeName VARCHAR(255)
);