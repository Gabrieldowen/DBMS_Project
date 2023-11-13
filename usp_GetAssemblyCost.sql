SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- usp_InsertCustomer 'Gabe', 'Norman', '1'
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- usp_CreateProcess 2, 1, 1, 2, 'Another type'
-- usp_CreateAssembly 1,  '2023-11-12', 'Details', 'Gabe', 2

CREATE PROCEDURE [dbo].[usp_GetAssemblyCost] 2
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
