#NPS Distribution

SET @projectName = 'Branch'; 
SET @reportName = 'Standard Bank NPS DISTRIBUTION: Overall Branch'; 
SET @SurveyName = 'Standard Bank Branch SMS'; 
SET @QuestionName = 'NPS Rating (0 - 10)';



SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS month,      
    @projectName AS project,                                                                 
    @reportName AS report_name,      
    COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS detractor,
    COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` IN (7,8) THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS passives,
    COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS promoters,
   (COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` > 8 THEN 1 END)) -
            COUNT((CASE WHEN `Fact_Result_Answer`.`Answer_Numeric_Value` < 7 THEN 1 END))) 
            / COUNT(`Fact_Result_Answer`.`Answer_Numeric_Value`) * 100 AS nps,
    COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS count
   

FROM `Fact_Result_Answer` 
INNER JOIN `Dim_Question`  ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)
INNER JOIN `Fact_Result` ON (`Fact_Result_Answer`.`Result_ID` = `Fact_Result`.`Result_ID`)
INNER JOIN `Dim_Survey`  ON ( `Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`)


WHERE (
   DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN 
   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND `Dim_Survey`.`Survey_Name` = @SurveyName                       
   AND `Dim_Question`.`Question_Name` = @QuestionName  
 
)
GROUP BY 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
