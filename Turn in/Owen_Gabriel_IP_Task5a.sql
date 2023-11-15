
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new customer
CREATE PROCEDURE [dbo].[usp_InsertCustomer]
    @CustomerName VARCHAR(255),
    @Address VARCHAR(255),
    @Category INT
AS
BEGIN
    -- Check if the customer already exists
    IF @Category >= 1 AND @Category <= 10
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerName = @CustomerName)
        BEGIN
            -- Insert the new customer
            INSERT INTO Customer (CustomerName, [Address], Category)
            VALUES (@CustomerName, @Address, @Category);
        END
    END
END;

GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new department
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
CREATE PROCEDURE [dbo].[usp_CreateNewDepartment]
(
    @DepartmentNumber INT,
    @DepartmentData VARCHAR(255)
)

AS
BEGIN
    -- Check if the department number already exists
    IF NOT EXISTS (SELECT 1 FROM Department WHERE DepartmentNumber = @DepartmentNumber)
    BEGIN
        -- Insert the new department
        INSERT INTO Department (
            DepartmentNumber, 
            DepartmentData)
        VALUES (
            @DepartmentNumber, 
            @DepartmentData);

    END
END;
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- InsertProcessWithType 3, 1, 1, 2, 'THE FIT'
CREATE PROCEDURE [dbo].[usp_CreateProcess]
(
    @ProcessID          INT,
    @ProcessTypeID      INT,
    @DepartmentNumber   INT,
    @ProcessInfoID      INT,
    @Attr1              VARCHAR(255),
    @Attr2              VARCHAR(255)    =   NULL
)

AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Department
        WHERE @DepartmentNumber = DepartmentNumber
    ) 
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Process WHERE ProcessID = @ProcessID)
            BEGIN

            -- insert process info
            INSERT INTO ProcessInfo(ProcessInfoID, Attr1, Attr2)
            VALUES (@ProcessInfoID, @Attr1, @Attr2)

            -- Insert into Process table
            INSERT INTO Process (ProcessID, ProcessTypeID, DepartmentNumber, ProcessInfoID)
            VALUES (@ProcessID, @ProcessTypeID, @DepartmentNumber,@ProcessInfoID);

            PRINT 'Process with type information inserted successfully.';
        END
    END
END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- usp_InsertCustomer 'Gabe', 'Norman', '1'
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- usp_CreateProcess 2, 1, 1, 2, 'Another type'
-- usp_CreateAssembly 1,  '2023-11-12', 'Details', 'Gabe', 2
CREATE PROCEDURE [dbo].[usp_CreateAssembly]
(
    @AssemblyID         INT,
    @DateOrdered        DATE,
    @AssemblyDetails    VARCHAR(255),
    @CustomerName       VARCHAR(255),
    @ProcessID          INT

)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customer WHERE CustomerName = @CustomerName)
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM [Assembly] WHERE [AssemblyID] = @AssemblyID)
        BEGIN
            INSERT INTO [Assembly] (AssemblyID, CustomerName, DateOrdered, AssemblyDetails)
            VALUES (@AssemblyID, @CustomerName, @DateOrdered, @AssemblyDetails)

            INSERT INTO [AssemblyXREF] (AssemblyID, ProcessID)
                VALUES(@AssemblyID, @ProcessID)
        END
        ELSE
        BEGIN
            INSERT INTO [AssemblyXREF] (AssemblyID, ProcessID)
                    VALUES(@AssemblyID, @ProcessID)
        END
    END

END;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*

EXEC usp_InsertCustomer 'Gabe', 'Norman', '1'
EXEC usp_CreateNewDepartment 1, 'Datatatatatatatta'
EXEC usp_CreateProcess 3, 1, 1, 2, 'Another type'
EXEC usp_CreateAssembly 2,  '2023-11-12', 'Details', 'Gabe', 3

-- Associate with a assembly
EXEC [dbo].[usp_CreateAccount] 1, 2, '2023-11-12', 0, 1

-- Associate with a department
EXEC [dbo].[usp_CreateAccount] 2, 1, '2023-11-12', 0, 2

-- Associate with a process
EXEC [dbo].[usp_CreateAccount] 3, 3, '2023-11-12', 0, 3
*/
-- 
-- 
CREATE PROCEDURE [dbo].[usp_CreateAccount]
(
    @AccountNumber      INT,
    @AssociationID      INT,
    @DateCreated        DATE,
    --@Details            FLOAT,
    @AccountTypeID      INT 
)

AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM AccountType
        WHERE @AccountTypeID = AccountTypeID
    ) 
    BEGIN
        IF( @AccountTypeID = 1)    -- Assembly Account type
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Account WHERE AccountNumber = @AccountNumber)
            BEGIN
                INSERT INTO Account(AccountNumber, DateCreated, Details, AccountTypeID)
                VALUES (@AccountNumber, @DateCreated, 0, @AccountTypeID)

                UPDATE [dbo].[Assembly]
                SET AccountNumber = @AccountNumber
                WHERE [AssemblyID] = @AssociationID

            END
            ELSE
            BEGIN
                UPDATE [dbo].[Assembly]
                SET AccountNumber = @AccountNumber
                WHERE [AssemblyID] = @AssociationID
            END
        END
        IF( @AccountTypeID = 2) -- Department
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Account WHERE AccountNumber = @AccountNumber)
            BEGIN
                INSERT INTO Account(AccountNumber, DateCreated, Details, AccountTypeID)
                VALUES (@AccountNumber, @DateCreated, 0, @AccountTypeID)

                UPDATE Department
                SET AccountNumber = @AccountNumber
                WHERE DepartmentNumber = @AssociationID

            END
            BEGIN
                UPDATE Department
                SET AccountNumber = @AccountNumber
                WHERE DepartmentNumber = @AssociationID

            END
        END
        IF( @AccountTypeID = 3) -- Process
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Account WHERE AccountNumber = @AccountNumber)
            BEGIN
                INSERT INTO Account(AccountNumber, DateCreated, Details, AccountTypeID)
                VALUES (@AccountNumber, @DateCreated, 0, @AccountTypeID)

                UPDATE Process
                SET AccountNumber = @AccountNumber
                WHERE ProcessID = @AssociationID

            END
            BEGIN
                UPDATE Process
                SET AccountNumber = @AccountNumber
                WHERE ProcessID = @AssociationID
            END
        END
    END
END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*

EXEC usp_InsertCustomer 'Gabe', 'Norman', '1'
EXEC usp_CreateNewDepartment 1, 'Datatatatatatatta'
EXEC usp_CreateProcess 3, 1, 1, 2, 'Another type'
EXEC usp_CreateAssembly 2,  '2023-11-12', 'Details', 'Gabe', 3

-- creates fit job
EXEC [dbo].[usp_CreateJob] 1, 2, 3, '2023-11-12'

-- creates paint job
EXEC [dbo].[usp_CreateJob] 2, 2, 3, '2023-11-12'

-- creates cut job
EXEC [dbo].[usp_CreateJob] 3, 2, 3, '2023-11-12'
*/
-- 
-- 
CREATE PROCEDURE [dbo].[usp_CreateJob]
(
    @JobID              INT,
    @AssemblyID         INT,
    @ProcessID          INT,
    @JobDateStart       DATE
)

AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Job WHERE JobID = @JobID)
    BEGIN
        IF EXISTS (SELECT 1 FROM Process WHERE ProcessID  = @ProcessID )
        BEGIN
            IF EXISTS (SELECT 1 FROM [Assembly] WHERE AssemblyID = @AssemblyID )
            BEGIN
                    INSERT INTO Job(JobID, AssemblyID, ProcessID, JobDateStart)
                    VALUES (@JobID, @AssemblyID, @ProcessID, @JobDateStart)
                    PRINT 'INSERTED JOB'
                  
            END
            ELSE
            PRINT 'Assembly Doesnt Exist'
        END
        ELSE
            PRINT 'Process Doesnt Exist'
    END

    ELSE
    BEGIN
        IF EXISTS (SELECT 1 FROM Process WHERE @ProcessID = ProcessID)
        BEGIN
            IF EXISTS (SELECT 1 FROM [Assembly] WHERE @AssemblyID = AssemblyID)
            BEGIN
                    UPDATE [dbo].[Job]
                    SET JobID = @JobID,
                        AssemblyID = @AssemblyID,
                        ProcessID = @ProcessID,
                        JobDateStart = @JobDateStart
                    WHERE [JobID] = @JobID
            END
            ELSE
            PRINT 'Assembly Doesnt Exist'
        END
        ELSE
            PRINT 'Process Doesnt Exist'
        END
    
END;
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*

EXEC usp_InsertCustomer 'Gabe', 'Norman', '1'
EXEC usp_CreateNewDepartment 1, 'Datatatatatatatta'
EXEC usp_CreateProcess 3, 1, 1, 2, 'Another type'
EXEC usp_CreateAssembly 2,  '2023-11-12', 'Details', 'Gabe', 3

-- creates fit job
EXEC [dbo].[usp_CompleteJob] 1, 1 , '2023-11-12', 0.69

-- creates paint job
EXEC [dbo].[usp_CompleteJob] 2, 2, '2023-11-12', 0.69, 'BLUE', 100

-- creates cut job
EXEC [dbo].[usp_CompleteJob] 3, 3, '2023-11-12', 0.69, null, null, 'CUTTER2000', 12, 'Titanium'
*/
-- 
-- 
CREATE PROCEDURE [dbo].[usp_CompleteJob]
(
    @JobID              INT,
    @JobTypeID          INT,
    @JobDateEnd         DATE,
    @LaborTime          FLOAT,
    @Color              VARCHAR(255) = NULL,
    @Volume             FLOAT = NULL,
    @MachineType        VARCHAR(255)= NULL, 
    @MachineTime        FLOAT = NULL, 
    @Material           VARCHAR(255) = NULL
)

AS
BEGIN
    IF EXISTS (SELECT 1 FROM Job WHERE JobID = @JobID)
    BEGIN
            UPDATE Job
            SET JobID = @JobID, 
                JobDateEnd = @JobDateEnd,
                JobTypeID = @JobTypeID,
                LaborTime = @LaborTime
            WHERE JobID = @JobID
            PRINT 'UPDATE JOB'
            IF(@JobTypeID = 1)
            BEGIN
                PRINT 'Inserting job fit type'
                INSERT INTO JobFit(JobID)
                VALUES (@JobID)
            END
            IF(@JobTypeID = 2)
            BEGIN
                PRINT 'Inserting job paint type'
                INSERT INTO JobPaint(JobID, Color, Volume)
                VALUES (@JobID, @Color, @Volume)
            END
            IF(@JobTypeID = 3)
            BEGIN
                PRINT 'Inserting job cut type'
                INSERT INTO JobCut(JobID, MachineType, MachineTime, Material)
                VALUES (@JobID, @MachineType, @MachineTime, @Material)
            END
    END
    ELSE
        PRINT('No Job Exists for that number')
    
END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*

EXEC usp_InsertCustomer 'Gabe', 'Norman', '1'
EXEC usp_CreateNewDepartment 1, 'Datatatatatatatta'
EXEC usp_CreateProcess 3, 1, 1, 2, 'Another type'
EXEC usp_CreateAssembly 2,  '2023-11-12', 'Details', 'Gabe', 3

-- Create accounts
EXEC [dbo].[usp_CreateAccount] 1, 2, '2023-11-12', 0, 1
EXEC [dbo].[usp_CreateAccount] 2, 1, '2023-11-12', 0, 2
EXEC [dbo].[usp_CreateAccount] 3, 3, '2023-11-12', 0, 3

EXEC [dbo].[usp_CreateJob] 1, 2, 3, '2023-11-12'
EXEC [dbo].[usp_CreateJob] 2, 2, 3, '2023-11-12'
EXEC [dbo].[usp_CreateJob] 3, 2, 3, '2023-11-12'

EXEC [dbo].[usp_CreateTransaction] 11, 9, 1
*/
-- 
-- 
CREATE PROCEDURE [dbo].[usp_CreateTransaction]
(
    @TransactionNumber      INT,
    @JobID                  INT,
    @SupCost                FLOAT
)

AS
BEGIN

   INSERT INTO CostTransaction (TransactionNumber,JobID, SupCost)
   VALUES(@TransactionNumber, @JobID, @SupCost)

   DECLARE @ProcessAccountNumber        INT;
   DECLARE @DepartmentAccountNumber     INT;
   DECLARE @AssemblyAccountNumber       INT;

   SELECT DISTINCT @ProcessAccountNumber = p.AccountNumber
   FROM Process p
   INNER JOIN Job j
   ON p.ProcessID = j.ProcessID
   INNER JOIN Account a
   ON p.AccountNumber = a.AccountNumber
   WHERE 1 = j.JobID

   SELECT DISTINCT @DepartmentAccountNumber = d.AccountNumber
   FROM Process p
   INNER JOIN Job j
   ON p.ProcessID = j.ProcessID
   INNER JOIN Department d
   ON d.DepartmentNumber = d.DepartmentNumber
   WHERE 1 = j.JobID
   
    SELECT DISTINCT @AssemblyAccountNumber = a.AccountNumber
    FROM Process p
    INNER JOIN Job j
        ON p.ProcessID = j.ProcessID
    INNER JOIN AssemblyXREF x
        ON x.ProcessID = p.ProcessID
    INNER JOIN [Assembly] a
        ON x.AssemblyID = a.AssemblyID
    WHERE 1 = j.JobID
   
   

   PRINT @ProcessAccountNumber
   PRINT @DepartmentAccountNumber
   PRINT @AssemblyAccountNumber

UPDATE Account
   SET Details += @SupCost
   WHERE AccountNumber = @ProcessAccountNumber

UPDATE Account
   SET Details += @SupCost
   WHERE AccountNumber = @DepartmentAccountNumber

UPDATE Account
   SET Details += @SupCost
   WHERE AccountNumber = @AssemblyAccountNumber
   

END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- usp_InsertCustomer 'Gabe', 'Norman', '1'
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- usp_CreateProcess 2, 1, 1, 2, 'Another type'
-- usp_CreateAssembly 1,  '2023-11-12', 'Details', 'Gabe', 2

CREATE PROCEDURE [dbo].[usp_GetAssemblyCost]
(
    @AssemblyID         INT

)
AS
BEGIN
    SELECT ac.AccountNumber, 
        a.AssemblyID, 
        ac.Details
    FROM Account ac
    INNER JOIN [Assembly] a
        ON a.AccountNumber = ac.AccountNumber
    Where a.AssemblyID = @AssemblyID 

END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*

EXEC usp_InsertCustomer 'Gabe', 'Norman', '1'
EXEC usp_CreateNewDepartment 1, 'Datatatatatatatta'
EXEC usp_CreateProcess 3, 1, 1, 2, 'Another type'
EXEC usp_CreateAssembly 2,  '2023-11-12', 'Details', 'Gabe', 3

-- creates fit job
EXEC [dbo].[usp_CreateJob] 1, 2, 3, '2023-11-12'

-- creates paint job
EXEC [dbo].[usp_CreateJob] 2, 2, 3, '2023-11-12'

-- creates cut job
EXEC [dbo].[usp_CreateJob] 4, 2, 3, '2023-11-12'

EXEC [dbo].[usp_CompleteJob] 1, 1 , '2023-11-12', 0.69
EXEC [dbo].[usp_CompleteJob] 2, 2 , '2023-11-12', 10
EXEC [dbo].[usp_CompleteJob] 4, 3 , '2024-11-12', 200

EXEC [dbo].[usp_GetDepartmentTime] 1,  '2023-12-12'
*/
-- 
-- 
CREATE PROCEDURE [dbo].[usp_GetDepartmentTime]
(
    @DepartmentNumber   INT,
    @StartDate          DATE = NULL,
    @EndDate            DATE = NULL
)

AS
BEGIN
   SELECT SUM(j.LaborTime)
   FROM Department d
   INNER JOIN Process p
   ON d.DepartmentNumber = p.DepartmentNumber
   INNER JOIN Job j
   ON j.ProcessID = p.ProcessID
   WHERE (j.JobDateEnd >= @StartDate OR @StartDate IS NULL)
   AND (j.JobDateEnd  <= @EndDate OR @EndDate IS NULL)
   AND d.DepartmentNumber = @DepartmentNumber
    
END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [dbo].[usp_GetCompletedProcesses] 1

CREATE PROCEDURE [dbo].[usp_GetCompletedProcesses]
(
    @AssemblyID         INT
)
AS
BEGIN
    SELECT DISTINCT p.ProcessID,
        p.DepartmentNumber,
        j.JobID,
        j.JobDateEnd
    FROM [Assembly] a
    INNER JOIN [AssemblyXREF] x
        ON a.AssemblyID = x.AssemblyID
    INNER JOIN Process p
        ON p.ProcessID = x.ProcessID
    INNER JOIN Job j
        ON j.ProcessID = p.ProcessID
    WHERE j.JobDateEnd IS NOT NULL
        AND a.AssemblyID = @AssemblyID
    ORDER BY j.JobDateEnd ASC

END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetCustomer]
(
    @CategoryMin        INT = NULL,
    @CategoryMax        INT = NULL
)
AS
BEGIN
    SELECT CustomerName,
        [Address],
        Category
    FROM Customer
    Where (Category >= @CategoryMin OR @CategoryMin IS NULL) AND
        (Category <= @CategoryMax OR @CategoryMax IS NULL)

END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DeleteJobs] 
(
    @JobIDMin        INT,
    @JobIDMax        INT
)
AS
BEGIN
    DELETE FROM JobCut
    WHERE (JobID >= @JobIDMin) 
        AND (JobID <= @JobIDMax)
    DELETE FROM CostTransaction
    WHERE (JobID >= @JobIDMin) 
        AND (JobID <= @JobIDMax)  
    DELETE FROM Job
    WHERE (JobID >= @JobIDMin) 
        AND (JobID <= @JobIDMax) 
        AND JobTypeID = 3

END;
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_ChangeColor]
(
    @JobID          INT,
    @Color          VARCHAR(255)
)
AS
BEGIN
    IF EXISTS(SELECT 1 FROM JobPaint WHERE JobID = @JobID)
    BEGIN
        UPDATE JobPaint
        SET Color = @Color
        WHERE JobID = @JobID
    END
    ELSE
    BEGIN
       PRINT('Selected Job is not of Job:Paint type')
    END

END;
GO

