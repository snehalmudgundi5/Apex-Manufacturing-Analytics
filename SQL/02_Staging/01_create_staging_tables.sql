/* ============================================================
   Apex Manufacturing Analytics
   02 - Staging Tables
   ============================================================ */

USE ApexManufacturing;
GO

/* ------------------------------------------------------------
   Machine Operations Staging
   ------------------------------------------------------------ */

IF OBJECT_ID('staging.machine_operations', 'U') IS NOT NULL
    DROP TABLE staging.machine_operations;
GO

CREATE TABLE staging.machine_operations
(
    Product_ID              VARCHAR(20),
    Type                    VARCHAR(10),
    Air_temperature_K       DECIMAL(10,2),
    Process_temperature_K   DECIMAL(10,2),
    Rotational_speed_rpm    INT,
    Torque_Nm               DECIMAL(10,2),
    Tool_wear_min           INT,
    Machine_failure         BIT,
    TWF                     BIT,
    HDF                     BIT,
    PWF                     BIT,
    OSF                     BIT,
    RNF                     BIT
);
GO


/* ------------------------------------------------------------
   Supplier Staging
   ------------------------------------------------------------ */

IF OBJECT_ID('staging.suppliers', 'U') IS NOT NULL
    DROP TABLE staging.suppliers;
GO

CREATE TABLE staging.suppliers
(
    Supplier_ID         VARCHAR(20),
    Supplier_Name       VARCHAR(100),
    Lead_Time_Days      INT,
    Quality_Rating      DECIMAL(5,2)
);
GO


/* ------------------------------------------------------------
   Purchase Orders Staging
   ------------------------------------------------------------ */

IF OBJECT_ID('staging.purchase_orders', 'U') IS NOT NULL
    DROP TABLE staging.purchase_orders;
GO

CREATE TABLE staging.purchase_orders
(
    PO_ID                   VARCHAR(30),
    Supplier_ID             VARCHAR(20),
    Ordered_Quantity        INT,
    Received_Quantity       INT,
    Unit_Cost               DECIMAL(18,2),
    Expected_Delivery_Date  DATE,
    Actual_Delivery_Date    DATE
);
GO


/* ------------------------------------------------------------
   Inventory Staging
   ------------------------------------------------------------ */

IF OBJECT_ID('staging.inventory', 'U') IS NOT NULL
    DROP TABLE staging.inventory;
GO

CREATE TABLE staging.inventory
(
    Product_ID       VARCHAR(20),
    Warehouse_ID     VARCHAR(20),
    Closing_Stock    INT,
    Reorder_Level    INT,
    Inventory_Date   DATE
);
GO
