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
EXEC [dbo].[usp_CreateAccount] 1, 2, '2023-11-12', 1, 1

-- Associate with a department
EXEC [dbo].[usp_CreateAccount] 1, 3, '2023-11-12', 1, 2

-- Associate with a process
EXEC [dbo].[usp_CreateAccount] 1, 3, '2023-11-12', 1, 3
*/
-- 
-- 
ALTER PROCEDURE [dbo].[usp_CreateAccount]
(
    @AccountNumber      INT,
    @AssociationID      INT,
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
        IF( @AccountTypeID = 1)    -- Assembly Account type
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Account WHERE AccountNumber = @AccountNumber)
            BEGIN
                INSERT INTO Account(AccountNumber, DateCreated, Category, AccountTypeID)
                VALUES (@AccountNumber, @DateCreated, @Category, @AccountTypeID)

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
                INSERT INTO Account(AccountNumber, DateCreated, Category, AccountTypeID)
                VALUES (@AccountNumber, @DateCreated, @Category, @AccountTypeID)

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
                INSERT INTO Account(AccountNumber, DateCreated, Category, AccountTypeID)
                VALUES (@AccountNumber, @DateCreated, @Category, @AccountTypeID)

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
