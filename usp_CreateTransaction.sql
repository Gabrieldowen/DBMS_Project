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

EXEC [dbo].[usp_CreateTransaction] 1, 1, 300
*/
-- 
-- 
ALTER PROCEDURE [dbo].[usp_CreateTransaction]
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


   SELECT Top 1 @ProcessAccountNumber = p.AccountNumber
   FROM Process p
   INNER JOIN Job j
   ON p.ProcessID = j.ProcessID
   INNER JOIN Account a
   ON p.AccountNumber = a.AccountNumber

   SELECT Top 1 @DepartmentAccountNumber = d.AccountNumber
   FROM Process p
   INNER JOIN Job j
   ON p.ProcessID = j.ProcessID
   INNER JOIN Department d
   ON d.DepartmentNumber = d.DepartmentNumber
   
    SELECT DISTINCT @AssemblyAccountNumber = a.AccountNumber
    FROM Process p
    INNER JOIN Job j
        ON p.ProcessID = j.ProcessID
    INNER JOIN AssemblyXREF x
        ON x.ProcessID = p.ProcessID
    INNER JOIN [Assembly] a
        ON x.AssemblyID = a.AssemblyID
   
   

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
