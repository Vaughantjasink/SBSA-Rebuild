-- Don't paramatise 


SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
   CASE
      WHEN 1 = 0 THEN CAST( Fact_Result_Answer.Question_Name AS char )
      WHEN Fact_Result_Answer.Question_Name IN ('Account/s details and information are correct on the site (Banking App)') THEN 'Account/s details and information are correct'
      WHEN Fact_Result_Answer.Question_Name IN ('Banking App available without interruptions, outages and system errors (Banking App)') THEN 'Banking App available without interruptions. outages and system errors'
      WHEN Fact_Result_Answer.Question_Name IN ('Communicate regularly and on time (Banking App)') THEN 'Communicate regularly and on time'
      WHEN Fact_Result_Answer.Question_Name IN ('Easy to access and log in (Banking App)') THEN 'Easy to access and Log in'
      WHEN Fact_Result_Answer.Question_Name IN ('Easy to use and navigate (Banking App)') THEN 'Easy to use and navigate'
      WHEN Fact_Result_Answer.Question_Name IN ('Immediately resolves banking app problems (Banking App)') THEN 'Immediately resolves banking app problems'
      WHEN Fact_Result_Answer.Question_Name IN ('Messaging services such as OTPs and Transaction Notifications are reliable') THEN 'Messaging services such as OTPs and Transaction Notifications are reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('Safe and secure transactions (Banking App)') THEN 'Safe and Secure transactions'
      WHEN Fact_Result_Answer.Question_Name IN ('The banking app is reliable (Banking App)') THEN 'Banking app is reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('Transactions are processed immediately (Banking App)') THEN 'Transaction are processed Immediately'
      ELSE CAST( Fact_Result_Answer.Question_Name AS char )
   END AS attribute,
   'Channel Promise' AS project,
   'Banking App' AS report_name,
   AVG(Fact_Result_Answer.Answer_Numeric_Value) as value,
   COUNT(Fact_Result.Result_ID) as count,
   0 as sort_order
FROM Fact_Result_Answer 
INNER JOIN Fact_Result ON (Fact_Result_Answer.Result_ID = Fact_Result.Result_ID)
INNER JOIN Dim_Survey ON (Fact_Result.Survey_ID = Dim_Survey.Survey_ID)
WHERE (
   DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN 
   DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')  
   AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND  
   AND Dim_Survey.Survey_Name = 'Banking App v2'
   AND Fact_Result_Answer.Question_Name IN ('Having the confidence that my transactions are safe and secure', 'It is easy to log in every time I want to use the Banking App', 'It is easy to use and navigate through the Banking App', 'Messaging Services such as OTP and Transaction notifications are reliable', 'Standard Bank communicates to me in time on matters relating to the Banking App', 'The Banking App is available without interruptions, outages and system errors')
)
GROUP BY 
   Dim_Survey.Survey_Name,
   CASE
      WHEN 1 = 0 THEN CAST( Fact_Result_Answer.Question_Name AS char )
      WHEN Fact_Result_Answer.Question_Name IN ('Account/s details and information are correct on the site (Banking App)') THEN 'Account/s details and information are correct'
      WHEN Fact_Result_Answer.Question_Name IN ('Banking App available without interruptions, outages and system errors (Banking App)') THEN 'Banking App available without interruptions. outages and system errors'
      WHEN Fact_Result_Answer.Question_Name IN ('Communicate regularly and on time (Banking App)') THEN 'Communicate regularly and on time'
      WHEN Fact_Result_Answer.Question_Name IN ('Easy to access and log in (Banking App)') THEN 'Easy to access and Log in'
      WHEN Fact_Result_Answer.Question_Name IN ('Easy to use and navigate (Banking App)') THEN 'Easy to use and navigate'
      WHEN Fact_Result_Answer.Question_Name IN ('Immediately resolves banking app problems (Banking App)') THEN 'Immediately resolves banking app problems'
      WHEN Fact_Result_Answer.Question_Name IN ('Messaging services such as OTPs and Transaction Notifications are reliable') THEN 'Messaging services such as OTPs and Transaction Notifications are reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('Safe and secure transactions (Banking App)') THEN 'Safe and Secure transactions'
      WHEN Fact_Result_Answer.Question_Name IN ('The banking app is reliable (Banking App)') THEN 'Banking app is reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('Transactions are processed immediately (Banking App)') THEN 'Transaction are processed Immediately'
      ELSE CAST( Fact_Result_Answer.Question_Name AS char )
   END,
   LAST_DAY(Fact_Result.DateTime_Created_Result)
