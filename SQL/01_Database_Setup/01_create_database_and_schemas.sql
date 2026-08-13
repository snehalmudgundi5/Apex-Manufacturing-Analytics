/* ============================================================
   Apex Manufacturing Analytics
   01 - Database Setup
   ============================================================ */

-- Create database if it does not already exist
IF DB_ID('ApexManufacturing') IS NULL
BEGIN
    CREATE DATABASE ApexManufacturing;
END;
GO

USE ApexManufacturing;
GO

-- Create schemas
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'staging'
)
BEGIN
    EXEC('CREATE SCHEMA staging');
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'warehouse'
)
BEGIN
    EXEC('CREATE SCHEMA warehouse');
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'analytics'
)
BEGIN
    EXEC('CREATE SCHEMA analytics');
END;
GO
