SET @SurveyName = 'ATM';
SET @1stQuestionName = 'Achieved Purpose (ATM)';
SET @2ndQuestionName = 'ATM Experience (1 - 10) (ATM)';
SET @3rdQuestionName = 'NPS Rating (0 - 10) (ATM)';
SET @4thQuestionName = 'Free Text (ATM)';
SET @ATT_1stQuestionName = '1st Question (Achieved Purpose)';
SET @ATT_2ndQuestionName = '2nd Question (Overall Experience Rating)';
SET @ATT_3rdQuestionName = '3rd Question (NPS Rating)';
SET @ATT_4thQuestionName = '4th Question (Free Open Text)';
SET @ATT_DistributionName = "SMS's Distributed";
SET @projectName = 'ATM';
SET @reportName = 'Distribution and Response Statistics';
SET @Interaction_Filter_Column_Name = 'IF_Servicing_Entity';
SET @Filter_Value = 'Branch';

SET @sql = CONCAT('
-- Total Distribution --
SELECT
    LAST_DAY(Fact_Outbound_Queue.DateTime_Sent) AS date,
    "', @ATT_DistributionName, '" AS attribute,                                    
    "', @projectName, '" AS project,                                        
    "', @reportName, '" AS report_name,                
    COUNT(DISTINCT(Fact_Outbound_Queue.Outbound_Queue_ID)) as value,
    1 AS sort_order

FROM Fact_Outbound_Queue

INNER JOIN  Fact_Interaction_Data ON Fact_Outbound_Queue.Outbound_Queue_ID = Fact_Interaction_Data.Outbound_Queue_ID 
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"

WHERE 
    Fact_Outbound_Queue.DateTime_Sent BETWEEN  
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
    AND Fact_Outbound_Queue.Survey_Name = "', @SurveyName, '"                    
    AND Fact_Outbound_Queue.Status_ID_Outbound_Queue in (52,42)
    
GROUP BY 
    LAST_DAY(Fact_Outbound_Queue.DateTime_Sent)

UNION
-- 1st Question--
SELECT
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
    "', @ATT_1stQuestionName , '" AS attribute,                                       
    "', @projectName , '" AS project,                                                      
    "', @reportName , '" AS report_name,                                
    COUNT(Fact_Result.Result_ID) AS value,                      
    2 AS sort_order 
FROM Fact_Result
INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
INNER JOIN Fact_Result_Answer ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID 
    AND Fact_Result_Answer.Question_Name = "', @1stQuestionName, '"
INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Fact_Interaction_Data ON Fact_Result.Result_ID = Fact_Interaction_Data.Result_ID 
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"
WHERE 
    LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
    AND Dim_Survey.Survey_Name = "', @SurveyName, '"
    AND Dim_Question.Question_Name = "', @1stQuestionName, '"
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- 2nd Question--
SELECT 
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
    "', @ATT_2ndQuestionName , '" AS attribute,                                        
    "', @projectName , '" AS project,                                                      
    "', @reportName , '" AS report_name,                               
    COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS value,                      
    3 AS sort_order 
FROM Fact_Result
INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID 
INNER JOIN Fact_Result_Answer ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID 
    AND Fact_Result_Answer.Question_Name = "', @2ndQuestionName, '"
INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Fact_Interaction_Data ON Fact_Result.Result_ID = Fact_Interaction_Data.Result_ID 
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"
WHERE 
    LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
    AND Dim_Survey.Survey_Name = "', @SurveyName, '"
    AND Dim_Question.Question_Name = "', @2ndQuestionName, '"
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- 3rd Question--
SELECT 
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
    "', @ATT_3rdQuestionName , '" AS attribute,                                        
    "', @projectName , '" AS project,                                                      
    "', @reportName , '" AS report_name,                                
    COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS value,                      
    4 AS sort_order 
FROM Fact_Result
INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
INNER JOIN Fact_Result_Answer ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID 
    AND Fact_Result_Answer.Question_Name = "', @3rdQuestionName, '"
INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Fact_Interaction_Data ON Fact_Result.Result_ID = Fact_Interaction_Data.Result_ID 
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"
WHERE 
    LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
    AND Dim_Survey.Survey_Name = "', @SurveyName, '"
    AND Dim_Question.Question_Name = "', @3rdQuestionName, '"
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- 4th Question--
SELECT 
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
    "', @ATT_4thQuestionName , '" AS attribute,                                       
    "', @projectName , '" AS project,                                                     
    "', @reportName , '" AS report_name,                                 
    COUNT(Fact_Result.Result_ID) AS value,                      
    5 AS sort_order 
FROM Fact_Result
INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
INNER JOIN Fact_Result_Answer ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID 
    AND Fact_Result_Answer.Question_Name = "', @4thQuestionName, '"
INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Fact_Interaction_Data ON Fact_Result.Result_ID = Fact_Interaction_Data.Result_ID 
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"
WHERE 
    LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
    AND Dim_Survey.Survey_Name = "', @SurveyName, '"
    AND Dim_Question.Question_Name = "', @4thQuestionName, '"
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- Response Rate --
SELECT
    t1.date,
    ''Response Rate % (based on the 1st Question)'' AS attribute,            
    "', @projectName , '" AS project,                                         
    "', @reportName , '" AS report_name,                 
    IFNULL(t2.value, 0) / NULLIF(IFNULL(t1.value, 0), 0) * 100 AS value,     
    6 AS sort_order
FROM
    (SELECT
        LAST_DAY(Fact_Outbound_Queue.DateTime_Sent) AS date,
        COUNT(DISTINCT Fact_Outbound_Queue.Outbound_Queue_ID) as value
     FROM Fact_Outbound_Queue

	INNER JOIN  Fact_Interaction_Data ON Fact_Outbound_Queue.Outbound_Queue_ID = Fact_Interaction_Data.Outbound_Queue_ID 
    AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"

     WHERE Fact_Outbound_Queue.DateTime_Sent BETWEEN 
     DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
     AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
     AND Fact_Outbound_Queue.Survey_Name = "', @SurveyName, '"
     AND Fact_Outbound_Queue.Status_ID_Outbound_Queue IN (52,42)
     
     GROUP BY LAST_DAY(Fact_Outbound_Queue.DateTime_Sent)
    ) AS t1
LEFT JOIN
    (SELECT
        LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
        COUNT(Fact_Result.Result_ID) AS value
     FROM Fact_Result
     INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
     INNER JOIN Fact_Result_Answer ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID
     INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID 
	 INNER JOIN Fact_Interaction_Data ON Fact_Result.Result_ID = Fact_Interaction_Data.Result_ID 
     	AND Fact_Interaction_Data.', @Interaction_Filter_Column_Name, ' = "', @Filter_Value, '"
     WHERE 
     Dim_Survey.Survey_Name = "', @SurveyName, '"
     AND Dim_Question.Question_Name = "', @1stQuestionName , '"
     AND Fact_Result.DateTime_Created_Result BETWEEN 
     DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, ''%Y-%m-01 00:00:00'') 
     AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL ''23:59:59'' HOUR_SECOND
     GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)
    ) AS t2 ON t1.date = t2.date
');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
