/* ============================================================
   Apex Manufacturing Analytics
   Analytical View: Inventory Risk
   ============================================================ */

USE ApexManufacturing;
GO

CREATE OR ALTER VIEW analytics.vw_inventory_risk
AS
SELECT
    Product_ID,
    Warehouse_ID,

    COUNT(*) AS Inventory_Days,

    CAST(
        AVG(Closing_Stock)
        AS DECIMAL(10,2)
    ) AS Avg_Closing_Stock,

    MIN(Closing_Stock) AS Minimum_Stock,

    SUM(
        CASE
            WHEN Closing_Stock < Reorder_Level
            THEN 1
            ELSE 0
        END
    ) AS Reorder_Risk_Days,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN Closing_Stock < Reorder_Level
                THEN 1
                ELSE 0
            END
        )
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Reorder_Risk_Percent

FROM warehouse.fact_inventory

GROUP BY
    Product_ID,
    Warehouse_ID;
GO
