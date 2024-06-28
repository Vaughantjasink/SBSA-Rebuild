-- Query for Total SBIB
SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
    "Total SBIB" AS attribute,
     "SBIB" AS project,
    "Achieved Purpose" AS report_name,
    COUNT(CASE
        WHEN Fact_Result_Answer.Answer_Numeric_Value = 1 THEN 1
    END) / COUNT(Fact_Result.Result_ID) * 100 AS value,
    COUNT(Fact_Result.Result_ID) AS count,
    0 AS sort_order
FROM
    Fact_Result
INNER JOIN Fact_Result_Answer ON
    Fact_Result.Result_ID = Fact_Result_Answer.Result_ID
    AND Fact_Result_Answer.Question_Name = 'SBIB (FCR)'
INNER JOIN Dim_Question ON
    Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Dim_Survey ON
    Fact_Result.Survey_ID = Dim_Survey.Survey_ID
WHERE
    DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
    AND Dim_Survey.Survey_Name IN (
        'SBIB OAN - Credit Life Claims',
        'SBIB OAN - Funeral Claims',
        'SBIB OAN - Retentions - Assurance',
        'SBIB OAN - Retentions - Car & Home',
        'SBIB OAN - Retentions - HOC',
        'SBIB OAN - Retentions - Personal Accident',
        'SBIB OAN - Sales - Car',
        'SBIB OAN - Servicing - Accident & Health',
        'SBIB OAN - Servicing - Car',
        'SBIB OAN - Servicing - Credit Life',
        'SBIB OAN - Servicing - Funeral',
        'SBIB OAN - Servicing - Home'
    )
    AND Dim_Question.Question_Name = 'SBIB (FCR)'
GROUP BY 
    LAST_DAY(Fact_Result.DateTime_Created_Result),
    attribute

UNION

-- Query for specific SBIB attributes
SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
    CASE
        WHEN Dim_Survey.Survey_Name IN (
            'SBIB OAN - Credit Life Claims',
            'SBIB OAN - Funeral Claims'
        ) THEN 'Embedded Claims'
        WHEN Dim_Survey.Survey_Name IN (
            'SBIB OAN - Retentions - Car & Home',
            'SBIB OAN - Retentions - HOC',
            'SBIB OAN - Retentions - Assurance',
            'SBIB OAN - Retentions - Personal Accident'
        ) THEN 'Retentions'
        WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Sales - Car' THEN 'Sales'
        WHEN Dim_Survey.Survey_Name IN (
            'SBIB OAN - Servicing - Car',
            'SBIB OAN - Servicing - Credit Life',
            'SBIB OAN - Servicing - Funeral',
            'SBIB OAN - Servicing - Accident & Health',
            'SBIB OAN - Servicing - Home'
        ) THEN 'Servicing'
        ELSE Dim_Survey.Survey_Name
    END AS attribute,
    "SBIB" AS project,
    "Achieved Purpose - SBIB Queues" AS report_name,
    COUNT(CASE
        WHEN Fact_Result_Answer.Answer_Numeric_Value = 1 THEN 1
    END) / COUNT(Fact_Result.Result_ID) * 100 AS value,
    COUNT(Fact_Result.Result_ID) AS count,
    0 AS sort_order
FROM
    Fact_Result
INNER JOIN Fact_Result_Answer ON
    Fact_Result.Result_ID = Fact_Result_Answer.Result_ID
    AND Fact_Result_Answer.Question_Name = 'SBIB (FCR)'
INNER JOIN Dim_Question ON
    Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Dim_Survey ON
    Fact_Result.Survey_ID = Dim_Survey.Survey_ID
WHERE
    DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
    AND Dim_Survey.Survey_Name IN (
        'SBIB OAN - Credit Life Claims',
        'SBIB OAN - Funeral Claims',
        'SBIB OAN - Retentions - Assurance',
        'SBIB OAN - Retentions - Car & Home',
        'SBIB OAN - Retentions - HOC',
        'SBIB OAN - Retentions - Personal Accident',
        'SBIB OAN - Sales - Car',
        'SBIB OAN - Servicing - Accident & Health',
        'SBIB OAN - Servicing - Car',
        'SBIB OAN - Servicing - Credit Life',
        'SBIB OAN - Servicing - Funeral',
        'SBIB OAN - Servicing - Home'
    )
    AND Dim_Question.Question_Name = 'SBIB (FCR)'
GROUP BY 
    LAST_DAY(Fact_Result.DateTime_Created_Result),
    attribute;

   
   
