/* ============================================================
   Apex Manufacturing Analytics
   Validation & Testing Queries
   ============================================================ */

USE ApexManufacturing;
GO


/* ============================================================
   1. Total Operations
   Expected: 10,000
   ============================================================ */

SELECT
    COUNT(*) AS Total_Operations
FROM warehouse.fact_machine_operations;
GO


/* ============================================================
   2. Total Failures
   Expected: 339
   ============================================================ */

SELECT
    SUM(
        CASE
            WHEN Machine_Failure = 1
            THEN 1
            ELSE 0
        END
    ) AS Total_Failures
FROM warehouse.fact_machine_operations;
GO


/* ============================================================
   3. Failure Rate
   Expected: 3.39%
   ============================================================ */

SELECT
    CAST(
        100.0 *
        SUM(
            CASE
                WHEN Machine_Failure = 1
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent
FROM warehouse.fact_machine_operations;
GO


/* ============================================================
   4. Heat Dissipation Failures
   Expected: 115
   ============================================================ */

SELECT
    SUM(
        CASE
            WHEN HDF = 1
            THEN 1
            ELSE 0
        END
    ) AS Heat_Dissipation_Failures
FROM warehouse.fact_machine_operations;
GO


/* ============================================================
   5. Supplier Fulfillment Rate
   ============================================================ */

SELECT
    AVG(Fulfillment_Rate_Percent) AS Avg_Fulfillment_Rate
FROM analytics.vw_supplier_performance;
GO


/* ============================================================
   6. Supplier Late Delivery Rate
   ============================================================ */

SELECT
    AVG(Late_Delivery_Rate_Percent) AS Avg_Late_Delivery_Rate
FROM analytics.vw_supplier_performance;
GO


/* ============================================================
   7. Total Purchase Value
   ============================================================ */

SELECT
    SUM(Total_Purchase_Value) AS Total_Purchase_Value
FROM analytics.vw_supplier_performance;
GO


/* ============================================================
   8. Inventory Risk
   ============================================================ */

SELECT
    Warehouse_ID,

    SUM(Reorder_Risk_Days) AS Total_Reorder_Risk_Days,

    CAST(
        AVG(Reorder_Risk_Percent)
        AS DECIMAL(10,2)
    ) AS Avg_Reorder_Risk_Percent

FROM analytics.vw_inventory_risk

GROUP BY
    Warehouse_ID

ORDER BY
    Avg_Reorder_Risk_Percent DESC;
GO


/* ============================================================
   9. Machine Failure by RPM
   ============================================================ */

SELECT
    CASE
        WHEN Rotational_speed_rpm < 1400
            THEN 'Low RPM'
        WHEN Rotational_speed_rpm <= 1600
            THEN 'Medium RPM'
        ELSE 'High RPM'
    END AS RPM_Category,

    COUNT(*) AS Total_Operations,

    SUM(
        CASE
            WHEN Machine_Failure = 1
            THEN 1
            ELSE 0
        END
    ) AS Failures,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN Machine_Failure = 1
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent

FROM warehouse.fact_machine_operations

GROUP BY
    CASE
        WHEN Rotational_speed_rpm < 1400
            THEN 'Low RPM'
        WHEN Rotational_speed_rpm <= 1600
            THEN 'Medium RPM'
        ELSE 'High RPM'
    END

ORDER BY
    Failure_Rate_Percent DESC;
GO


/* ============================================================
   10. Machine Failure by Tool Wear
   ============================================================ */

SELECT
    CASE
        WHEN Tool_wear_min < 100
            THEN 'Low Wear'
        WHEN Tool_wear_min <= 200
            THEN 'Medium Wear'
        ELSE 'High Wear'
    END AS Tool_Wear_Category,

    COUNT(*) AS Total_Operations,

    SUM(
        CASE
            WHEN Machine_Failure = 1
            THEN 1
            ELSE 0
        END
    ) AS Failures,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN Machine_Failure = 1
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Failure_Rate_Percent

FROM warehouse.fact_machine_operations

GROUP BY
    CASE
        WHEN Tool_wear_min < 100
            THEN 'Low Wear'
        WHEN Tool_wear_min <= 200
            THEN 'Medium Wear'
        ELSE 'High Wear'
    END

ORDER BY
    Failure_Rate_Percent DESC;
GO
