SELECT 
    LAST_DAY(Fact_Result.DateTime_Created_Result) AS date,
    CASE
        WHEN Fact_Result_Answer.Question_Name = 'The Banking App is available without interruptions, outages and system errors' THEN 'Banking App available without interruptions, outages and system errors'
        WHEN Fact_Result_Answer.Question_Name = 'Standard Bank communicates to me in time on matters relating to the Banking App' THEN 'Communicate regularly and on time'
        WHEN Fact_Result_Answer.Question_Name = 'It is easy to log in every time I want to use the Banking App' THEN 'Easy to access and log in'
        WHEN Fact_Result_Answer.Question_Name = 'It is easy to use and navigate through the Banking App' THEN 'Easy to use and navigate'
        WHEN Fact_Result_Answer.Question_Name = 'Messaging Services such as OTP and Transaction notifications are reliable' THEN 'Messaging services such as OTP and Transaction Notifications are reliable'
        WHEN Fact_Result_Answer.Question_Name = 'Having the confidence that my transactions are safe and secure' THEN 'Safe and Secure transactions'
    END AS attribute,
    'Banking App' AS project,
    'Participation Statistics: Channel Promise' AS report_name,
    
    total_count.total_count/AP_count.total_count AS value,
    0 AS sort_order
FROM Fact_Result_Answer 
INNER JOIN Fact_Result ON Fact_Result_Answer.Result_ID = Fact_Result.Result_ID
INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
INNER JOIN (
    SELECT 
    COUNT(Fact_Result.Result_ID) AS total_count
    FROM Fact_Result
    INNER JOIN Fact_Result_Answer on Fact_Result.Result_ID = Fact_Result_Answer.Result_ID 
    INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
    WHERE 
        DATE(Fact_Result.DateTime_Created_Result) BETWEEN 
        DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')  
        AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND  
        AND Dim_Survey.Survey_Name = 'Banking App v2'
        AND Fact_Result_Answer.Question_Name = 'Having the confidence that my transactions are safe and secure'
) AS total_count

INNER JOIN (
    SELECT 
    COUNT(Fact_Result.Result_ID) AS total_count
    FROM Fact_Result
    INNER JOIN Fact_Result_Answer on Fact_Result.Result_ID = Fact_Result_Answer.Result_ID 
    INNER JOIN Dim_Survey ON Fact_Result.Survey_ID = Dim_Survey.Survey_ID
    WHERE 
        DATE(Fact_Result.DateTime_Created_Result) BETWEEN 
        DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')  
        AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND  
        AND Dim_Survey.Survey_Name = 'Banking App v2'
        AND Fact_Result_Answer.Question_Name = 'Banking App v2 - Achieve Purpose'
) AS AP_count



WHERE 
    DATE(Fact_Result.DateTime_Created_Result) BETWEEN 
    DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01 00:00:00')  
    AND LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) + INTERVAL '23:59:59' HOUR_SECOND  
    AND Dim_Survey.Survey_Name = 'Banking App v2'
    AND Fact_Result_Answer.Question_Name IN (
        'Having the confidence that my transactions are safe and secure', 
        'It is easy to log in every time I want to use the Banking App', 
        'It is easy to use and navigate through the Banking App', 
        'Messaging Services such as OTP and Transaction notifications are reliable', 
        'Standard Bank communicates to me in time on matters relating to the Banking App',
        'The Banking App is available without interruptions, outages and system errors'
    )
GROUP BY 
    CASE
        WHEN Fact_Result_Answer.Question_Name = 'The Banking App is available without interruptions, outages and system errors' THEN 'Banking App available without interruptions, outages and system errors'
        WHEN Fact_Result_Answer.Question_Name = 'Standard Bank communicates to me in time on matters relating to the Banking App' THEN 'Communicate regularly and on time'
        WHEN Fact_Result_Answer.Question_Name = 'It is easy to log in every time I want to use the Banking App' THEN 'Easy to access and log in'
        WHEN Fact_Result_Answer.Question_Name = 'It is easy to use and navigate through the Banking App' THEN 'Easy to use and navigate'
        WHEN Fact_Result_Answer.Question_Name = 'Messaging Services such as OTP and Transaction notifications are reliable' THEN 'Messaging services such as OTP and Transaction Notifications are reliable'
        WHEN Fact_Result_Answer.Question_Name = 'Having the confidence that my transactions are safe and secure' THEN 'Safe and Secure transactions'
    END,
    LAST_DAY(Fact_Result.DateTime_Created_Result);
