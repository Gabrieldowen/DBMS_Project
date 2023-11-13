SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to insert a new process with type information
/*
EXEC usp_CreateNewDepartment 1, 'Datatatatatatatta'
EXEC usp_CreateProcess 3, 1, 1, 2, 'THE FIT'
EXEC [dbo].[usp_CreateAccount] 3, 1, '2023-11-12', 1, 3
*/
-- 
-- 
ALTER PROCEDURE [dbo].[usp_CreateAccount]
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
            INSERT INTO Account(AccountNumber, DateCreated, Category, AccountTypeID)
            VALUES (@AccountNumber, @DateCreated, @Category, @AccountTypeID)

            UPDATE Process
            SET AccountNumber = @AccountNumber
            WHERE ProcessID = @ProcessID
        END
    END
END;
GO
