-- Create a stored procedure to insert a new process with type information
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- InsertProcessWithType 5, 1, 1, 5, 'THE FIT22', 'more att'
ALTER PROCEDURE InsertProcessWithType
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
