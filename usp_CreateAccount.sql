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
EXEC [dbo].[usp_CreateJob] 1, 2, 3, 1 , '2023-11-12', 0.69

-- creates paint job
EXEC [dbo].[usp_CreateJob] 2, 2, 3, 2, '2023-11-12', 0.69, 'BLUE', 100

-- creates cut job
EXEC [dbo].[usp_CreateJob] 3, 2, 3, 3, '2023-11-12', 0.69, null, null, 'CUTTER2000', 12, 'Titanium'
*/
-- 
-- 
ALTER PROCEDURE [dbo].[usp_CreateJob]
(
    @JobID              INT,
    @AssemblyID         INT,
    @ProcessID          INT,
    @JobTypeID          INT,
    @JobDateStart       DATE,
    @LaborTime          FLOAT,
    @Color              VARCHAR(255) = NULL,
    @Volume             FLOAT = NULL,
    @MachineType        VARCHAR(255)= NULL, 
    @MachineTime        FLOAT = NULL, 
    @Material           VARCHAR(255) = NULL
)

AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Job WHERE JobID = @JobID)
    BEGIN
        IF EXISTS (SELECT 1 FROM Process WHERE ProcessID  = @ProcessID )
        BEGIN
            IF EXISTS (SELECT 1 FROM [Assembly] WHERE AssemblyID = @AssemblyID )
            BEGIN
                    INSERT INTO Job(JobID, AssemblyID, ProcessID, JobDateStart, JobTypeID)
                    VALUES (@JobID, @AssemblyID, @ProcessID, @JobDateStart, @JobTypeID)
                    PRINT 'INSERTED JOB'
                    IF(@JobTypeID = 1)
                    BEGIN
                        PRINT 'Inserting job fit type'
                        INSERT INTO JobFit(JobID, LaborTime)
                        VALUES (@JobID, @LaborTime)
                    END
                    IF(@JobTypeID = 2)
                    BEGIN
                        PRINT 'Inserting job paint type'
                        INSERT INTO JobPaint(JobID, LaborTime, Color, Volume)
                        VALUES (@JobID, @LaborTime, @Color, @Volume)
                    END
                    IF(@JobTypeID = 3)
                    BEGIN
                        PRINT 'Inserting job cut type'
                        INSERT INTO JobCut(JobID, LaborTime, MachineType, MachineTime, Material)
                        VALUES (@JobID, @LaborTime, @MachineType, @MachineTime, @Material)
                    END
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
