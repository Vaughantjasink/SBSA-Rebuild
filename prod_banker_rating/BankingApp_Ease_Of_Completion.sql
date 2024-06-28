SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,
   'Ease Of Completion' AS attribute,
   'Banking App' as project,
   'Ease Of Completion' as report_name,
   AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) as value,
   COUNT(Fact_Result.Result_ID) as count,   
   1 as sort_order
FROM `Fact_Result_Answer`
INNER JOIN `Dim_Question`
ON (
   `Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`
)
INNER JOIN `Fact_Result`
ON (
   `Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`
)
AND (
   `Fact_Result`.`Survey_Name` = 'Banking App v2'
)
INNER JOIN `Dim_Survey`
ON (
   `Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`
)
WHERE 
	DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND `Dim_Survey`.`Survey_Name` = 'Banking App v2'
   AND `Dim_Question`.`Question_Name` = 'Banking App v2 - Ease Of Completion'
   

GROUP BY 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
