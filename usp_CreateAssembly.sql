-- usp_InsertCustomer 'Gabe', 'Norman', '1'
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
-- usp_CreateProcess 2, 1, 1, 2, 'Another type'
-- usp_CreateAssembly 1,  '2023-11-12', 'Details', 'Gabe', 2
ALTER PROCEDURE usp_CreateAssembly
(
    @AssemblyID         INT,
    @DateOrdered        DATE,
    @AssemblyDetails    VARCHAR(255),
    @CustomerName       VARCHAR(255),
    @ProcessID          INT

)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customer WHERE CustomerName = @CustomerName)
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM [Assembly] WHERE [AssemblyID] = @AssemblyID)
        BEGIN
            INSERT INTO [Assembly] (AssemblyID, CustomerName, DateOrdered, AssemblyDetails)
            VALUES (@AssemblyID, @CustomerName, @DateOrdered, @AssemblyDetails)

            INSERT INTO [AssemblyXREF] (AssemblyID, ProcessID)
                VALUES(@AssemblyID, @ProcessID)
        END
        ELSE
        BEGIN
            INSERT INTO [AssemblyXREF] (AssemblyID, ProcessID)
                    VALUES(@AssemblyID, @ProcessID)
        END
    END


END;