SET @attributeName = 'Total ATM' ; 
SET @projectName = 'ATM'; 
SET @reportName = 'Experience Rating: Provincial'; 
SET @SurveyName = 'ATM'; 
SET @QuestionName = 'ATM Experience (1 - 10) (ATM)';
SET @Interaction_Filter_Column_Name = 'IF_Servicing_Entity'; -- Interaction Filter Column Name
SET @Filter_Value = 'Branch'; -- Interaction Filter Value

SET @sql = CONCAT('
SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
    "', @attributeName, '" AS attribute,
    "', @projectName, '" AS project,
    "', @reportName, '" AS report_name,
    AVG(Fact_Result_Answer.Answer_Numeric_Value) AS value,
    COUNT(Fact_Result.Result_ID) AS count,
    0 AS sort_order
FROM
    Fact_Result
INNER JOIN Fact_Result_Answer ON Fact_Result.Result_ID = Fact_Result_Answer.Result_ID
    AND Fact_Result_Answer.Question_Name = "', @QuestionName, '"
INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
INNER JOIN Fact_Interaction_Data ON Fact_Result.Result_ID = Fact_Interaction_Data.Result_ID
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"
WHERE
    DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'')
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
    AND Dim_Survey.Survey_Name = "', @SurveyName, '"
    AND Dim_Question.Question_Name = "', @QuestionName, '"
GROUP BY
    LAST_DAY(Fact_Result.DateTime_Created_Result);');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
