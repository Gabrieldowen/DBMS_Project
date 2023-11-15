-- Drop before creating
DROP TABLE IF EXISTS CostTransaction;
DROP TABLE IF EXISTS JobCut;
DROP TABLE IF EXISTS JobPaint;
DROP TABLE IF EXISTS JobFit;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS JobType;
DROP TABLE IF EXISTS AssemblyXREF;
DROP TABLE IF EXISTS Process;
DROP TABLE IF EXISTS ProcessInfo;
DROP TABLE IF EXISTS ProcessType;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Assembly;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS AccountType;
DROP TABLE IF EXISTS JobType;

-- Create AccountType Table
CREATE TABLE AccountType (
    AccountTypeID INT PRIMARY KEY,
    AccountTypeName VARCHAR(255)
);

-- Insert the types
INSERT INTO AccountType(AccountTypeID, AccountTypeName)
VALUES (1, 'Assembly'), (2, 'Department'), (3, 'Process')

-- Create Account Table
CREATE TABLE Account (
    AccountNumber INT PRIMARY KEY,
    DateCreated DATE,
    Details FLOAT,
    AccountTypeID INT,
    FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID)
);

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
    AccountNumber INT,
    FOREIGN KEY (CustomerName) REFERENCES Customer(CustomerName),
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber)
);

-- Create Department Table
CREATE TABLE Department (
    DepartmentNumber INT PRIMARY KEY,
    DepartmentData VARCHAR(255),
    AccountNumber INT,
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber)
);


CREATE TABLE ProcessType(
    ProcessTypeID INT PRIMARY KEY,
    ProcessType VARCHAR(20)
)

-- Insert the types
INSERT INTO ProcessType(ProcessTypeID, ProcessType)
VALUES (1, 'Fit'), (2, 'Cut'), (3, 'Paint')

CREATE TABLE ProcessInfo (
    ProcessInfoID INT PRIMARY KEY,
    Attr1 VARCHAR(255),
    Attr2 VARCHAR(255)
);
-- Create Process Table
CREATE TABLE Process (
    ProcessID INT PRIMARY KEY,
    AssemblyID INT,
    ProcessData VARCHAR(255),
    ProcessInfoID INT,
    ProcessTypeID INT, 
    DepartmentNumber INT,
    AccountNumber INT, 
    FOREIGN KEY (AssemblyID) REFERENCES [Assembly](AssemblyID),
    FOREIGN KEY (DepartmentNumber) REFERENCES Department(DepartmentNumber),
    FOREIGN KEY (ProcessTypeID) REFERENCES ProcessType(ProcessTypeID),
    FOREIGN KEY (ProcessInfoID) REFERENCES ProcessInfo(ProcessInfoID),
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber)
);

CREATE TABLE AssemblyXREF (
    ProcessID INT,
    AssemblyID INT,
    PRIMARY KEY (ProcessID, AssemblyID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
    FOREIGN KEY (AssemblyID) REFERENCES Assembly(AssemblyID)

);


CREATE TABLE JobType(
    JobTypeID   INT PRIMARY KEY,
    JobTypeName VARCHAR(50)

)
-- Insert the types
INSERT INTO JobType(JobTypeID, JobTypeName)
VALUES (1, 'Fit'), (2, 'Paint'), (3, 'Cut')

-- Create Job Table
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    JobDateStart DATE,
    JobDateEnd DATE,
    JobTypeID INT,
    ProcessID INT,
    AssemblyID INT,
    LaborTime FLOAT,
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
    FOREIGN KEY (AssemblyID) REFERENCES Assembly(AssemblyID),
    CONSTRAINT fkJobType FOREIGN KEY (JobTypeID) REFERENCES JobType(JobTypeID)
);


-- Create JobFit Table
CREATE TABLE JobFit (
    JobID INT PRIMARY KEY,
    CONSTRAINT fkFitJob FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create JobPaint Table
CREATE TABLE JobPaint (
    JobID INT PRIMARY KEY,
    Color VARCHAR(255),
    Volume FLOAT,
   
    --FOREIGN KEY (JobID) REFERENCES Job(JobID)
    CONSTRAINT fkPaintJob FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create JobCut Table
CREATE TABLE JobCut (
    JobID INT PRIMARY KEY,
    MachineType VARCHAR(255),
    Material VARCHAR(255),
    MachineTime FLOAT,
    --FOREIGN KEY (JobID) REFERENCES Job(JobID)
    CONSTRAINT fkCutJob FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Create Transaction Table
CREATE TABLE CostTransaction (
    TransactionNumber INT PRIMARY KEY,
    SupCost FLOAT,
    JobID INT,
    ProcessAccountID    INT,
    DepartmentAccountID    INT,
    AssemblyAccountID    INT,
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);




