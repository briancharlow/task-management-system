CREATE PROCEDURE CreateUser
    @Username NVARCHAR(50),
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CurrentTime DATETIME2 = GETDATE();
    
    INSERT INTO Users (Username, Email, PasswordHash, CreatedAt, LastLogin)
    VALUES (@Username, @Email, @PasswordHash, @CurrentTime, @CurrentTime);
    
    SELECT SCOPE_IDENTITY() AS NewUserID;
END