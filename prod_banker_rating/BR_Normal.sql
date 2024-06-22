-- Assign attribute name to a variable
SET @attributeName = 'Total Cellphone Banking'; 

-- Assign project name to a variable
SET @projectName = 'Cellphone Banking';

-- Assign report name to a variable
SET @reportName = 'Experience Rating';

-- Assign survey name to a variable
SET @SurveyName = 'Cellphone Banking';

-- Assign question name to a variable
SET @QuestionName = 'Overall Experience (1 - 10) (Cellphone Banking)';

-- Main query to retrieve and aggregate survey results
SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,      -- Get the last day of the month from the result creation date
   @attributeName AS attribute,                                    -- Use the attribute name assigned above
   @projectName AS project,                                        -- Use the project name assigned above
   @reportName AS report_name,                                     -- Use the report name assigned above
   AVG(`Fact_Result_Answer`.`Answer_Numeric_Value`) AS value,      -- Calculate the average numeric value of the answers
   COUNT(DISTINCT(`Fact_Result_Answer`.`Result_ID`)) AS count,     -- Count distinct results to get the number of responses
   0 AS sort_order                                                 -- Set sort order to 0 (could be adjusted if needed)

FROM `Fact_Result`

-- Join with Fact_Result_Answer to get the answers for each result
INNER JOIN `Fact_Result_Answer` 
   ON (`Fact_Result`.`Result_ID` = `Fact_Result_Answer`.`Result_ID`) 
   AND (`Fact_Result_Answer.Question_Name = @QuestionName`)

-- Join with Dim_Question to get question details
INNER JOIN `Dim_Question`  
   ON (`Fact_Result_Answer`.`Question_ID` = `Dim_Question`.`Question_ID`)

-- Join with Dim_Survey to get survey details
INNER JOIN `Dim_Survey`  
   ON (`Fact_Result`.`Survey_ID` = `Dim_Survey`.`Survey_ID`)

-- Filter the results based on date range and survey/question names
WHERE (
   DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN 
   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')  -- Start of last month
   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND  -- End of last month
   AND `Dim_Survey`.`Survey_Name` = @SurveyName                         -- Filter by survey name
   AND `Dim_Question`.`Question_Name` = @QuestionName                   -- Filter by question name
)

-- Group by the last day of the month to aggregate results per month
GROUP BY 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`);
