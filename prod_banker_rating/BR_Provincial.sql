SET @attributeName = 'Total ATM' ; 
SET @projectName = 'ATM'; 
SET @reportName = 'Experience Rating: Provincial'; 
SET @SurveyName = 'ATM'; 
SET @QuestionName = 'ATM Experience (1 - 10) (ATM)';
SELECT
LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
   CASE
      WHEN Dim_RE_Group.RE_Group_Name = 'Eastern Cape Province' THEN 'Eastern Cape'
      WHEN Dim_RE_Group.RE_Group_Name = 'Gauteng Province' THEN 'Gauteng'
      WHEN Dim_RE_Group.RE_Group_Name = 'Kopano Central Province' THEN 'Kopano Central'
      WHEN Dim_RE_Group.RE_Group_Name = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
      WHEN Dim_RE_Group.RE_Group_Name = 'Limpopo Province' THEN 'Limpopo'
      WHEN Dim_RE_Group.RE_Group_Name = 'Mpumalanga Province' THEN 'Mpumalanga'
      WHEN Dim_RE_Group.RE_Group_Name = 'North West Province' THEN 'North West'
      WHEN Dim_RE_Group.RE_Group_Name = 'Western Cape Province' THEN 'Western Cape'
   END AS attribute,
    @projectName AS project,                                                                 
    @reportName AS report_name,                                               
    AVG(Fact_Result_Answer.Answer_Numeric_Value) AS value,
    COUNT(DISTINCT(Fact_Result_Answer.Result_ID)) AS count,
    CASE
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
    AS sort_order
FROM Fact_Result
INNER JOIN MT_RE_Group_RE_Agent ON (Fact_Result.RE_Agent_ID = MT_RE_Group_RE_Agent.RE_Agent_ID)
INNER JOIN Dim_RE_Group ON (MT_RE_Group_RE_Agent.RE_Group_ID = Dim_RE_Group.RE_Group_ID)
INNER JOIN Fact_Result_Answer ON ( Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)  AND (Fact_Result_Answer.Question_Name = @QuestionName)
INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey .Survey_ID)
WHERE (
   LAST_DAY(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') AND  LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND Dim_Survey.Survey_Name = @SurveyName                      
   AND Fact_Result_Answer.Question_Name = @QuestionName                       
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
      WHEN Dim_RE_Group.RE_Group_Name = ('Eastern Cape Province') THEN 'Eastern Cape'
      WHEN Dim_RE_Group.RE_Group_Name = ('Gauteng Province') THEN 'Gauteng'
      WHEN Dim_RE_Group.RE_Group_Name = ('Kopano Central Province') THEN 'Kopano Central'
      WHEN Dim_RE_Group.RE_Group_Name = ('Kwazulu Natal Province') THEN 'KwaZulu Natal'
      WHEN Dim_RE_Group.RE_Group_Name = ('Limpopo Province') THEN 'Limpopo'
      WHEN Dim_RE_Group.RE_Group_Name = ('Mpumalanga Province') THEN 'Mpumalanga'
      WHEN Dim_RE_Group.RE_Group_Name = ('North West Province') THEN 'North West'
      WHEN Dim_RE_Group.RE_Group_Name = ('Western Cape Province') THEN 'Western Cape' 
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

