
SET @projectName = 'Cellphone Banking';
SET @reportName = 'Experience Rating';
SET @SurveyName = 'Cellphone Banking';






SELECT 
   
   T0.C1 AS month,
   @reportName AS report_name,
   @projectName AS project,
   IFNULL(T0.C3,0) AS "Total Number of Escalations",
   IFNULL(T1.C6,0) AS 'Resolved',
   IFNULL((T2.C9/T0.C3)*100,0) AS 'Resolution Rate',
   IFNULL(T3.C12,0) AS Pending,
   IFNULL(T4.C15,0) AS Open,
   IFNULL(T5.C18,0) AS Unresolved,
   IFNULL(T6.C21,0) AS Reassigned,
   IFNULL(T7.C24,0) AS 'Re-Escalated',
   IFNULL((T7.C24/T0.C3)*100,0) AS 'Re-Escalation Rate'
FROM (
   SELECT 
      LAST_DAY(Fact_Escalation.DateTime_Start) AS C1,
      COUNT(Fact_Escalation.Escalation_ID) AS C3
   FROM Fact_Escalation
   INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   WHERE 
	   DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
	   AND Dim_Survey.Survey_Name = @SurveyName
	   
   GROUP BY  LAST_DAY(Fact_Escalation.DateTime_Start) 
      
) T0 


LEFT OUTER JOIN (
   SELECT 
      LAST_DAY(Fact_Escalation.DateTime_Start) AS C4,
      COUNT(Fact_Escalation.Escalation_ID) AS C6
   FROM Fact_Escalation
   INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)
   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name IN ('Resolved')
   )
   GROUP BY 
      LAST_DAY(Fact_Escalation.DateTime_Start)

) T1
ON T0.C1 = T1.C4
LEFT OUTER JOIN (
   SELECT 
      LAST_DAY(Fact_Escalation.DateTime_Start) AS C7,
      COUNT(Fact_Escalation.Escalation_ID) AS C9
   FROM Fact_Escalation
	INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   	LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)
   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name IN ('Resolved')
   )
   GROUP BY LAST_DAY(Fact_Escalation.DateTime_Start)

) T2
ON T0.C1 = T2.C7
LEFT OUTER JOIN (
   SELECT 
      LAST_DAY(Fact_Escalation.DateTime_Start) AS C10,
      COUNT(Fact_Escalation.Escalation_ID) AS C12
   FROM Fact_Escalation
	INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   	LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)
   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name LIKE '%Pending%'
   )
   GROUP BY LAST_DAY(Fact_Escalation.DateTime_Start)

) T3
ON T0.C1 = T3.C10
LEFT OUTER JOIN (
   SELECT 
      LAST_DAY(Fact_Escalation.DateTime_Start) AS C13,
      COUNT(Fact_Escalation.Escalation_ID) AS C15
   FROM Fact_Escalation
	INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   	LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)

   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name = 'Open'
   )
   GROUP BY  LAST_DAY(Fact_Escalation.DateTime_Start)

) T4
ON T0.C1 = T4.C13
LEFT OUTER JOIN (
   SELECT 
       LAST_DAY(Fact_Escalation.DateTime_Start) AS C16,
      COUNT(Fact_Escalation.Escalation_ID) AS C18
   FROM Fact_Escalation
	INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   	LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)
   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name = 'Unresolved'
   )
   GROUP BY LAST_DAY(Fact_Escalation.DateTime_Start)

) T5
ON T0.C1 = T5.C16
LEFT OUTER JOIN (
   SELECT 
      LAST_DAY(Fact_Escalation.DateTime_Start) AS C19,
      COUNT(Fact_Escalation.Escalation_ID) AS C21
   FROM Fact_Escalation
   	INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   	LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)
   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name = 'Escalation Reassigned'
   )
       GROUP BY LAST_DAY(Fact_Escalation.DateTime_Start)

) T6
ON T0.C1 = T6.C19
LEFT OUTER JOIN (
   SELECT 
     LAST_DAY(Fact_Escalation.DateTime_Start) AS C22,
      COUNT(Fact_Escalation.Escalation_ID) AS C24
   FROM Fact_Escalation
  
 	INNER JOIN Dim_Survey ON (Fact_Escalation.Survey_ID = Dim_Survey.Survey_ID)
   	LEFT OUTER JOIN Dim_Status ON (Fact_Escalation.Status_ID_Escalation = Dim_Status.Status_ID)
   WHERE (
   	  DATE(Fact_Escalation.DateTime_Start) BETWEEN 
	  DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
	  AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
      AND Dim_Survey.Survey_Name = @SurveyName
      AND Dim_Status.Status_Name = 'Escalation Re-escalated'
   )
  
       GROUP BY LAST_DAY(Fact_Escalation.DateTime_Start)

) T7
ON T0.C1 = T7.C22
