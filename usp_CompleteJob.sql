SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*

-- creates fit job
EXEC [dbo].[usp_CompleteJob] 1, 1 , '2023-11-12', 0.69

-- creates paint job
EXEC [dbo].[usp_CompleteJob] 2, 2, '2023-11-12', 0.69, 'BLUE', 100

-- creates cut job
EXEC [dbo].[usp_CompleteJob] 3, 3, '2023-11-12', 0.69, null, null, 'CUTTER2000', 12, 'Titanium'
*/
-- 
-- 
ALTER PROCEDURE [dbo].[usp_CompleteJob]
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
                JobTypeID = @JobTypeID
            WHERE JobID = @JobID
            PRINT 'UPDATE JOB'
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
        PRINT('No Job Exists for that number')
    
END;
GO
