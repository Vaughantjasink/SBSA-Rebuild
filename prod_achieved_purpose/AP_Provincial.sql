SET @projectName = 'ATM'; -- Assign Project Name
SET @reportName = 'Achieved Purpose: Provincial'; -- Assign report Name
SET @SurveyName = 'ATM'; -- Assign survey name
SET @QuestionName = 'Achieved Purpose (ATM)'; -- Assign 1st question name
   

SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,
    CASE
      WHEN 1 = 0 THEN CAST( Dim_RE_Group.RE_Group_Name AS char )
      WHEN Dim_RE_Group.RE_Group_Name IN ('Eastern Cape Province') THEN 'Eastern Cape'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Gauteng Province') THEN 'Gauteng'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Kopano Central Province') THEN 'Kopano Central'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Kwazulu Natal Province') THEN 'KwaZulu Natal'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Limpopo Province') THEN 'Limpopo'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Mpumalanga Province') THEN 'Mpumalanga'
      WHEN Dim_RE_Group.RE_Group_Name IN ('North West Province') THEN 'North West'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Western Cape Province') THEN 'Western Cape'
      ELSE CAST( Dim_RE_Group.RE_Group_Name AS char )
   END AS attribute,
   @reportName AS report_name,                                              
   @projectName AS project,                                                                
   COUNT((CASE
      WHEN Fact_Result_Answer.`Answer_Numeric_Value` = 1 THEN 1
   END)) / COUNT(Fact_Result.Result_ID) * 100 AS value,
   COUNT(Fact_Result.Result_ID) AS count,
   case
when RE_Group_Name = 'Total'  then 1
when RE_Group_Name = 'Gauteng Province'  then 4
when RE_Group_Name = 'KwaZulu Natal Province'  then 5
when RE_Group_Name = 'Western Cape Province'  then 6
when RE_Group_Name = 'Eastern Cape Province'  then 7
when RE_Group_Name = 'Mpumalanga Province'  then 8
when RE_Group_Name = 'Limpopo Province'  then 9
when RE_Group_Name = 'North West Province'  then 10
when RE_Group_Name = 'Kopano Central Province'  then 11
END AS sort_order


FROM Fact_Result
INNER JOIN MT_RE_Group_RE_Agent 	ON (Fact_Result.RE_Agent_ID 			= MT_RE_Group_RE_Agent.RE_Agent_ID)
INNER JOIN Dim_RE_Group 			ON (MT_RE_Group_RE_Agent.RE_Group_ID 	= Dim_RE_Group.RE_Group_ID)
INNER JOIN Fact_Result_Answer		ON (Fact_Result_Answer.Result_ID 		= Fact_Result.Result_ID) AND (Fact_Result_Answer.Question_Name = @QuestionName)
INNER JOIN Dim_Survey 				ON (Fact_Result.Survey_ID 				= Dim_Survey.Survey_ID)
INNER JOIN Fact_Interaction_Data 	ON (Fact_Result.Result_ID 				= Fact_Interaction_Data.Result_ID)
INNER JOIN Dim_Question 			ON (Fact_Result_Answer.Question_ID		= Dim_Question.Question_ID)

WHERE (
   	LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN 
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
   	AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
  	AND Dim_Survey.Survey_Name = @SurveyName
	AND Dim_Question.Question_Name = @QuestionName  
   	AND Dim_RE_Group.RE_Group_Name IN (                                              
                                            'Eastern Cape Province',
                                            'Gauteng Province',
                                            'Kopano Central Province',
                                            'Kwazulu Natal Province',
                                            'Limpopo Province',
                                            'Mpumalanga Province',
                                            'North West Province',
                                            'Western Cape Province'
                                        )
)

GROUP BY 
   CASE
      WHEN 1 = 0 THEN CAST( Dim_RE_Group.RE_Group_Name AS char )
      WHEN Dim_RE_Group.RE_Group_Name IN ('Eastern Cape Province') THEN 'Eastern Cape'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Gauteng Province') THEN 'Gauteng'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Kopano Central Province') THEN 'Kopano Central'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Kwazulu Natal Province') THEN 'KwaZulu Natal'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Limpopo Province') THEN 'Limpopo'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Mpumalanga Province') THEN 'Mpumalanga'
      WHEN Dim_RE_Group.RE_Group_Name IN ('North West Province') THEN 'North West'
      WHEN Dim_RE_Group.RE_Group_Name IN ('Western Cape Province') THEN 'Western Cape'
      ELSE CAST( Dim_RE_Group.RE_Group_Name AS char )
   END,
   LAST_DAY(Fact_Result.DateTime_Created_Result),
   case
when RE_Group_Name = 'Total'  then 1
when RE_Group_Name = 'Gauteng Province'  then 4
when RE_Group_Name = 'KwaZulu Natal Province'  then 5
when RE_Group_Name = 'Western Cape Province'  then 6
when RE_Group_Name = 'Eastern Cape Province'  then 7
when RE_Group_Name = 'Mpumalanga Province'  then 8
when RE_Group_Name = 'Limpopo Province'  then 9
when RE_Group_Name = 'North West Province'  then 10
when RE_Group_Name = 'Kopano Central Province'  then 11
END
