-- Can be parameterized

SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,      
    'Prestige Direct CST' AS attribute,                                   
    'Prestige Banking' AS project,                                             
    'Achieved Purpose' AS report_name,                             
   COUNT((CASE
        WHEN Fact_Result_Answer.Answer_Numeric_Value = 1 THEN 1
        END)) / COUNT(Fact_Result_Answer.Result_ID) * 100 AS value,
    COUNT(Fact_Result.Result_ID) AS count

FROM Fact_Result_Answer 
INNER JOIN Dim_Question ON Fact_Result_Answer.Question_ID = Dim_Question.Question_ID
INNER JOIN Fact_Result ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID
INNER JOIN Dim_Survey  ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID



WHERE 
   DATE(Fact_Result.DateTime_Created_Result) BETWEEN 
   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND Dim_Survey.Survey_Name IN (                                                                  #<---- Change survey name
                                        "Alice Lane - Prestige Direct",
                                        "K90 - Prestige Direct",
                                        "Kopano Central - Prestige Direct",
                                        "KZN - Prestige Direct",
                                        "Mbombela - Prestige Direct",
                                        "Menlyn - Prestige Direct",
                                        "North West - Prestige Direct",
                                        "PE - Prestige Direct",
                                        "Polokwane - Prestige Direct",
                                        "Western Cape - Prestige Direct"
   )                        
   AND Dim_Question.Question_Name = 'Did you manage to achieve everything you intended during this call? (Y_N)'                              
  

GROUP BY LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
