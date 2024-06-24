SET @SurveyName = 'Internet Banking v2'; -- Assign survey name
SET @1stQuestionName = '1. Achieved Purpose (Internet Banking v2)'; -- Assign 1st question name
SET @2ndQuestionName = '3. Overall Experience (1-10) (Internet Banking v2)'; -- Assign 2nd question name
SET @3rdQuestionName = '2. NPS Rating (0-10) (Internet Banking v2)'; -- Assign 3rd question name
SET @4thQuestionName = '7. Verbatim (Internet Banking v2)'; -- Assign 4th question name
SET @ATT_1stQuestionName = '1st Question (Achieved Purpose)';
SET @ATT_2ndQuestionName = '2nd Question (Overall Experience Rating)';
SET @ATT_3rdQuestionName = '3rd Question (NPS Rating)';
SET @ATT_4thQuestionName = '4th Question (Free Open Text)';
SET @ATT_DistributionName = "SMS's Distributed";
SET @projectName = 'ATM'; -- Assign Project Name
SET @reportName = 'Distribution and Response Statistics'; -- Assign report Name





-- Total Distribution --

SELECT
    LAST_DAY(Fact_Outbound_Queue.DateTime_Sent) AS date,
   @ATT_DistributionName AS attribute,                                    #<---- Change Attribute
   @projectName AS project,                                          #<---- Change project
   @reportName AS report_name,                 #<---- Change Report_name
   COUNT(DISTINCT(Fact_Outbound_Queue.Outbound_Queue_ID)) as value,
   1 AS 'sort_order'


FROM Fact_Outbound_Queue
WHERE (
   Fact_Outbound_Queue.DateTime_Sent BETWEEN  
   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND Fact_Outbound_Queue.Survey_Name = @SurveyName                     #<---- Change survey_name
   AND 	Fact_Outbound_Queue.Status_ID_Outbound_Queue = 52
   -- AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
)
GROUP BY 
   LAST_DAY(Fact_Outbound_Queue.DateTime_Sent)

UNION
-- 1st Question--

SELECT
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_1stQuestionName AS attribute,                                        -- Don't Change Attribute
   @projectName AS project,                                                      -- Change project name
   @reportName AS report_name,                                 -- Change report name
   COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS value,                      -- Count response
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
            -- AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION

-- ------------------------------------------------------------------------------------------------------
-- 2nd Question------------------------------------------------------------------------------------------

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_2ndQuestionName AS attribute,                                        
   @projectName AS project,                                                      -- Change project name
   @reportName AS report_name,                                 -- Change report name
   COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS value,                      -- Count response
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
           --  AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- ------------------------------------------------------------------------------------------------------
-- 3rd Question------------------------------------------------------------------------------------------

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_3rdQuestionName AS attribute,                                        -- Don't Change Attribute
   @projectName AS project,                                                      -- Change project name
   @reportName AS report_name,                                 -- Change report name
   COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS value,                      -- Count response
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
           --  AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION

-- 4th Question--

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,              
   @ATT_4thQuestionName AS attribute,                                        -- Don't Change Attribute
   @projectName AS project,                                                      -- Change project name
   @reportName AS report_name,                                 -- Change report name
   COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS value,                      -- Count response
   5 AS sort_order -- Sort
      FROM Fact_Result
         INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
         INNER JOIN Fact_Result_Answer ON (Fact_Result_Answer.Result_ID = Fact_Result.Result_ID) AND (Fact_Result_Answer.Question_Name = @4thQuestionName)
         INNER JOIN Dim_Question ON (Fact_Result_Answer.Question_ID = Dim_Question.Question_ID)
       

      WHERE (
            LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN
            DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
            AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
            AND Dim_Survey.Survey_Name = @SurveyName
            AND Dim_Question.Question_Name = @4thQuestionName
           --  AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
)
GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)

UNION
-- Response Rate --
SELECT
    t1.date,
    'Response Rate % (based on the 1st Question)' AS attribute,            -- Don't Change Attribute
    @projectName AS project,                                          -- Change project name
    @reportName AS report_name,                 -- Change report name
    IFNULL(t2.value, 0) / NULLIF(IFNULL(t1.value, 0), 0)*100 AS value,     -- Calculate response rate
    6 AS sort_order
FROM
    (SELECT
        LAST_DAY(Fact_Outbound_Queue.DateTime_Sent) AS date,
        COUNT(DISTINCT Fact_Outbound_Queue.Outbound_Queue_ID) as value
     FROM Fact_Outbound_Queue
     WHERE Fact_Outbound_Queue.DateTime_Sent BETWEEN 
     DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
         AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
         AND Fact_Outbound_Queue.Survey_Name = @SurveyName
         AND Fact_Outbound_Queue.Status_ID_Outbound_Queue = 52
        --  AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
     GROUP BY LAST_DAY(Fact_Outbound_Queue.DateTime_Sent)
    ) AS t1
LEFT JOIN
    (SELECT
        LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
        COUNT(DISTINCT Fact_Result_Answer.Result_ID) AS value
     FROM Fact_Result
     INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
     INNER JOIN Fact_Result_Answer ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID
     INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
     INNER JOIN Fact_Outbound_Queue ON (Fact_Result.Outbound_Queue_ID=Fact_Outbound_Queue.Outbound_Queue_ID ) AND Fact_Outbound_Queue.Survey_Name =  @SurveyName 
     WHERE Dim_Survey.Survey_Name = @SurveyName
         AND Dim_Question.Question_Name = @1stQuestionName
         AND Fact_Result.DateTime_Created_Result BETWEEN 
         DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
         AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        --  AND Fact_Outbound_Queue.IF_SEGMENT_BRANCH_CUSTOMERS = @SEGMENTBRANCHCUSTOMERS
     GROUP BY LAST_DAY(Fact_Result.DateTime_Created_Result)
    ) AS t2 ON t1.date = t2.date

