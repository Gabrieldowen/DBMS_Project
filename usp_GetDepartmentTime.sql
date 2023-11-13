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
EXEC [dbo].[usp_CreateJob] 4, 2, 3, '2023-11-12'

EXEC [dbo].[usp_CompleteJob] 1, 1 , '2023-11-12', 0.69
EXEC [dbo].[usp_CompleteJob] 2, 2 , '2023-11-12', 10
EXEC [dbo].[usp_CompleteJob] 4, 3 , '2024-11-12', 200

EXEC [dbo].[usp_GetDepartmentTime] 1,  '2023-12-12'
*/
-- 
-- 
ALTER PROCEDURE [dbo].[usp_GetDepartmentTime]
(
    @DepartmentNumber   INT,
    @StartDate          DATE = NULL,
    @EndDate            DATE = NULL
)

AS
BEGIN
   SELECT SUM(j.LaborTime)
   FROM Department d
   INNER JOIN Process p
   ON d.DepartmentNumber = p.DepartmentNumber
   INNER JOIN Job j
   ON j.ProcessID = p.ProcessID
   WHERE (j.JobDateEnd >= @StartDate OR @StartDate IS NULL)
   AND (j.JobDateEnd  <= @EndDate OR @EndDate IS NULL)
    
END;
GO
