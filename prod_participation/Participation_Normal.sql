
SET @projectName = 'Branch'; -- Assign Project Name
SET @reportName = 'Participation Statistics: Provincial'; -- Assign report Name
SET @SurveyName = 'Standard Bank Branch SMS'; -- Assign survey name
SET @QuestionName = 'Achieved Purpose'; -- Assign 1st question name

SELECT 
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,
   CASE      
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'North West Province' THEN 'North West'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'      
    END 
    AS attribute,
    @projectName AS project,                                          #<---- Change project
    @reportName AS report_name,                 #<---- Change Report_name
   COUNT(DISTINCT(`FACT_RESULT_ANSWER`.`Result_ID`)) AS value,
    CASE        
        WHEN DIM_RE_GROUP.RE_Group_Name = 'Gauteng Province'  then 4
        WHEN DIM_RE_GROUP.RE_Group_Name = 'KwaZulu Natal Province'  then 5
        WHEN DIM_RE_GROUP.RE_Group_Name = 'Western Cape Province'  then 6
        WHEN DIM_RE_GROUP.RE_Group_Name = 'Eastern Cape Province'  then 7
        WHEN DIM_RE_GROUP.RE_Group_Name = 'Mpumalanga Province'  then 8
        WHEN DIM_RE_GROUP.RE_Group_Name = 'Limpopo Province'  then 9
        WHEN DIM_RE_GROUP.RE_Group_Name = 'North West Province'  then 10
        WHEN DIM_RE_GROUP.RE_Group_Name = 'Kopano Central Province'  then 11
    END AS sort_order

FROM `Fact_Result`
        INNER JOIN `MT_RE_Group_RE_Agent` AS `MT_RE_GROUP_RE_AGENT` ON ( `Fact_Result`.`RE_Agent_ID` = `MT_RE_GROUP_RE_AGENT`.`RE_Agent_ID`)
        INNER JOIN `Dim_RE_Group` AS `DIM_RE_GROUP` ON (`MT_RE_GROUP_RE_AGENT`.`RE_Group_ID` = `DIM_RE_GROUP`.`RE_Group_ID`)
        INNER JOIN `Fact_Result_Answer` AS `FACT_RESULT_ANSWER` ON (`FACT_RESULT_ANSWER`.`Result_ID` = `Fact_Result`.`Result_ID`) AND (Fact_Result.Survey_Name = @SurveyName)
        INNER JOIN `Dim_Question` AS `DIM_QUESTION` ON (  `FACT_RESULT_ANSWER`.`Question_ID` = `DIM_QUESTION`.`Question_ID`)
        INNER JOIN `Dim_Survey` AS `DIM_SURVEY`ON (   `Fact_Result`.`Survey_ID` = `DIM_SURVEY`.`Survey_ID`)
WHERE   (
        DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN 
        DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
        AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
        AND `DIM_SURVEY`.`Survey_Name` = @SurveyName
        AND `DIM_RE_GROUP`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'Limpopo Province', 'Mpumalanga Province', 'North West Province', 'Western Cape Province')
        AND `DIM_QUESTION`.`Question_Name` = @QuestionName
        )
GROUP BY 
   CASE
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Eastern Cape Province' THEN 'Eastern Cape'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Gauteng Province' THEN 'Gauteng'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Kopano Central Province' THEN 'Kopano Central'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Kwazulu Natal Province' THEN 'KwaZulu Natal'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Limpopo Province' THEN 'Limpopo'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Mpumalanga Province' THEN 'Mpumalanga'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'North West Province' THEN 'North West'
        WHEN `DIM_RE_GROUP`.`RE_Group_Name` = 'Western Cape Province' THEN 'Western Cape'        
   END,  
   LAST_DAY(`Fact_Result`.`DateTime_Created_Result`)
