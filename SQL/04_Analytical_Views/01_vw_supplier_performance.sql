/* ============================================================
   Apex Manufacturing Analytics
   Analytical View: Supplier Performance
   ============================================================ */

USE ApexManufacturing;
GO

CREATE OR ALTER VIEW analytics.vw_supplier_performance
AS
SELECT
    s.Supplier_ID,
    s.Supplier_Name,
    s.Lead_Time_Days,
    s.Quality_Rating,

    COUNT(po.PO_ID) AS Total_Orders,

    SUM(po.Ordered_Quantity) AS Total_Ordered,

    SUM(po.Received_Quantity) AS Total_Received,

    CAST(
        100.0 * SUM(po.Received_Quantity)
        / NULLIF(SUM(po.Ordered_Quantity), 0)
        AS DECIMAL(10,2)
    ) AS Fulfillment_Rate_Percent,

    SUM(
        CASE
            WHEN po.Actual_Delivery_Date > po.Expected_Delivery_Date
            THEN 1
            ELSE 0
        END
    ) AS Late_Orders,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN po.Actual_Delivery_Date > po.Expected_Delivery_Date
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(po.PO_ID), 0)
        AS DECIMAL(10,2)
    ) AS Late_Delivery_Rate_Percent,

    CAST(
        SUM(po.Ordered_Quantity * po.Unit_Cost)
        AS DECIMAL(18,2)
    ) AS Total_Purchase_Value

FROM warehouse.dim_supplier s

LEFT JOIN warehouse.fact_purchase_orders po
    ON s.Supplier_Key = po.Supplier_Key

GROUP BY
    s.Supplier_ID,
    s.Supplier_Name,
    s.Lead_Time_Days,
    s.Quality_Rating;
GO
