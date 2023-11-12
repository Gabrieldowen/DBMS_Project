-- Create a stored procedure to enter a new process
-- usp_CreateProcess 
CREATE PROCEDURE usp_CreateProcess
    @ProcessID INT,
    @DepartmentNumber INT,
    @ProcessType VARCHAR(255),
    @ProcessData VARCHAR(255)
AS
BEGIN
    -- Check if the process ID already exists
    IF NOT EXISTS (SELECT 1 FROM Process WHERE ProcessID = @ProcessID)
    BEGIN
        -- Check if the department ID exists
        IF EXISTS (SELECT 1 FROM Department WHERE DepartmentNumber = @DepartmentNumber)
        BEGIN
            -- Insert the new process
            INSERT INTO Process (
                ProcessID,
                ProcessType,
                ProcessData,
                DepartmentNumber
                )
            VALUES (
                @ProcessID,
                @ProcessType, 
                @ProcessData,
                @DepartmentNumber
                );
        END
    END
END;
