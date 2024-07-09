-- Don't Parameterize 


SELECT 
   LAST_DAY(Fact_Result.DateTime_Created_Result) AS Date,
   CASE
      WHEN 1 = 0 THEN CAST( Fact_Result_Answer.Question_Name AS char )
      WHEN Fact_Result_Answer.Question_Name IN ('My account/s details on the site are correct') THEN 'Account/s details and information are correct'
      WHEN Fact_Result_Answer.Question_Name IN ('The Internet Banking platform is available without interruptions, outages and system errors', 'The Internet banking is available without interruptions, outages and system errors') THEN 'Internet Banking is available without interruptions. outages and system errors'
      WHEN Fact_Result_Answer.Question_Name IN ('Standard Bank communicates to me in time on matters relating to Internet Banking', 'Standard Bank communicates to me in time on matters relating to Internet banking') THEN 'Communicate regularly and on time'
      WHEN Fact_Result_Answer.Question_Name IN ('It is easy to log in every time I want to use the site', 'It is easy to log in every time I want to use Internet banking') THEN 'Easy to access and Log in'
      WHEN Fact_Result_Answer.Question_Name IN ('It is easy to use and navigate through the site', 'It is easy to use and navigate through the Internet banking') THEN 'Easy to use and navigate'
      WHEN Fact_Result_Answer.Question_Name IN ('Standard Bank immediately resolves any online related banking problems') THEN 'Immediately resolves Internet Banking problems'
      WHEN Fact_Result_Answer.Question_Name IN ('Messaging services such as OTPs and Transaction Notifications are reliable', 'Messaging Services such as OTP and Transaction notifications are reliable') THEN 'Messaging services such as OTPs and Transaction Notifications are reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('Having the confidence that my transactions are safe and secure') THEN 'Safe and Secure transactions'
      WHEN Fact_Result_Answer.Question_Name IN ('The Internet Banking is reliable') THEN 'Internet Banking is reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('My transactions are processed immediately') THEN 'Transaction are processed Immediately'
      ELSE CAST( Fact_Result_Answer.Question_Name AS char )
   END AS Attribute,
   'Channel Promise' AS project,
   'Internet Banking' AS report_name,
   AVG(Fact_Result_Answer.Answer_Numeric_Value) AS value,
   COUNT(DISTINCT(Fact_Result_Answer.Result_ID)),
   0
FROM Fact_Result_Answer
INNER JOIN Fact_Result
ON (
   Fact_Result_Answer.Result_ID = Fact_Result.Result_ID
)
INNER JOIN Dim_Survey 
ON (
   Fact_Result.Survey_ID = Dim_Survey.Survey_ID
)
WHERE (
   DATE(Fact_Result.DateTime_Created_Result) BETWEEN DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00') 
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND
   AND Dim_Survey.Survey_Name IN ('Internet Banking v2')
   AND Fact_Result_Answer.Question_Name IN ('Having the confidence that my transactions are safe and secure', 'It is easy to log in every time I want to use Internet banking', 'It is easy to use and navigate through the Internet banking', 'Messaging Services such as OTP and Transaction notifications are reliable', 'Standard Bank communicates to me in time on matters relating to Internet banking', 'The Internet banking is available without interruptions, outages and system errors')
)
GROUP BY 
   CASE
      WHEN 1 = 0 THEN CAST( Fact_Result_Answer.Question_Name AS char )
      WHEN Fact_Result_Answer.Question_Name IN ('My account/s details on the site are correct') THEN 'Account/s details and information are correct'
      WHEN Fact_Result_Answer.Question_Name IN ('The Internet Banking platform is available without interruptions, outages and system errors', 'The Internet banking is available without interruptions, outages and system errors') THEN 'Internet Banking is available without interruptions. outages and system errors'
      WHEN Fact_Result_Answer.Question_Name IN ('Standard Bank communicates to me in time on matters relating to Internet Banking', 'Standard Bank communicates to me in time on matters relating to Internet banking') THEN 'Communicate regularly and on time'
      WHEN Fact_Result_Answer.Question_Name IN ('It is easy to log in every time I want to use the site', 'It is easy to log in every time I want to use Internet banking') THEN 'Easy to access and Log in'
      WHEN Fact_Result_Answer.Question_Name IN ('It is easy to use and navigate through the site', 'It is easy to use and navigate through the Internet banking') THEN 'Easy to use and navigate'
      WHEN Fact_Result_Answer.Question_Name IN ('Standard Bank immediately resolves any online related banking problems') THEN 'Immediately resolves Internet Banking problems'
      WHEN Fact_Result_Answer.Question_Name IN ('Messaging services such as OTPs and Transaction Notifications are reliable', 'Messaging Services such as OTP and Transaction notifications are reliable') THEN 'Messaging services such as OTPs and Transaction Notifications are reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('Having the confidence that my transactions are safe and secure') THEN 'Safe and Secure transactions'
      WHEN Fact_Result_Answer.Question_Name IN ('The Internet Banking is reliable') THEN 'Internet Banking is reliable'
      WHEN Fact_Result_Answer.Question_Name IN ('My transactions are processed immediately') THEN 'Transaction are processed Immediately'
      ELSE CAST( Fact_Result_Answer.Question_Name AS char )
   END,
   LAST_DAY(Fact_Result.DateTime_Created_Result)
