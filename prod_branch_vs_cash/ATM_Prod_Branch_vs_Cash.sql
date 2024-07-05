



-- BR Section

SELECT
    T.date AS date, 
    T.attribute AS attribute,
    'ATM' AS project,
    'Experience Rating: Provincial - branch vs CASH CENTRE' AS report_name,
    T.total_atm_1 AS total_atm,
    T.branch_1 AS branch,
    T.cash_centre_1 AS cash_centre,
    T.total_atm AS atm_count,
    T.branch AS branch_count,
    T.cash_centre AS cash_centre_count,
    T.sort_order

FROM (
    SELECT
        T0.C1 AS date,
        T0.C4 AS attribute,
        T0.C5 AS total_atm,
        T2.C13 AS branch,
        T1.C9 AS cash_centre,
        T0.C3 AS sort_order,
        T0.C20 AS total_atm_1,
        T1.C21 AS cash_centre_1,
        T2.C22 AS branch_1
    FROM (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C1,
            'Total ATM' AS C4,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C5,
            AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) AS C20,
            1 AS C3
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE `Fact_Result`.`Survey_Name` = 'ATM'
        AND (
            DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'ATM Experience (1 - 10) (ATM)'
        )
    GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T0
    LEFT OUTER JOIN (
        SELECT DISTINCT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C6,
          'Total ATM' AS C7,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C9,
            AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) AS C21
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Cash Centre'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'ATM Experience (1 - 10) (ATM)'
        )
        GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
          
    ) T1
    ON T0.C1 = T1.C6 AND T0.C4 = T1.C7
    LEFT OUTER JOIN (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C10,
            'Total ATM' AS C11,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C13,
            AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) AS C22
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
             `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Branch'
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'ATM Experience (1 - 10) (ATM)'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        )
        GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T2
    ON T0.C1 = T2.C10 AND T0.C4 = T2.C11
) T

UNION

SELECT
    T.date AS date, 
    T.attribute AS attribute,
    'ATM' AS project,
    'Experience Rating: Provincial - branch vs CASH CENTRE' AS report_name,
    T.total_atm_1 AS total_atm,
    T.branch_1 AS branch,
    T.cash_centre_1 AS cash_centre,
    T.total_atm AS atm_count,
    T.branch AS branch_count,
    T.cash_centre AS cash_centre_count,
    T.sort_order

FROM (
    SELECT
        T0.C1 AS date,
        T0.C4 AS attribute,
        T0.C5 AS total_atm,
        T2.C13 AS branch,
        T1.C9 AS cash_centre,
        T0.C3 AS sort_order,
        T0.C20 AS total_atm_1,
        T1.C21 AS cash_centre_1,
        T2.C22 AS branch_1
    FROM (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C1,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C4,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C5,
            AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) AS C20,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 2
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 3
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 4
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 5
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 6
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 7
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 8
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 9
            END AS C3
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE `Fact_Result`.`Survey_Name` = 'ATM'
        AND (
            DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'ATM Experience (1 - 10) (ATM)'
            AND `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
        )
        GROUP BY
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 2
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 3
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 4
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 5
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 6
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 7
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 8
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 9
            END,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END,
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T0
    LEFT OUTER JOIN (
        SELECT DISTINCT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C6,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C7,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C9,
            AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`)  AS C21
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Cash Centre'
            AND `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'ATM Experience (1 - 10) (ATM)'
        )
        GROUP BY
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`),
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END
    ) T1
    ON T0.C1 = T1.C6 AND T0.C4 = T1.C7
    LEFT OUTER JOIN (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C10,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C11,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C13,
            AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`)  AS C22
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
            AND `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Branch'
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'ATM Experience (1 - 10) (ATM)'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        )
        GROUP BY
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END,
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T2
    ON T0.C1 = T2.C10 AND T0.C4 = T2.C11
) T

UNION 

SELECT
    T.date AS date, 
    T.attribute AS attribute,
    'ATM' AS project,
    'Achieved Purpose: Provincial - Branch vs Cash centre' AS report_name,
    T.total_atm_1 AS total_atm,
    T.branch_1 AS branch,
    T.cash_centre_1 AS cash_centre,
    T.total_atm AS atm_count,
    T.branch AS branch_count,
    T.cash_centre AS cash_centre_count,
    T.sort_order

FROM (
    SELECT
        T0.C1 AS date,
        T0.C4 AS attribute,
        T0.C5 AS total_atm,
        T2.C13 AS branch,
        T1.C9 AS cash_centre,
        T0.C3 AS sort_order,
        T0.C20 AS total_atm_1,
        T1.C21 AS cash_centre_1,
        T2.C22 AS branch_1
    FROM (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C1,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C4,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C5,
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` = 1 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Result_ID`) * 100 AS C20,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 2
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 3
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 4
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 5
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 6
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 7
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 8
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 9
            END AS C3
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE `Fact_Result`.`Survey_Name` = 'ATM'
        AND (
            DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'Achieved Purpose (ATM)'
            AND `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
        )
        GROUP BY
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 2
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 3
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 4
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 5
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 6
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 7
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 8
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 9
            END,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END,
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T0
    LEFT OUTER JOIN (
        SELECT DISTINCT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C6,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C7,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C9,
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` = 1 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Result_ID`) * 100 AS C21
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Cash Centre'
            AND `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'Achieved Purpose (ATM)'
        )
        GROUP BY
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`),
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END
    ) T1
    ON T0.C1 = T1.C6 AND T0.C4 = T1.C7
    LEFT OUTER JOIN (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C10,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C11,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C13,
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` = 1 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Result_ID`) * 100 AS C22
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
            AND `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Branch'
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` IN ('Achieved Purpose (ATM)')
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        )
        GROUP BY
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END,
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T2
    ON T0.C1 = T2.C10 AND T0.C4 = T2.C11
) T

union

SELECT
    T.date AS date, 
    T.attribute AS attribute,
    'ATM' AS project,
    'Achieved Purpose: Provincial - Branch vs Cash centre' AS report_name,
    T.total_atm_1 AS total_atm,
    T.branch_1 AS branch,
    T.cash_centre_1 AS cash_centre,
    T.total_atm AS atm_count,
    T.branch AS branch_count,
    T.cash_centre AS cash_centre_count,
    T.sort_order

FROM (
    SELECT
        T0.C1 AS date,
        T0.C4 AS attribute,
        T0.C5 AS total_atm,
        T2.C13 AS branch,
        T1.C9 AS cash_centre,
        T0.C3 AS sort_order,
        T0.C20 AS total_atm_1,
        T1.C21 AS cash_centre_1,
        T2.C22 AS branch_1
    FROM (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C1,
            'Total ATM' AS C4,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C5,
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` = 1 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Result_ID`) * 100 AS C20,
            1 AS C3
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE `Fact_Result`.`Survey_Name` = 'ATM'
        AND (
            DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'Achieved Purpose (ATM)'
        )
    GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T0
    LEFT OUTER JOIN (
        SELECT DISTINCT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C6,
          'Total ATM' AS C7,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C9,
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` = 1 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Result_ID`) * 100 AS C21
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Cash Centre'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'Achieved Purpose (ATM)'
        )
        GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
          
    ) T1
    ON T0.C1 = T1.C6 AND T0.C4 = T1.C7
    LEFT OUTER JOIN (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C10,
            'Total ATM' AS C11,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C13,
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` = 1 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Result_ID`) * 100 AS C22
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
             `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Branch'
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` IN ('Achieved Purpose (ATM)')
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        )
        GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T2
    ON T0.C1 = T2.C10 AND T0.C4 = T2.C11
) T

union 

SELECT
    T.date AS date, 
    T.attribute AS attribute,
    'ATM' AS project,
    'Standard Bank NPS: Provincial - Branch vs Cash centre' AS report_name,
    T.total_atm_1 AS total_atm,
    T.branch_1 AS branch,
    T.cash_centre_1 AS cash_centre,
    T.total_atm AS atm_count,
    T.branch AS branch_count,
    T.cash_centre AS cash_centre_count,
    T.sort_order

FROM (
    SELECT
        T0.C1 AS date,
        T0.C4 AS attribute,
        T0.C5 AS total_atm,
        T2.C13 AS branch,
        T1.C9 AS cash_centre,
        T0.C3 AS sort_order,
        T0.C20 AS total_atm_1,
        T1.C21 AS cash_centre_1,
        T2.C22 AS branch_1
    FROM (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C1,
            'Total ATM' AS C4,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C5,
        (
            (
                COUNT(CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END) / 
                COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`)
            ) -
            (
                COUNT(CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END) /
                COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`)
            )
        ) * 100  AS C20,
            1 AS C3
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) 
        #INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        #INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE `Fact_Result`.`Survey_Name` = 'ATM'
        AND (
            DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'NPS Rating (0 - 10) (ATM)'
        )
    GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T0
    LEFT OUTER JOIN (
        SELECT DISTINCT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C6,
          'Total ATM' AS C7,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C9,
            (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS C21
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Cash Centre'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'NPS Rating (0 - 10) (ATM)'
        )
        GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
          
    ) T1
    ON T0.C1 = T1.C6 AND T0.C4 = T1.C7
    LEFT OUTER JOIN (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C10,
            'Total ATM' AS C11,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C13,
            (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS C22
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
             `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Branch'
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'NPS Rating (0 - 10) (ATM)'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        )
        GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T2
    ON T0.C1 = T2.C10 AND T0.C4 = T2.C11
) T

UNION

SELECT
    T.date AS date, 
    T.attribute AS attribute,
    'ATM' AS project,
    'Standard Bank NPS: Provincial - Branch vs Cash centre' AS report_name,
    T.total_atm_1 AS total_atm,
    T.branch_1 AS branch,
    T.cash_centre_1 AS cash_centre,
    T.total_atm AS atm_count,
    T.branch AS branch_count,
    T.cash_centre AS cash_centre_count,
    T.sort_order

FROM (
    SELECT
        T0.C1 AS date,
        T0.C4 AS attribute,
        T0.C5 AS total_atm,
        T2.C13 AS branch,
        T1.C9 AS cash_centre,
        T0.C3 AS sort_order,
        T0.C20 AS total_atm_1,
        T1.C21 AS cash_centre_1,
        T2.C22 AS branch_1
    FROM (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C1,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C4,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C5,
            (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS C20,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 2
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 3
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 4
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 5
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 6
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 7
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 8
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 9
            END AS C3
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE `Fact_Result`.`Survey_Name` = 'ATM'
        AND (
            DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'NPS Rating (0 - 10) (ATM)'
            AND `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
        )
        GROUP BY
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 2
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 3
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 4
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 5
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 6
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 7
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 8
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 9
            END,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END,
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T0
    LEFT OUTER JOIN (
        SELECT DISTINCT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C6,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C7,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C9,
            (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS C21
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Cash Centre'
            AND `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'NPS Rating (0 - 10) (ATM)'
        )
        GROUP BY
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`),
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END
    ) T1
    ON T0.C1 = T1.C6 AND T0.C4 = T1.C7
    LEFT OUTER JOIN (
        SELECT
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS C10,
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END AS C11,
            COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS C13,
            (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS C22
        FROM `Fact_Result`
        INNER JOIN `Dim_Survey` ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`) AND (`Dim_Survey`.`Survey_Name` = 'ATM')
        INNER JOIN `MT_RE_Group_RE_Agent` ON (`Fact_Result`.`RE_Agent_ID` = `MT_RE_Group_RE_Agent`.`RE_Agent_ID`)
        INNER JOIN `Fact_Interaction_Data` AS `FACT_INTERACTION_DATA` ON (`Fact_Result`.`result_id_ORIG` = `FACT_INTERACTION_DATA`.`result_id_ORIG`) AND (`FACT_INTERACTION_DATA`.`IF_Servicing_Entity` IN ('Branch', 'Cash Centre'))
        INNER JOIN `Fact_Result_Answer` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
        INNER JOIN `Dim_RE_Group` ON (`MT_RE_Group_RE_Agent`.`RE_Group_ID` = `Dim_RE_Group`.`RE_Group_ID`)
        INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
        WHERE (`Fact_Result`.`Survey_Name` = 'ATM')
        AND (
            `Dim_RE_Group`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
            AND `FACT_INTERACTION_DATA`.`IF_Servicing_Entity` = 'Branch'
            AND `Dim_Survey`.`Survey_Name` = 'ATM'
            AND `Dim_Question`.`Question_Name` = 'NPS Rating (0 - 10) (ATM)'
            AND DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        )
        GROUP BY
            CASE
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'North West Province' THEN 'North West'
                WHEN `Dim_RE_Group`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'
            END,
            LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
    ) T2
    ON T0.C1 = T2.C10 AND T0.C4 = T2.C11
) T






