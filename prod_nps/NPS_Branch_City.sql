


   SELECT 
      LAST_DAY(`Fact_Result`.`DateTime_Created_Result`) AS date,
      'Branch' AS project,
      CASE
         WHEN 1 = 0 THEN CAST( `DIM_RE_GROUP`.`RE_Group_Name` AS char )
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Boland West Coast') THEN 'Boland West Coast'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:BUFFALO CITY') THEN 'Buffalo City'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Central Free State') THEN 'Central Free State'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:City And South') THEN 'City and South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Dolphin Coast') THEN 'Dolphin Coast'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Drakensberg') THEN 'Drakensberg'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Eastern Cape Province') THEN 'Eastern Cape'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Eastern Free State') THEN 'Eastern Free State'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW EKURHULENI CENTRAL') THEN 'Ekurhuleni Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW EKURHULENI NORTH') THEN 'Ekurhuleni North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW EKURHULENI SOUTH') THEN 'Ekurhuleni South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Ethekwini') THEN 'eThekwini'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Garden Route Karoo') THEN 'Garden Route Karoo'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Gauteng Province') THEN 'Gauteng'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Hibiscus Coast') THEN 'Hibiscus Coast'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:HIGHVELD') THEN 'Highveld'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW JHB CENTRAL') THEN 'Joburg Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW JHB SOUTH') THEN 'Joburg South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Klerksdorp') THEN 'Klerksdorp'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Kopano Central Province') THEN 'Kopano Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Kwazulu Natal Province') THEN 'KwaZulu Natal'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Limpopo Province') THEN 'Limpopo'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:LIMPOPO NORTH') THEN 'Limpopo North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:LIMPOPO SOUTH') THEN 'Limpopo South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:LOWVELD') THEN 'Lowveld'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW MOGALE') THEN 'Mogale'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Mpumalanga Province') THEN 'Mpumalanga'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Msunduzi') THEN 'Msunduzi'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:MTHATHA') THEN 'Mthatha'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:NELSON MANDELA BAY') THEN 'Nelson Mandela Bay'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('North West Province') THEN 'North West'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:NORTHERN CAPE') THEN 'Northern Cape'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Rustenburg') THEN 'Rustenburg'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:SARAH BAARTMAN') THEN 'Sarah Baartman'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW SOWETO') THEN 'Soweto'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:BUFFALO CITY', 'SLM:NELSON MANDELA BAY', 'SLM:SARAH BAARTMAN', 'SLM:MTHATHA') THEN 'Total Eastern Cape Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:GAUTENG NORTH CONSUMER') THEN 'Total Gauteng North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Northern Cape', 'SLM:CENTRAL FREE STATE', 'SLM:EASTERN FREE STATE') THEN 'Total Kopano Central Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:KZN') THEN 'Total KwaZulu Natal Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:LIMPOPO NORTH', 'SLM:LIMPOPO SOUTH') THEN 'Total Limpopo Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:LOWVELD', 'SLM:HIGHVELD') THEN 'Total Mpumalanga Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:RUSTENBURG', 'SLM:KLERKSDORP') THEN 'Total North West Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:COVERAGE WESTERN CAPE') THEN 'Total Western Cape Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW TSHWANE CENTRAL') THEN 'Tshwane Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW TSHWANE NORTH') THEN 'Tshwane North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW TSHWANE SOUTH') THEN 'Tshwane South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Tygerberg') THEN 'Tygerberg'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW VAAL') THEN 'Vaal'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Western Cape Province') THEN 'Western Cape'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Zululand') THEN 'Zululand'
         ELSE CAST( `DIM_RE_GROUP`.`RE_Group_Name` AS char )
      END AS attribute,
      COUNT(DISTINCT(`FACT_RESULT_ANSWER`.`Result_ID`)) AS count,
      (COUNT((CASE
         WHEN `FACT_RESULT_ANSWER`.`Answer_Numeric_Value` > 8.5 THEN 1
      END)) - COUNT((CASE
         WHEN `FACT_RESULT_ANSWER`.`Answer_Numeric_Value` < 6.5 THEN 1
      END))) / COUNT(DISTINCT(`FACT_RESULT_ANSWER`.`Result_ID`)) * 100 AS value
   FROM `Fact_Result`
   INNER JOIN `MT_RE_Group_RE_Agent` AS `MT_RE_GROUP_RE_AGENT`
   ON (
      `Fact_Result`.`RE_Agent_ID` = `MT_RE_GROUP_RE_AGENT`.`RE_Agent_ID`
   )
   INNER JOIN `Dim_RE_Group` AS `DIM_RE_GROUP`
   ON (
      `MT_RE_GROUP_RE_AGENT`.`RE_Group_ID` = `DIM_RE_GROUP`.`RE_Group_ID`
   )
   INNER JOIN `Fact_Result_Answer` AS `FACT_RESULT_ANSWER`
   ON (
      `FACT_RESULT_ANSWER`.`Result_ID` = `Fact_Result`.`Result_ID`
   )
   INNER JOIN `Dim_Question` AS `DIM_QUESTION`
   ON (
      `FACT_RESULT_ANSWER`.`Question_ID` = `DIM_QUESTION`.`Question_ID`
   )
   INNER JOIN `Dim_Survey` AS `DIM_SURVEY`
   ON (
      `Fact_Result`.`Survey_ID` = `DIM_SURVEY`.`Survey_ID`
   )
   WHERE (
      DATE(`Fact_Result`.`DateTime_Created_Result`) BETWEEN '2024-06-01' AND '2024-06-30'
      AND `DIM_SURVEY`.`Survey_Name` IN ('Standard Bank Branch SMS')
      AND `DIM_QUESTION`.`Question_Name` IN ('NPS Rating (0 - 10)')
      AND `DIM_RE_GROUP`.`RE_Group_Name` IN ('Eastern Cape Province', 'Gauteng Province', 'Kopano Central Province', 'Kwazulu Natal Province', 'LM:BUFFALO CITY', 'LM:CHNW EKURHULENI CENTRAL', 'LM:CHNW EKURHULENI NORTH', 'LM:CHNW EKURHULENI SOUTH', 'LM:CHNW JHB CENTRAL', 'LM:CHNW JHB SOUTH', 'LM:CHNW MOGALE', 'LM:CHNW SOWETO', 'LM:CHNW TSHWANE CENTRAL', 'LM:CHNW TSHWANE NORTH', 'LM:CHNW TSHWANE SOUTH', 'LM:CHNW VAAL', 'LM:HIGHVELD', 'LM:LIMPOPO NORTH', 'LM:LIMPOPO SOUTH', 'LM:LOWVELD', 'LM:MTHATHA', 'LM:NELSON MANDELA BAY', 'LM:SARAH BAARTMAN', 'Limpopo Province', 'Lm:Boland West Coast', 'Lm:Central Free State', 'Lm:City And South', 'Lm:Dolphin Coast', 'Lm:Drakensberg', 'Lm:Eastern Free State', 'Lm:Ethekwini', 'Lm:Garden Route Karoo', 'Lm:Hibiscus Coast', 'Lm:Klerksdorp', 'Lm:Msunduzi', 'Lm:Northern Cape', 'Lm:Rustenburg', 'Lm:Tygerberg', 'Lm:Zululand', 'Mpumalanga Province', 'North West Province', 'SLM:BUFFALO CITY', 'SLM:CENTRAL FREE STATE', 'SLM:COVERAGE WESTERN CAPE', 'SLM:EASTERN FREE STATE', 'SLM:GAUTENG NORTH CONSUMER', 'SLM:HIGHVELD', 'SLM:KLERKSDORP', 'SLM:KZN', 'SLM:LIMPOPO NORTH', 'SLM:LIMPOPO SOUTH', 'SLM:LOWVELD', 'SLM:MTHATHA', 'SLM:NELSON MANDELA BAY', 'SLM:NORTHERN CAPE', 'SLM:RUSTENBURG', 'SLM:SARAH BAARTMAN', 'Western Cape Province')
   )
   GROUP BY 
      CASE
         WHEN 1 = 0 THEN CAST( `DIM_RE_GROUP`.`RE_Group_Name` AS char )
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Boland West Coast') THEN 'Boland West Coast'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:BUFFALO CITY') THEN 'Buffalo City'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Central Free State') THEN 'Central Free State'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:City And South') THEN 'City and South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Dolphin Coast') THEN 'Dolphin Coast'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Drakensberg') THEN 'Drakensberg'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Eastern Cape Province') THEN 'Eastern Cape'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Eastern Free State') THEN 'Eastern Free State'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW EKURHULENI CENTRAL') THEN 'Ekurhuleni Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW EKURHULENI NORTH') THEN 'Ekurhuleni North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW EKURHULENI SOUTH') THEN 'Ekurhuleni South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Ethekwini') THEN 'eThekwini'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Garden Route Karoo') THEN 'Garden Route Karoo'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Gauteng Province') THEN 'Gauteng'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Hibiscus Coast') THEN 'Hibiscus Coast'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:HIGHVELD') THEN 'Highveld'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW JHB CENTRAL') THEN 'Joburg Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW JHB SOUTH') THEN 'Joburg South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Klerksdorp') THEN 'Klerksdorp'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Kopano Central Province') THEN 'Kopano Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Kwazulu Natal Province') THEN 'KwaZulu Natal'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Limpopo Province') THEN 'Limpopo'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:LIMPOPO NORTH') THEN 'Limpopo North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:LIMPOPO SOUTH') THEN 'Limpopo South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:LOWVELD') THEN 'Lowveld'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW MOGALE') THEN 'Mogale'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Mpumalanga Province') THEN 'Mpumalanga'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Msunduzi') THEN 'Msunduzi'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:MTHATHA') THEN 'Mthatha'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:NELSON MANDELA BAY') THEN 'Nelson Mandela Bay'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('North West Province') THEN 'North West'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:NORTHERN CAPE') THEN 'Northern Cape'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Rustenburg') THEN 'Rustenburg'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:SARAH BAARTMAN') THEN 'Sarah Baartman'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW SOWETO') THEN 'Soweto'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:BUFFALO CITY', 'SLM:NELSON MANDELA BAY', 'SLM:SARAH BAARTMAN', 'SLM:MTHATHA') THEN 'Total Eastern Cape Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:GAUTENG NORTH CONSUMER') THEN 'Total Gauteng North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Northern Cape', 'SLM:CENTRAL FREE STATE', 'SLM:EASTERN FREE STATE') THEN 'Total Kopano Central Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:KZN') THEN 'Total KwaZulu Natal Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:LIMPOPO NORTH', 'SLM:LIMPOPO SOUTH') THEN 'Total Limpopo Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:LOWVELD', 'SLM:HIGHVELD') THEN 'Total Mpumalanga Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:RUSTENBURG', 'SLM:KLERKSDORP') THEN 'Total North West Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('SLM:COVERAGE WESTERN CAPE') THEN 'Total Western Cape Province'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW TSHWANE CENTRAL') THEN 'Tshwane Central'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW TSHWANE NORTH') THEN 'Tshwane North'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW TSHWANE SOUTH') THEN 'Tshwane South'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Tygerberg') THEN 'Tygerberg'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('LM:CHNW VAAL') THEN 'Vaal'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Western Cape Province') THEN 'Western Cape'
         WHEN `DIM_RE_GROUP`.`RE_Group_Name` IN ('Lm:Zululand') THEN 'Zululand'
         ELSE CAST( `DIM_RE_GROUP`.`RE_Group_Name` AS char )
      END,
      CASE
         WHEN 1 = 0 THEN CAST( `DIM_SURVEY`.`Survey_Name` AS char )
         WHEN `DIM_SURVEY`.`Survey_Name` IN ('Standard Bank Branch SMS') THEN 'Branch'
         ELSE CAST( `DIM_SURVEY`.`Survey_Name` AS char )
      END,
      LAST_DAY(`Fact_Result`.`DateTime_Created_Result`),
      `DIM_QUESTION`.`Question_Name`


