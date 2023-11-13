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
ALTER PROCEDURE [dbo].[usp_CreateJob]
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
