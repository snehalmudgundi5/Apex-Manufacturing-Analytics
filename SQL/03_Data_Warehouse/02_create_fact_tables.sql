/* ============================================================
   Apex Manufacturing Analytics
   03 - Fact Tables
   ============================================================ */

USE ApexManufacturing;
GO


/* ============================================================
   Machine Operations Fact
   ============================================================ */

IF OBJECT_ID('warehouse.fact_machine_operations', 'U') IS NOT NULL
    DROP TABLE warehouse.fact_machine_operations;
GO

CREATE TABLE warehouse.fact_machine_operations
(
    Machine_Operation_Key    INT IDENTITY(1,1) PRIMARY KEY,

    Product_ID               VARCHAR(20),
    Product_Type             VARCHAR(10),

    Air_temperature_K        DECIMAL(10,2),
    Process_temperature_K    DECIMAL(10,2),

    Rotational_speed_rpm     INT,
    Torque_Nm                DECIMAL(10,2),
    Tool_wear_min            INT,

    Machine_Failure          BIT,

    TWF                      BIT,
    HDF                      BIT,
    PWF                      BIT,
    OSF                      BIT,
    RNF                      BIT
);
GO


/* ============================================================
   Purchase Orders Fact
   ============================================================ */

IF OBJECT_ID('warehouse.fact_purchase_orders', 'U') IS NOT NULL
    DROP TABLE warehouse.fact_purchase_orders;
GO

CREATE TABLE warehouse.fact_purchase_orders
(
    Purchase_Order_Key       INT IDENTITY(1,1) PRIMARY KEY,

    PO_ID                    VARCHAR(30),
    Supplier_Key             INT,

    Ordered_Quantity         INT,
    Received_Quantity        INT,

    Unit_Cost                DECIMAL(18,2),

    Expected_Delivery_Date   DATE,
    Actual_Delivery_Date     DATE
);
GO


/* ============================================================
   Inventory Fact
   ============================================================ */

IF OBJECT_ID('warehouse.fact_inventory', 'U') IS NOT NULL
    DROP TABLE warehouse.fact_inventory;
GO

CREATE TABLE warehouse.fact_inventory
(
    Inventory_Key       INT IDENTITY(1,1) PRIMARY KEY,

    Product_ID          VARCHAR(20),
    Warehouse_ID        VARCHAR(20),

    Inventory_Date      DATE,

    Closing_Stock       INT,
    Reorder_Level       INT
);
GO
