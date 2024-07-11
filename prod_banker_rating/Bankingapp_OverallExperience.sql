SET @attributeName = 'Ease Of Completion' ; -- Assign attribute name 
SET @projectName = 'Banking App'; -- Assign Project Name
SET @reportName = 'Overall experience Rating'; -- Assign report Name
SET @SurveyName = 'Banking App v2'; -- Assign survey name
#SET @QuestionName = 'Banking App v2 - Ease Of Completion'; -- Assign 1st question name
#SET @filterName = 'INCLUSIVE' ; -- Assign filter name

SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,      
   `Dim_Question`.`Question_Name` AS attribute,                                   
   @projectName AS project,                                              
   @reportName AS report_name,                             
   AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) AS value,
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS count,
   0 AS sort_order

FROM `Fact_Result` 

INNER JOIN `Fact_Result_Answer` ON ( `Fact_Result`.`Result_ID`= `Fact_Result_Answer`.`Result_ID`) 
INNER JOIN `Dim_Question`  ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
INNER JOIN `Dim_Survey`  ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`)
#INNER JOIN `Fact_Interaction_Data` ON (`Fact_Result`.`Result_ID` = `Fact_Interaction_Data`.`Result_ID`) AND (Fact_Interaction_Data.IF_SEGMENT_BRANCH_CUSTOMERS = @filterName)


WHERE (
   DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN 
   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND `Dim_Survey`.`Survey_Name` = @SurveyName                          
   AND `Dim_Question`.`Question_Name` IN ('Making Payments', 'Prepaid Purchases', 'Registration process', 'Manage Card', 'Opening New Accounts', 'History and Documents')     
   #AND Fact_Interaction_Data .IF_SEGMENT_BRANCH_CUSTOMERS = @filterName                      
)

GROUP BY 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`), `Dim_Question`.`Question_Name`
