-- Total SBIB

SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS month,
   'SBIB' as project,
   'Standard BANK INSURANCE BROKER (SBIB) NPS DISTRIBUTION' as report_name,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as detractor,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` BETWEEN 6.5 AND 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as passive,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as promotor,
   (COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) - COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END))) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as nps,
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) as count,
   1 AS sort_order
FROM `Fact_Result`
INNER JOIN `Dim_Survey`
ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`)
INNER JOIN `Fact_Result_Answer`ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
INNER JOIN `Dim_Question` ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
WHERE (
   	DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   	AND `Dim_Survey`.`Survey_Name` IN ('SBIB OAN - Credit Life Claims', 'SBIB OAN - Funeral Claims', 'SBIB OAN - Retentions - Assurance', 'SBIB OAN - Retentions - Car & Home', 'SBIB OAN - Retentions - HOC', 'SBIB OAN - Retentions - Personal Accident', 'SBIB OAN - Sales - Car', 'SBIB OAN - Servicing - Accident & Health', 'SBIB OAN - Servicing - Car', 'SBIB OAN - Servicing - Credit Life', 'SBIB OAN - Servicing - Funeral', 'SBIB OAN - Servicing - Home')
   	AND `Dim_Question`.`Question_Name` = 'SBIB (NPS)'
)
GROUP BY 
   1,
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)

-- Servicing   
   
   UNION

SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS month,
   'SBIB - Queues' as project,
   'NPSD - Servicing' as report_name,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as detractor,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` BETWEEN 6.5 AND 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as passive,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as promotor,
   (COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) - COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END))) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as nps,
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) as count,
   1 AS sort_order
FROM `Fact_Result`
INNER JOIN `Dim_Survey` 		ON (`Fact_Result`.`Survey_ID` 			= `Dim_Survey`.`Survey_ID`)
INNER JOIN `Fact_Result_Answer`	ON (`Fact_Result_Answer`.`Result_ID` 	= `Fact_Result`.`Result_ID`)
INNER JOIN `Dim_Question` 		ON (`Fact_Result_Answer`.`Question_ID` 	= `Dim_Question`.`Question_ID`)
WHERE (
		DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
		AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   		AND `Dim_Survey`.`Survey_Name` IN (
--    											'SBIB OAN - Credit Life Claims',
--    											'SBIB OAN - Funeral Claims',
--    											'SBIB OAN - Retentions - Assurance',
--    											'SBIB OAN - Retentions - Car & Home',
--    											'SBIB OAN - Retentions - HOC',
--    											'SBIB OAN - Retentions - Personal Accident',
--    											'SBIB OAN - Sales - Car',
   											'SBIB OAN - Servicing - Accident & Health',
   											'SBIB OAN - Servicing - Car',
   											'SBIB OAN - Servicing - Credit Life',
   											'SBIB OAN - Servicing - Funeral',
   											'SBIB OAN - Servicing - Home'
   											)
   		AND `Dim_Question`.`Question_Name` = 'SBIB (NPS)'
)
GROUP BY 
   1,
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)   
   
   
   
-- Retentions   
   
   UNION
   
SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS month,
   'SBIB - Queues' as project,
   'NPSD - Retentions' as report_name,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as detractor,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` BETWEEN 6.5 AND 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as passive,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as promotor,
   (COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) - COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END))) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as nps,
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) as count,
   1 AS sort_order
FROM `Fact_Result`
INNER JOIN `Dim_Survey` 		ON (`Fact_Result`.`Survey_ID` 			= `Dim_Survey`.`Survey_ID`)
INNER JOIN `Fact_Result_Answer`	ON (`Fact_Result_Answer`.`Result_ID` 	= `Fact_Result`.`Result_ID`)
INNER JOIN `Dim_Question` 		ON (`Fact_Result_Answer`.`Question_ID` 	= `Dim_Question`.`Question_ID`)
WHERE (
		DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
		AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   		AND `Dim_Survey`.`Survey_Name` IN (
--    											'SBIB OAN - Credit Life Claims',
--    											'SBIB OAN - Funeral Claims',
	   											'SBIB OAN - Retentions - Assurance',
	   											'SBIB OAN - Retentions - Car & Home',
	   											'SBIB OAN - Retentions - HOC',
	   											'SBIB OAN - Retentions - Personal Accident'
--    											'SBIB OAN - Sales - Car',
--    											'SBIB OAN - Servicing - Accident & Health',
--    											'SBIB OAN - Servicing - Car',
--    											'SBIB OAN - Servicing - Credit Life',
--    											'SBIB OAN - Servicing - Funeral',
--    											'SBIB OAN - Servicing - Home'
   											)
   		AND `Dim_Question`.`Question_Name` = 'SBIB (NPS)'
)
GROUP BY 
   1,
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)      
   
-- Sales   
   
   UNION
   
   SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS month,
   'SBIB - Queues' as project,
   'NPSD - Sales' as report_name,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as detractor,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` BETWEEN 6.5 AND 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as passive,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as promotor,
   (COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) - COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END))) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as nps,
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) as count,
   1 AS sort_order
FROM `Fact_Result`
INNER JOIN `Dim_Survey` 		ON (`Fact_Result`.`Survey_ID` 			= `Dim_Survey`.`Survey_ID`)
INNER JOIN `Fact_Result_Answer`	ON (`Fact_Result_Answer`.`Result_ID` 	= `Fact_Result`.`Result_ID`)
INNER JOIN `Dim_Question` 		ON (`Fact_Result_Answer`.`Question_ID` 	= `Dim_Question`.`Question_ID`)
WHERE (
		DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
		AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   		AND `Dim_Survey`.`Survey_Name` IN (
--    											'SBIB OAN - Credit Life Claims',
--    											'SBIB OAN - Funeral Claims',
-- 	   											'SBIB OAN - Retentions - Assurance',
-- 	   											'SBIB OAN - Retentions - Car & Home',
-- 	   											'SBIB OAN - Retentions - HOC',
-- 	   											'SBIB OAN - Retentions - Personal Accident',
    											'SBIB OAN - Sales - Car'
--    											'SBIB OAN - Servicing - Accident & Health',
--    											'SBIB OAN - Servicing - Car',
--    											'SBIB OAN - Servicing - Credit Life',
--    											'SBIB OAN - Servicing - Funeral',
--    											'SBIB OAN - Servicing - Home'
   											)
   		AND `Dim_Question`.`Question_Name` = 'SBIB (NPS)'
)
GROUP BY 
   1,
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)   
   
-- Embedded Claims   
   
   UNION
   
    SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS month,
   'SBIB - Queues' as project,
   'NPSD - Embedded Claims' as report_name,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as detractor,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` BETWEEN 6.5 AND 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as passive,
   COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as promotor,
   (COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` >= 8.5 THEN 1
   END)) - COUNT((CASE
      WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 6.5 THEN 1
   END))) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 as nps,
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) as count,
   1 AS sort_order
FROM `Fact_Result`
INNER JOIN `Dim_Survey` 		ON (`Fact_Result`.`Survey_ID` 			= `Dim_Survey`.`Survey_ID`)
INNER JOIN `Fact_Result_Answer`	ON (`Fact_Result_Answer`.`Result_ID` 	= `Fact_Result`.`Result_ID`)
INNER JOIN `Dim_Question` 		ON (`Fact_Result_Answer`.`Question_ID` 	= `Dim_Question`.`Question_ID`)
WHERE (
		DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
		AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   		AND `Dim_Survey`.`Survey_Name` IN (
    											'SBIB OAN - Credit Life Claims',
    											'SBIB OAN - Funeral Claims'
-- 	   											'SBIB OAN - Retentions - Assurance',
-- 	   											'SBIB OAN - Retentions - Car & Home',
-- 	   											'SBIB OAN - Retentions - HOC',
-- 	   											'SBIB OAN - Retentions - Personal Accident',
--    											'SBIB OAN - Sales - Car',
--    											'SBIB OAN - Servicing - Accident & Health',
--    											'SBIB OAN - Servicing - Car',
--    											'SBIB OAN - Servicing - Credit Life',
--    											'SBIB OAN - Servicing - Funeral',
--    											'SBIB OAN - Servicing - Home'
   											)
   		AND `Dim_Question`.`Question_Name` = 'SBIB (NPS)'
)
GROUP BY 
   1,
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)     
