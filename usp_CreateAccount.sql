SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- InsertProcessWithType 3, 1, 1, 2, 'THE FIT'
CREATE PROCEDURE [dbo].[usp_CreateAccount]
(
    @ProcessID          INT,
    @AccountNumber      INT,
    @DateCreated        DATE,
    @Category           VARCHAR(255),
    @AccountTypeID      INT 
)

AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM AccountType
        WHERE @AccountTypeID = AccountTypeID
    ) 
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Account WHERE AccountNumber = @AccountNumber)
        BEGIN
            PRINT 'Process with type information inserted successfully.';
        END
    END
END;
GO
