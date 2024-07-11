-- This script is specifically for IVR surveys 



SET @SurveyName = 'Transactional Survey';
SET @projectName = 'Cellphone Banking';
SET @reportName = 'Experience Rating';
SET @1stQuestionName = 'Did you manage to achieve everything you intended during this call? (Y_N)';
SET @2ndQuestionName = 'Please rate how likely you are to recommend Standard bank to friends & family based on your experience on this call (0 - 10)';
SET @3rdQuestionName = 'Please rate your experience with the banker on this call (1 - 10)';
SET @4thQuestionName = 'Free Text (ATM)';
SET @ATT_1stQuestionName = '1st Question (Achieved Purpose)';
SET @ATT_2ndQuestionName = '2nd Question (Overall Experience Rating)';
SET @ATT_3rdQuestionName = '3rd Question (NPS Rating)';
SET @ATT_4thQuestionName = '4th Question (Free Open Text)';
SET @ATT_DistributionName = "SMS's Distributed";

-- Query to get total distributions
SELECT 
    T0.date,
    @ATT_DistributionName AS 'attribute',
    @reportName AS report_name,
    @projectName AS project,
    T0.incompletecount + T1.completecount AS value, -- Corrected alias and added space
    1 AS 'sort_order'
FROM (
    SELECT 
        LAST_DAY(Fact_Call_Incomplete.Call_Date_Time_Start) AS date, -- Corrected table name
        COUNT(*) AS incompletecount
    FROM Fact_Call_Incomplete 
    WHERE
        Fact_Call_Incomplete.Call_Date_Time_Start BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        AND Survey_Name = @SurveyName
    GROUP BY LAST_DAY(Fact_Call_Incomplete.Call_Date_Time_Start) -- Corrected table name
) T0
LEFT OUTER JOIN (
    SELECT 
        LAST_DAY(Fact_Call_Complete.Call_Date_Time_Start) AS date,
        COUNT(*) AS completecount
    FROM Fact_Call_Complete
    WHERE
        Fact_Call_Complete.Call_Date_Time_Start BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        AND Survey_Name = @SurveyName
    GROUP BY LAST_DAY(Fact_Call_Complete.Call_Date_Time_Start)
) T1 ON T0.date = T1.date

UNION

SELECT
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_1stQuestionName AS attribute,                                        -- Don't Change Attribute
   @projectName AS project,                                                      -- Change project name
   @reportName AS report_name,                                 -- Change report name
   IFNULL(COUNT(Fact_Result.Result_ID),0) AS value,                      -- Count response
   2 AS sort_order -- Sort
      FROM Fact_Result
         INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
         INNER JOIN Fact_Result_Answer ON (Fact_Result_Answer.Result_ID = Fact_Result.Result_ID) AND (Fact_Result_Answer.Question_Name = @1stQuestionName)
         INNER JOIN Dim_Question ON (Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
         

      WHERE (
            LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND Dim_Survey.Survey_Name = @SurveyName
            AND Dim_Question.Question_Name = @1stQuestionName
            
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION

-- ------------------------------------------------------------------------------------------------------
-- 2nd Question------------------------------------------------------------------------------------------

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_2ndQuestionName AS attribute,                                        
   @projectName AS project,                                                      
   @reportName AS report_name,                                 
   IFNULL(COUNT(Fact_Result.Result_ID),0) AS value,                      
   3 AS sort_order -- Sort
      FROM Fact_Result
         INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey.Survey_ID) 
         INNER JOIN Fact_Result_Answer ON (Fact_Result_Answer.Result_ID = Fact_Result.Result_ID) AND (Fact_Result_Answer.Question_Name = @2ndQuestionName)
         INNER JOIN Dim_Question ON (Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
         

      WHERE (
            LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND Dim_Survey.Survey_Name = @SurveyName
            AND Dim_Question.Question_Name = @2ndQuestionName
          
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- ------------------------------------------------------------------------------------------------------
-- 3rd Question------------------------------------------------------------------------------------------

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_3rdQuestionName AS attribute,                                        
   @projectName AS project,                                                      
   @reportName AS report_name,                                 
   IFNULL(COUNT(Fact_Result.Result_ID),0) AS value,                      
   4 AS sort_order -- Sort
      FROM Fact_Result
         INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
         INNER JOIN Fact_Result_Answer ON (Fact_Result_Answer.Result_ID = Fact_Result.Result_ID) AND (Fact_Result_Answer.Question_Name = @3rdQuestionName)
         INNER JOIN Dim_Question ON (Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
        

      WHERE (
            LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND Dim_Survey.Survey_Name = @SurveyName
            AND Dim_Question.Question_Name = @3rdQuestionName
           
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION

-- 4th Question--

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_4thQuestionName AS attribute,                                        
   @projectName AS project,                                                      
   @reportName AS report_name,                                 
   COUNT(Fact_Result.Result_ID) AS value,                      
   5 AS sort_order -- Sort
      FROM Fact_Result
         INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
      WHERE (
            LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND Dim_Survey.Survey_Name = @SurveyName
            AND Fact_Result.IVR_Voicemail_File IS NOT NULL         
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)


UNION
-- Query to calculate response rate

SELECT 
    T0.date,
    'Response Rate % (based on the 1st Question)' AS 'attribute',
    @reportName AS report_name,
    @projectName AS project,
    IFNULL(T1.completecount / (T0.incompletecount + T1.completecount), 0) *100 AS value, -- Calculate response rate
    6 AS 'sort_order'
FROM (
    SELECT 
        LAST_DAY(Fact_Call_Incomplete.Call_Date_Time_Start) AS date, -- Corrected table name
        COUNT(*) AS incompletecount
    FROM Fact_Call_Incomplete 
    WHERE
        Fact_Call_Incomplete.Call_Date_Time_Start BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        AND Survey_Name = @SurveyName
    GROUP BY LAST_DAY(Fact_Call_Incomplete.Call_Date_Time_Start) -- Corrected table name
) T0
LEFT OUTER JOIN (
    SELECT 
        LAST_DAY(Fact_Call_Complete.Call_Date_Time_Start) AS date,
        COUNT(*) AS completecount
    FROM Fact_Call_Complete
    WHERE
        Fact_Call_Complete.Call_Date_Time_Start BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        AND Survey_Name = @SurveyName
    GROUP BY LAST_DAY(Fact_Call_Complete.Call_Date_Time_Start)
) T1 ON T0.date = T1.date;
