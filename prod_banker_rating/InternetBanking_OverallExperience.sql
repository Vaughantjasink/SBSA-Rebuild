-- Can Parameterize 

SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,
   `Dim_Question`.`Question_Name` AS attribute,
   'Internet Banking' as project,
   'Overall experience Rating' as report_name,
   AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) as value,
   COUNT(`Fact_Result`.`Result_ID`) as count
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
   `Fact_Result`.`Survey_Name` = 'Internet Banking v2'
)
INNER JOIN `Dim_Survey`
ON (
   `Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`
)
WHERE (
   DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN '2024-05-01' AND '2024-05-31'
   AND `Dim_Survey`.`Survey_Name` IN ('Internet Banking v2')
   AND `Dim_Question`.`Question_Name` IN ('Making Payments', 'Prepaid Purchases', 'Registration process', 'Manage Card', 'Opening New Accounts', 'History and Documents')
)
GROUP BY 
   `Dim_Question`.`Question_Name`,
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
