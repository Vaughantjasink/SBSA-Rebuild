-- Totals for the SBIB Queues

SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Servicing - Car' THEN "Car"
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Servicing - Credit Life' THEN "Credit Life"
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Servicing - Funeral' THEN "Funeral"
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Servicing - Accident & Health' THEN "Accident & Health"
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Servicing - Home' THEN "Home"
	END AS attribute,
    "SBIB" AS project,
    "Achieved Purpose - SBIB Queues - Servicing" AS report_name,
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
        'SBIB OAN - Servicing - Car',
        'SBIB OAN - Servicing - Credit Life',
        'SBIB OAN - Servicing - Funeral',
         'SBIB OAN - Servicing - Accident & Health',
        'SBIB OAN - Servicing - Home'
    )
    AND Dim_Question.Question_Name = 'SBIB (FCR)'
GROUP BY 
    LAST_DAY(Fact_Result.DateTime_Created_Result),
    attribute

UNION

-- Totals for the SBIB Queues

SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Retentions - Car & Home' THEN 'Car & Home'
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Retentions - HOC' THEN 'HOC'
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Retentions - Assurance' THEN 'Assurance'
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Retentions - Personal Accident' THEN 'Personal Accident'
	END AS attribute,
    "SBIB" AS project,
    "Achieved Purpose - SBIB Queues - Retentions" AS report_name,
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
        'SBIB OAN - Retentions - Assurance',
        'SBIB OAN - Retentions - Car & Home',
        'SBIB OAN - Retentions - HOC',
        'SBIB OAN - Retentions - Personal Accident'
    )
    AND Dim_Question.Question_Name = 'SBIB (FCR)'
GROUP BY 
    LAST_DAY(Fact_Result.DateTime_Created_Result),
    attribute

UNION

-- Total Embedded Claims 

SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Credit Life Claims' THEN 'Credit Life Claims'
	    WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Funeral Claims' THEN 'Funeral Claims'
	END AS attribute,
    "SBIB" AS project,
    "Achieved Purpose - SBIB Queues - Embedded Claims" AS report_name,
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
        'SBIB OAN - Funeral Claims'
    )
    AND Dim_Question.Question_Name = 'SBIB (FCR)'
GROUP BY 
    LAST_DAY(Fact_Result.DateTime_Created_Result),
    attribute

UNION

-- Sales   

SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
    CASE
        WHEN Dim_Survey.Survey_Name = 'SBIB OAN - Sales - Car' THEN 'Car'
    END AS attribute,
    "SBIB" AS project,
    "Achieved Purpose - SBIB Queues - Sales" AS report_name,
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
    AND Dim_Survey.Survey_Name = 'SBIB OAN - Sales - Car'
    AND Dim_Question.Question_Name = 'SBIB (FCR)'
GROUP BY 
    LAST_DAY(Fact_Result.DateTime_Created_Result),
    attribute;
    
