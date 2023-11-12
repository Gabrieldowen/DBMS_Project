-- Create a stored procedure to insert a new customer
--  NewCustomer 'Gabe', 'home', 11
ALTER PROCEDURE NewCustomer
    @CustomerName VARCHAR(255),
    @Address VARCHAR(255),
    @Category INT
AS
BEGIN
    -- Check if the customer already exists
    IF @Category >= 1 AND @Category <= 10
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerName = @CustomerName)
        BEGIN
            -- Insert the new customer
            INSERT INTO Customer (CustomerName, [Address], Category)
            VALUES (@CustomerName, @Address, @Category);
        END
    END
END;



