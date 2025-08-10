/* Q1 Household type by top 10 liqour sales cities 2019 */
SELECT 
    location_name,
    household_type,
    SUM(households) AS total_households
FROM iowa_households_by_household_type_acs
WHERE location_name IN (
        'Des Moines, Iowa', 
        'Cedar Rapids, Iowa', 
        'Davenport, Iowa', 
        'West Des Moines, Iowa', 
        'Waterloo, Iowa', 
        'Council Bluffs, Iowa', 
        'Sioux City, Iowa', 
        'Iowa City, Iowa', 
        'Dubuque, Iowa', 
        'Ames, Iowa'
    )
    AND data_collection_end_date = '2019-12-31'
    AND household_type IN ('Total', 'Family households', 'Nonfamily households')
GROUP BY location_name, household_type
ORDER BY location_name, household_type;
/* 
	This query provides the total number of households in 
	10 major Iowa cities for 2019, focusing on 'Total', 
	'Family', and 'Nonfamily' households. It offers insights 
	into household distribution in key urban areas. This data 
	helps assess social and economic trends in Iowa’s cities.
*/

/* Q2 Growth in active businesses */
SELECT 
    EXTRACT(YEAR FROM effective_date) AS year,
    COUNT(DISTINCT corp_number) AS active_businesses
FROM active_iowa_business_entities
WHERE ra_state = 'IA'
  AND effective_date IS NOT NULL
  AND EXTRACT(YEAR FROM effective_date) BETWEEN 2007 AND 2023
GROUP BY year
ORDER BY year;
/*
	This query shows the growth in businesses from the very first
	data was taken until the present. 
*/

/* Q3 Top 10 insurance companies by premiums written in 2019*/
SELECT 
    ipci.company_name, 
    SUM(ipci.premiums_written) AS total_premiums,
    SUM(ipci.losses_paid) AS total_losses,
    ici.Iowa_domiciled,
    ici.company_city,
    ici.company_state
FROM iowa_property_casualty_insurance_premiums_and_losses ipci
JOIN insurance_companies_licensed_in_Iowa ici
    ON ipci.company_name = ici.company_name
GROUP BY ipci.company_name, ici.Iowa_domiciled, ici.company_city, ici.company_state
ORDER BY total_premiums DESC
LIMIT 10;
/*
	This query identifies the top 10 insurance companies
	in Iowa in terms of premiums written in 2019. It helps 
	to see which companies are the largest players in the 
	state's insurance industry and whether or not they are
	headquatered in Iowa. This gives a snapshot of the health
	of the Iowa insurance industry.
*/

/* Q4 Insurance losses paid by company in 2019 */
SELECT 
    ipci.company_name, 
    SUM(ipci.losses_paid) AS total_losses,
    SUM(ipci.premiums_written) AS total_premiums,
    ici.Iowa_domiciled,
    ici.company_city,
    ici.company_state
FROM iowa_property_casualty_insurance_premiums_and_losses ipci
JOIN insurance_companies_licensed_in_Iowa ici
    ON ipci.company_name = ici.company_name
GROUP BY ipci.company_name, ici.Iowa_domiciled, ici.company_city, ici.company_state
ORDER BY total_losses DESC
LIMIT 10;
/* 
	This query identifies the top 10 companies by losses paid. 
	It provides insights into the insurance claims landscape 
	and helps to understand which sectors or companies have been 
	most affected by losses. Again, this shows another side of the 
	Iowa insurance industry health.
*/

/* Q5 Actual v. budgeted revenue for Iowa the 10 Iowa cities with the
	largest budgets*/
WITH top_cities AS (
    SELECT 
        city
    FROM city_budget_and_actual_revenue
    GROUP BY city
    ORDER BY SUM(budget) DESC
    LIMIT 10
)

SELECT 
    cab.city, 
    cab.fiscal_year,
    SUM(cab.budget) AS total_budget, 
    SUM(cab.actual) AS total_actual, 
    SUM(cab.actual) - SUM(cab.budget) AS revenue_difference
FROM city_budget_and_actual_revenue cab
WHERE cab.city IN (SELECT city FROM top_cities)
GROUP BY cab.city, cab.fiscal_year
ORDER BY cab.city, cab.fiscal_year;
/* 
	This query uses the budget_and_revenue table to demonstrate how 
	fiscally resposnsible the 10 cities in Iowa are that have the
	largest budgets. In terms of understanding the economics of
	a state it can be very helpful to understand how the 
	municipalities are spending their money, and if bigger is
	actually better or just continually leads to financial ruin.
*/

/* Q6 Actual v. budgeted revenue for smallest city budgets */
WITH bottom_cities AS (
    SELECT 
        city
    FROM city_budget_and_actual_revenue
    GROUP BY city
    ORDER BY SUM(budget) ASC
    LIMIT 10
)

SELECT 
    cab.city, 
    cab.fiscal_year,
    SUM(cab.budget) AS total_budget, 
    SUM(cab.actual) AS total_actual, 
    SUM(cab.actual) - SUM(cab.budget) AS revenue_difference
FROM city_budget_and_actual_revenue cab
WHERE cab.city IN (SELECT city FROM bottom_cities)
GROUP BY cab.city, cab.fiscal_year
ORDER BY cab.city, cab.fiscal_year;
/* 
	This is the converse of the previous query. It uses the same table 
	to show the budget and revnue changes of the smallest budgeted
	cities.
*/

/* Q7 Top 10 Iowa cities by liquor sales in 2019*/
SELECT 
    city, 
    SUM(sale_dollars) AS total_sales
FROM iowa_liquor_sales
WHERE EXTRACT(YEAR FROM date) = 2019
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;
/*
	This query identifies the top 10 cities with 
	the highest liquor sales in 2019. It can be used 
	to understand consumer spending patterns and economic 
	activity based on alcohol consumption.
*/

/* Q8 Top liquor sales cities 2019 populations */
SELECT 
    location_name,
    estimated_population
FROM (
    SELECT 
        location_name,
        SUM(population_estimate) AS estimated_population
    FROM iowa_population_by_race_acs
    WHERE (location_name LIKE '%Des Moines%' 
           OR location_name LIKE '%Cedar Rapids%' 
           OR location_name LIKE '%Davenport%' 
           OR location_name LIKE '%West Des Moines%' 
           OR location_name LIKE '%Waterloo%' 
           OR location_name LIKE '%Council Bluffs%' 
           OR location_name LIKE '%Sioux City%' 
           OR location_name LIKE '%Iowa City%' 
           OR location_name LIKE '%Dubuque%' 
           OR location_name LIKE '%Ames%')
      AND data_collection_end_date = '2019-12-31'
      AND location_name NOT LIKE '%Census Tract%'
	  AND location_name NOT LIKE '%County%'
    GROUP BY location_name
) AS city_population
ORDER BY estimated_population DESC;
/*  
	This query uses the names of the 10 cities with the 
	highest liquor sales and estimates their population from
	the poulation by race table. This meant to be a compliment to 
	the previous query to show liquor sales per capita. This is not 
	filtered by age, it is just meant to be used as a benchmark to 
	standardize the money values
*/

/* Q9 Bottom 10 Iowa cities by liquor sales in 2019*/
SELECT 
    city, 
    SUM(sale_dollars) AS total_sales
FROM iowa_liquor_sales
WHERE EXTRACT(YEAR FROM date) = 2019
GROUP BY city
ORDER BY total_sales
LIMIT 10;
/*
	Again, this is a converse example to the previous
	query. This indicates where the market is either limited
	or struggling.
*/

SELECT 
    location_name,
    estimated_population
FROM (
    SELECT 
        location_name,
        SUM(population_estimate) AS estimated_population
    FROM iowa_population_by_race_acs
    WHERE (location_name LIKE '%Bussey%' 
           OR location_name LIKE '%Washta%' 
           OR location_name LIKE '%Ireton%' 
           OR location_name LIKE '%Melbourne%' 
           OR location_name LIKE '%Morning Sun%' 
           OR location_name LIKE '%Rudd%' 
           OR location_name LIKE '%Hinton%' 
           OR location_name LIKE '%Delhi%' 
           OR location_name LIKE '%Ruthven%' 
           OR location_name LIKE '%Albert City%')
      AND data_collection_end_date = '2019-12-31'
      AND location_name NOT LIKE '%Census Tract%'
	  AND location_name NOT LIKE '%County%'
    GROUP BY location_name
) AS city_population
ORDER BY estimated_population DESC;
/* 
	This query uses the names of the 10 cities with the 
	lowest liquor sales and estimates their population from
	the poulation by race table. This meant to be a compliment to 
	the previous query to show liquor sales per capita. This is not 
	filtered by age, it is just meant to be used as a benchmark to 
	standardize the money values
*/

/* Q10 Houshold types and employment statuses across Iowa 2019 */
SELECT 
    hp.location_name AS location,
    ih.household_type,
    CASE 
        WHEN LOWER(hp.employment_status) LIKE '%employed%' THEN 'Employed'
        WHEN LOWER(hp.employment_status) LIKE '%unemployed%' THEN 'Unemployed'
        ELSE 'Not in Labor Force'
    END AS employment_group,
    SUM(ih.households) AS total_households
FROM iowa_population_16_years_and_over_acs hp
JOIN iowa_households_by_household_type_acs ih
    ON hp.type_classifier = ih.type_classifier
    AND hp.location_name = ih.location_name
WHERE hp.data_collection_end_date = '2019-12-31' 
  AND ih.data_collection_end_date = '2019-12-31'
GROUP BY hp.location_name, ih.household_type, employment_group
ORDER BY location, household_type, employment_group;
/*
	This query explores how household composition and employment 
	status are related across different Iowa communities. By linking 
	household structure data with workforce participation, we can 
	better understand socioeconomic patterns at the local level. 
	This insight is crucial for city planners, policymakers, and 
	businesses to design targeted programs — such as employment 
	initiatives, housing policies, and community services — that 
	meet the unique needs of Iowa's diverse households.
*/

/* Q11 City budget, revenue, and, and active businesses per city 2019 */
SELECT 
    cab.city,
    cab.total_budget,
    cab.total_actual_revenue,
    (
        SELECT COUNT(DISTINCT aibe.corp_number)
        FROM active_iowa_business_entities aibe
        WHERE LOWER(aibe.ra_city) = LOWER(cab.city)
          AND aibe.effective_date <= '2019-12-31'
    ) AS total_active_businesses
FROM (
    SELECT 
        city,
        SUM(budget) AS total_budget,
        SUM(actual) AS total_actual_revenue
    FROM city_budget_and_actual_revenue
    WHERE fiscal_year = 2019
    GROUP BY city
) AS cab
ORDER BY total_active_businesses DESC
LIMIT 10;
/* 
	This query calculates the total budget, actual revenue, 
	and active businesses for Iowa cities in 2019. It highlights 
	how cities are managing finances and business growth. Understanding 
	this helps assess local economic health and informs policy 
	decisions.
*/

/* Q12 State of Iowa GDP by year */
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    SUM(value_amount) AS total_gdp
FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE EXTRACT(YEAR FROM date) BETWEEN 2007 AND 2023
  AND industry = 'All industry total' 
GROUP BY year
ORDER BY year;

/* 
	This query sums Iowa’s GDP from 2007 to 2023, 
	tracking its economic performance over time. It reveals 
	trends in economic growth or contraction. Analyzing 
	this data provides insights into Iowa’s long-term economic 
	resilience and stability.
*/

/* Q13 Industry GDP */
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    industry, 
    SUM(value_amount) AS total_gdp
FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE EXTRACT(YEAR FROM date) BETWEEN 2007 AND 2023
  AND variable LIKE 'Gross domestic product (GDP) by state:%'
  AND industry IN ('Finance and insurance', 'Food services and drinking places')
GROUP BY year, industry
ORDER BY year, industry;
/* 
	This query examines the GDP of Iowa’s ‘Finance and insurance’ 
	and ‘Food services and drinking places’ industries from 2007 to 2023.
	It shows the economic contribution of key sectors. Understanding 
	this helps identify growth areas and areas needing policy attention.
*/

/* Q14 Average math and reading proficiency in Iowa */
SELECT 
    school_year,
    topic,
    ROUND(AVG(percent_proficient), 2) AS average_proficiency
FROM math_and_reading_proficiency_in_iowa
WHERE school_year BETWEEN '2007' AND '2017'
  AND topic IN ('Math', 'Reading')
GROUP BY school_year, topic
ORDER BY school_year, topic;
/*
	This query calculates the average math 
	and reading proficiency for Iowa students from 2007 to 2017. 
	It reflects the performance of the state’s education system. 
	Tracking proficiency trends helps identify areas for improvement 
	and prepare future workers.
*/

/* Q15 Math and reading by district in 2017 */
SELECT 
    mrd.district_name,
    ROUND(AVG(mrd.percent_proficient), 2) AS district_avg_proficiency,
    state_avg.state_avg_proficiency,
    ROUND(AVG(mrd.percent_proficient) - state_avg.state_avg_proficiency, 2) AS proficiency_difference
FROM math_and_reading_proficiency_in_iowa mrd
JOIN (
    SELECT 
        ROUND(AVG(percent_proficient), 2) AS state_avg_proficiency
    FROM math_and_reading_proficiency_in_iowa
    WHERE school_year = '2017'
      AND topic IN ('Math', 'Reading')
) AS state_avg
    ON 1 = 1  
WHERE mrd.school_year = '2017'
  AND mrd.topic IN ('Math', 'Reading')
GROUP BY mrd.district_name, state_avg.state_avg_proficiency
ORDER BY proficiency_difference DESC;
/*
	This query compares math and reading proficiency by district 
	to the state average in 2017. It highlights disparities in 
	educational outcomes. Identifying these differences helps 
	target resources to ensure equitable education across Iowa.
*/

/* Q16 Household type by 10 lowest liquor sales cities 2019 */
SELECT 
    location_name,
    household_type,
    SUM(households) AS total_households
FROM iowa_households_by_household_type_acs
WHERE location_name IN (
        'Bussey, Iowa', 
        'Washata, Iowa', 
        'Ireton, Iowa', 
        'Melbourne, Iowa', 
        'Morning Sun, Iowa', 
        'Rudd, Iowa', 
        'Hinton, Iowa', 
        'Delhi, Iowa', 
        'Ruthven, Iowa', 
        'Albert City, Iowa'
    )
    AND data_collection_end_date = '2019-12-31'
    AND household_type IN ('Total', 'Family households', 'Nonfamily households')
GROUP BY location_name, household_type
ORDER BY location_name, household_type;
/* 
	This query provides the total number of households in 
	Iowa cities for 2019 with the lowest liquor sales. It
	focuses on 'Total','Family', and 'Nonfamily' households. 
	It offers insights into household distribution in rural areas. 
	This data helps assess and can offer explainations in
	social and economic trends in Iowa’s cities.
*/