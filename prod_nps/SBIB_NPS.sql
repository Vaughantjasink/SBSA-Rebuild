SELECT
	LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
		WHEN 1 = 0 THEN CAST( Dim_Survey.Survey_Name AS char )
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home', 'SBIB OAN - Servicing - Accident & Health') THEN 'Servicing'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident') THEN 'Retentions'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Sales'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
		ELSE CAST( Dim_Survey.Survey_Name AS char )
	END AS attribute,
	'SBIB' as project,
	'Bankers Rating - SBIB Queues' as report_name,
	   (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS value,
	COUNT(Fact_Result.Result_ID) as count,
	1 as sort_order
FROM
	Fact_Result
INNER JOIN Dim_Survey ON
	(Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
INNER JOIN Fact_Result_Answer ON
	( Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)
INNER JOIN Dim_Question ON
	(Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
WHERE
	(
   DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
		AND Dim_Survey.Survey_Name IN ('SBIB OAN - Credit Life Claims', 'SBIB OAN - Funeral Claims', 'SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident', 'SBIB OAN - Sales - Car', 'SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home')
			AND Dim_Question.Question_Name = 'SBIB (NPS)'
)
GROUP BY
	CASE
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home', 'SBIB OAN - Servicing - Accident & Health') THEN 'Servicing'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident') THEN 'Retentions'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Sales'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
	END,
	LAST_DAY(Fact_Result.DateTime_Created_Result)
UNION

SELECT
	LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
		WHEN 1 = 0 THEN CAST( ('Total SBIB') AS char )
		WHEN ('Total SBIB') IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home', 'SBIB OAN - Servicing - Accident & Health') THEN 'Servicing'
		WHEN ('Total SBIB') IN ('SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident') THEN 'Retentions'
		WHEN ('Total SBIB') IN ('SBIB OAN - Sales - Car') THEN 'Sales'
		WHEN ('Total SBIB') IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
		ELSE CAST( ('Total SBIB') AS char )
	END AS attribute,
	'SBIB' as project,
	'Standard BANK INSURANCE BROKER (SBIB) NPS' as report_name,
		   (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS value,
	COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) as count,
	0 as sort_order
FROM
	Fact_Result
INNER JOIN Dim_Survey ON
	( Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
INNER JOIN Fact_Result_Answer ON
	(Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)
INNER JOIN Dim_Question ON
	(Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
WHERE
	(
   Dim_Survey.Survey_Name IN ('SBIB OAN - Credit Life Claims', 'SBIB OAN - Funeral Claims', 'SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident', 'SBIB OAN - Sales - Car', 'SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home')
		AND Dim_Question.Question_Name = 'SBIB (NPS)'
		AND DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
)
GROUP BY
	CASE
		WHEN 1 = 0 THEN CAST( ('Total SBIB') AS char )
		WHEN ('Total SBIB') IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home', 'SBIB OAN - Servicing - Accident & Health') THEN 'Servicing'
		WHEN ('Total SBIB') IN ('SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident') THEN 'Retentions'
		WHEN ('Total SBIB') IN ('SBIB OAN - Sales - Car') THEN 'Sales'
		WHEN ('Total SBIB') IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
		ELSE CAST( ('Total SBIB') AS char )
	END,
	DATE_ADD(DATE(Fact_Result.DateTime_Created_Result), INTERVAL 1 - DAYOFMONTH(Fact_Result.DateTime_Created_Result) DAY)
UNION
 
 SELECT
	LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
		WHEN 1 = 0 THEN CAST( Dim_Survey.Survey_Name AS char )
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance') THEN 'Assurance'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Car & Home') THEN 'Car & Home'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - HOC') THEN 'HOC'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Personal Accident') THEN 'Personal Accident'
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Accident & Health') THEN 'Accident & Health'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Credit Life') THEN 'Credit Life'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Funeral') THEN 'Funeral'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Home') THEN 'Home'
		ELSE CAST( Dim_Survey.Survey_Name AS char )
	END AS attribute,
	'SBIB' as project,
	'Bankers Rating - SBIB Queues - Servicing' as report_name,
		   (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS value,
	COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) as count,
	2 AS sort_order
FROM
	Fact_Result
INNER JOIN Dim_Survey ON
	(Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
INNER JOIN Fact_Result_Answer ON
	( Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)
INNER JOIN Dim_Question ON
	(Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
WHERE
	(
    DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
		AND Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home')
			AND Dim_Question.Question_Name = 'SBIB (NPS)'
)
GROUP BY
	CASE
		WHEN 1 = 0 THEN CAST( Dim_Survey.Survey_Name AS char )
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance') THEN 'Assurance'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Car & Home') THEN 'Car & Home'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - HOC') THEN 'HOC'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Personal Accident') THEN 'Personal Accident'
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Accident & Health') THEN 'Accident & Health'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Credit Life') THEN 'Credit Life'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Funeral') THEN 'Funeral'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Home') THEN 'Home'
		ELSE CAST( Dim_Survey.Survey_Name AS char )
	END,
	LAST_DAY(Fact_Result.DateTime_Created_Result),
	2
union
   
   SELECT
	LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims') THEN 'Funeral Claims'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Credit Life Claims') THEN 'Credit Life Claims'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance') THEN 'Assurance'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Car & Home') THEN 'Car & Home'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - HOC') THEN 'HOC'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Personal Accident') THEN 'Personal Accident'
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Accident & Health') THEN 'Accident & Health'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Credit Life') THEN 'Credit Life'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Funeral') THEN 'Funeral'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Home') THEN 'Home'
	END AS attribute,
	'SBIB' as project,
    
	CASE
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') 
      									THEN 'Bankers Rating - SBIB Queues - Sales'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Funeral Claims',
      									'SBIB OAN - Credit Life Claims')
      									THEN 'Bankers Rating - SBIB Queues - Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Retentions - Assurance',
      									'SBIB OAN - Retentions - Car & Home',
      									'SBIB OAN - Retentions - HOC',
      									'SBIB OAN - Retentions - Personal Accident') 
      									THEN 'Bankers Rating - SBIB Queues - Retentions'
		WHEN Dim_Survey.Survey_Name IN ( ' SBIB OAN - Servicing - Accident & Health', 
      									'SBIB OAN - Servicing - Accident & Health',
      									'SBIB OAN - Servicing - Car',
      									'SBIB OAN - Servicing - Credit Life',
      									'SBIB OAN - Servicing - Funeral',
      									'SBIB OAN - Servicing - Home') 
      									THEN 'Bankers Rating - SBIB Queues - Servicing'
	END as report_name,
	(COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
	COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END)))
	/ COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS value,
	COUNT(Fact_Result.Result_ID) as count,       
            
            
	2 AS sort_order
FROM
	Fact_Result
INNER JOIN Dim_Survey ON
	(Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
INNER JOIN Fact_Result_Answer ON
	( Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)
INNER JOIN Dim_Question ON
	(Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
WHERE
	(
    DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
		AND Dim_Survey.Survey_Name IN ('SBIB OAN - Credit Life Claims', 'SBIB OAN - Funeral Claims', 'SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident', 'SBIB OAN - Sales - Car', 'SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home')
			AND Dim_Question.Question_Name = 'SBIB (NPS)'
)
GROUP BY
	CASE
		WHEN 1 = 0 THEN CAST( Dim_Survey.Survey_Name AS char )
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance') THEN 'Assurance'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Car & Home') THEN 'Car & Home'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - HOC') THEN 'HOC'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Personal Accident') THEN 'Personal Accident'
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Accident & Health') THEN 'Accident & Health'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Car') THEN 'Car'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Credit Life') THEN 'Credit Life'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Funeral') THEN 'Funeral'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Servicing - Home') THEN 'Home'
		ELSE CAST( Dim_Survey.Survey_Name AS char )
	END,
	CASE
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') 
	      									THEN 'Bankers Rating - SBIB Queues - Sales'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Funeral Claims',
	      									'SBIB OAN - Credit Life Claims')
	      									THEN 'Bankers Rating - SBIB Queues - Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Retentions - Assurance',
	      									'SBIB OAN - Retentions - Car & Home',
	      									'SBIB OAN - Retentions - HOC',
	      									'SBIB OAN - Retentions - Personal Accident') 
	      									THEN 'Bankers Rating - SBIB Queues - Retentions'
		WHEN Dim_Survey.Survey_Name IN ( ' SBIB OAN - Servicing - Accident & Health', 
	      									'SBIB OAN - Servicing - Accident & Health',
	      									'SBIB OAN - Servicing - Car',
	      									'SBIB OAN - Servicing - Credit Life',
	      									'SBIB OAN - Servicing - Funeral',
	      									'SBIB OAN - Servicing - Home') 
	      									THEN 'Bankers Rating - SBIB Queues - Servicing'
	END,
	LAST_DAY(Fact_Result.DateTime_Created_Result),
	2
union
 
 
 SELECT
	LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
	CASE
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home', 'SBIB OAN - Servicing - Accident & Health') THEN 'Total Servicing'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident') THEN 'Total Retentions'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Total Sales'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Total Embedded Claims'
	END AS attribute,
	'SBIB' as project,
	CASE
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') 
      									THEN 'Bankers Rating - SBIB Queues - Sales'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Funeral Claims',
      									'SBIB OAN - Credit Life Claims')
      									THEN 'Bankers Rating - SBIB Queues - Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Retentions - Assurance',
      									'SBIB OAN - Retentions - Car & Home',
      									'SBIB OAN - Retentions - HOC',
      									'SBIB OAN - Retentions - Personal Accident') 
      									THEN 'Bankers Rating - SBIB Queues - Retentions'
		WHEN Dim_Survey.Survey_Name IN ( ' SBIB OAN - Servicing - Accident & Health', 
      									'SBIB OAN - Servicing - Accident & Health',
      									'SBIB OAN - Servicing - Car',
      									'SBIB OAN - Servicing - Credit Life',
      									'SBIB OAN - Servicing - Funeral',
      									'SBIB OAN - Servicing - Home') 
      									THEN 'Bankers Rating - SBIB Queues - Servicing'
	END as report_name,
		   (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS value,
	COUNT(Fact_Result.Result_ID) as count,
	1 as sort_order
FROM
	Fact_Result
INNER JOIN Dim_Survey ON
	(Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
INNER JOIN Fact_Result_Answer ON
	( Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)
INNER JOIN Dim_Question ON
	(Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
WHERE
	(
   DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
		AND Dim_Survey.Survey_Name IN ('SBIB OAN - Credit Life Claims', 'SBIB OAN - Funeral Claims', 'SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident', 'SBIB OAN - Sales - Car', 'SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home')
			AND Dim_Question.Question_Name = 'SBIB (NPS)'
)
GROUP BY
	CASE
		WHEN Dim_Survey.Survey_Name IN (' SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home', 'SBIB OAN - Servicing - Accident & Health') THEN 'Servicing'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident') THEN 'Retentions'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') THEN 'Sales'
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Funeral Claims', 'SBIB OAN - Credit Life Claims') THEN 'Embedded Claims'
	END,
	CASE
		WHEN Dim_Survey.Survey_Name IN ('SBIB OAN - Sales - Car') 
	      									THEN 'Bankers Rating - SBIB Queues - Sales'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Funeral Claims',
	      									'SBIB OAN - Credit Life Claims')
	      									THEN 'Bankers Rating - SBIB Queues - Embedded Claims'
		WHEN Dim_Survey.Survey_Name IN ( 'SBIB OAN - Retentions - Assurance',
	      									'SBIB OAN - Retentions - Car & Home',
	      									'SBIB OAN - Retentions - HOC',
	      									'SBIB OAN - Retentions - Personal Accident') 
	      									THEN 'Bankers Rating - SBIB Queues - Retentions'
		WHEN Dim_Survey.Survey_Name IN ( ' SBIB OAN - Servicing - Accident & Health', 
	      									'SBIB OAN - Servicing - Accident & Health',
	      									'SBIB OAN - Servicing - Car',
	      									'SBIB OAN - Servicing - Credit Life',
	      									'SBIB OAN - Servicing - Funeral',
	      									'SBIB OAN - Servicing - Home') 
	      									THEN 'Bankers Rating - SBIB Queues - Servicing'
	END,
	LAST_DAY(Fact_Result.DateTime_Created_Result)
