-- Create a stored procedure to insert a new department
-- usp_CreateNewDepartment 1, 'Datatatatatatatta'
ALTER PROCEDURE usp_CreateNewDepartment
(
    @DepartmentNumber INT,
    @DepartmentData VARCHAR(255)
)

AS
BEGIN
    -- Check if the department number already exists
    IF NOT EXISTS (SELECT 1 FROM Department WHERE DepartmentNumber = @DepartmentNumber)
    BEGIN
        -- Insert the new department
        INSERT INTO Department (
            DepartmentNumber, 
            DepartmentData)
        VALUES (
            @DepartmentNumber, 
            @DepartmentData);

    END
END;
