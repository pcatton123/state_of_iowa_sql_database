/* 
*****************************
ACTIVE_IOWA_BUSINESS_ENTITIES
*****************************
*/

/* Data Manipulation Statement (DMS) #1
I am going to delete all columns except for
ra_city and ra_state */
ALTER TABLE active_iowa_business_entities
DROP COLUMN registered_agent,
DROP COLUMN ra_address_1,
DROP COLUMN ra_address_2,
DROP COLUMN ra_zip,
DROP COLUMN home_office,
DROP COLUMN ho_address_1,
DROP COLUMN ho_address_2,
DROP COLUMN ho_city,
DROP COLUMN ho_state,
DROP COLUMN ho_zip,
DROP COLUMN ho_country,
DROP COLUMN ho_location;
/*  DMS #1 */

/* DMS #2 remove null rows from ra_location */
DELETE FROM active_iowa_business_entities
WHERE ra_location IS NULL;
/* DMS #2 */

/* DMS #3 remove null rows from ra_city */
DELETE FROM active_iowa_business_entities
WHERE ra_city IS NULL;
/* DMS #3 */

/* DMS #4 Change -~LIME-SPRINGS, to LIME SPRINGS */
UPDATE active_iowa_business_entities
SET ra_city = 'LIME SPRINGS'
WHERE ra_city = '-~LIME-SPRINGS,';

SELECT * FROM active_iowa_business_entities
WHERE ra_city  = 'LIME SPRINGS';
/* DMS #4 */

/* DMS #5 Change .WATERLOO to WATERLOO */
UPDATE active_iowa_business_entities
SET ra_city = 'WATERLOO'
WHERE ra_city = '.WATERLOO';

SELECT * FROM active_iowa_business_entities
WHERE ra_city  = 'WATERLOO';
/* DMS #5 */

/* Change /COUNCIL BLUFFS to COUNCIL BLUFFS */
UPDATE active_iowa_business_entities
SET ra_city = 'COUNCIL BLUFFS'
WHERE ra_city = '/COUNCIL BLUFFS';

SELECT * FROM active_iowa_business_entities
WHERE ra_city  = 'COUNCIL BLUFFS';
/* Change /COUNCIL BLUFFS to COUNCIL BLUFFS */

/* Change ACKELY to ACKLEY */
UPDATE active_iowa_business_entities
SET ra_city = 'ACKLEY'
WHERE ra_city = 'ACKELY';

SELECT * FROM active_iowa_business_entities
WHERE ra_city  = 'ACKLEY';
/* Change ACKELY to ACKLEY */

/* Change :LYTTON to LYTTON */
UPDATE active_iowa_business_entities
SET ra_city = 'LYTTON'
WHERE ra_city = ':LYTTON';

SELECT * FROM active_iowa_business_entities
WHERE ra_city  = 'LYTTON';
/* Change :LYTTON to LYTTON */

SELECT ra_city, COUNT(ra_city)
FROM active_iowa_business_entities
GROUP BY ra_city
ORDER BY ra_city;

SELECT * FROM active_iowa_business_entities
WHERE ra_city  = ':LYTTON';

SELECT legal_name, COUNT(legal_name)
FROM active_iowa_business_entities
GROUP BY legal_name
ORDER BY legal_name;

SELECT * FROM active_iowa_business_entities
WHERE legal_name IS NULL;

SELECT legal_name, COUNT(*) AS occurrence_count FROM active_iowa_business_entities
GROUP BY legal_name
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;

SELECT corporation_type, COUNT(corporation_type)
FROM active_iowa_business_entities
GROUP BY corporation_type
ORDER BY corporation_type;

SELECT * FROM active_iowa_business_entities
WHERE corporation_type IS NULL;

SELECT * FROM active_iowa_business_entities
WHERE effective_date IS NULL;

SELECT * FROM active_iowa_business_entities
WHERE ra_city IS NULL;

SELECT * FROM active_iowa_business_entities
WHERE ra_state IS NULL;

SELECT ra_state, COUNT(ra_state)
FROM active_iowa_business_entities
GROUP BY ra_state
ORDER BY ra_state;

SELECT * FROM active_iowa_business_entities
WHERE ra_location IS NULL;

SELECT ra_location, COUNT(ra_location)
FROM active_iowa_business_entities
GROUP BY ra_location
ORDER BY ra_location;

/* 
******************************
CITY_BUDGET_AND_ACTUAL_REVENUE
******************************
*/

/* DMS #6: drop gnis_feature_id, county_code, city_code */
ALTER TABLE city_budget_and_actual_revenue
DROP COLUMN gnis_feature_id,
DROP COLUMN county_code,
DROP COLUMN city_code;
/* DMS #6*/

/* DMS #7 remove null rows from actual */
DELETE FROM city_budget_and_actual_revenue
WHERE actual IS NULL;

SELECT * FROM city_budget_and_actual_revenue
WHERE actual IS NULL
ORDER BY fiscal_year;
/* DMS #7 */

SELECT record_key, COUNT(record_key)
FROM city_budget_and_actual_revenue
GROUP BY record_key
ORDER BY record_key;

SELECT * FROM city_budget_and_actual_revenue
WHERE record_key IS NULL;

SELECT fiscal_year, COUNT(fiscal_year)
FROM city_budget_and_actual_revenue
GROUP BY fiscal_year
ORDER BY fiscal_year;

SELECT * FROM city_budget_and_actual_revenue
WHERE fiscal_year IS NULL;

SELECT county, COUNT(county)
FROM city_budget_and_actual_revenue
GROUP BY county
ORDER BY county;

SELECT * FROM city_budget_and_actual_revenue
WHERE county IS NULL;

SELECT city, COUNT(city)
FROM city_budget_and_actual_revenue
GROUP BY city
ORDER BY city;

SELECT * FROM city_budget_and_actual_revenue
WHERE city IS NULL;

SELECT revenue_type, COUNT(revenue_type)
FROM city_budget_and_actual_revenue
GROUP BY revenue_type
ORDER BY revenue_type;

SELECT * FROM city_budget_and_actual_revenue
WHERE revenue_type IS NULL;

SELECT budget, COUNT(budget)
FROM city_budget_and_actual_revenue
GROUP BY budget
ORDER BY budget;

SELECT * FROM city_budget_and_actual_revenue
WHERE budget IS NULL;

SELECT actual, COUNT(actual)
FROM city_budget_and_actual_revenue
GROUP BY actual
ORDER BY actual;

SELECT * FROM city_budget_and_actual_revenue
WHERE actual IS NULL
ORDER BY fiscal_year;

SELECT primary_city_coordinates, COUNT(primary_city_coordinates)
FROM city_budget_and_actual_revenue
GROUP BY primary_city_coordinates
ORDER BY primary_city_coordinates;

SELECT * FROM city_budget_and_actual_revenue
WHERE primary_city_coordinates IS NULL;

/* 
*************************************************
Gross and Real Domestic Product for State of Iowa
*************************************************
*/

/* DMS #8: Change table_name to table_nomenclature */
ALTER TABLE gross_and_real_domestic_product_for_state_of_iowa
RENAME COLUMN table_name TO table_nomenclature;

SELECT table_nomenclature, COUNT(table_nomenclature)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY table_nomenclature
ORDER BY table_nomenclature;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE table_nomenclature IS NULL;
/* DMS #8: Change table_name to table_nomenclature */

/* DMS #9: Change value to value_amount */
ALTER TABLE gross_and_real_domestic_product_for_state_of_iowa
RENAME COLUMN value TO value_amount;

SELECT value_amount, COUNT(value_amount)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY value_amount
ORDER BY value_amount;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE value_amount IS NULL;
/* DMS #9: Change value to value_amount */

/* DMS #10: drop variable_code and table_code */
ALTER TABLE gross_and_real_domestic_product_for_state_of_iowa
DROP COLUMN variable_code,
DROP COLUMN table_code;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa;
/* DMS #10: drop variable_code and table_code*/

/* DMS #11: Change NA in industry to Per capita */
UPDATE gross_and_real_domestic_product_for_state_of_iowa
SET industry = 'Per capita'
WHERE industry = 'NA';

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE industry  = 'Per capita';
/* DMS #11: Change NA in industry to Per capita */

SELECT row_id, COUNT(row_id)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY row_id
ORDER BY row_id;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE row_id IS NULL;

SELECT variable, COUNT(variable)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY variable
ORDER BY variable;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE variable IS NULL;

SELECT industry, COUNT(industry)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY industry
ORDER BY industry;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE industry = 'NA';

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE industry IS NULL;

SELECT variable_unit, COUNT(variable_unit)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY variable_unit
ORDER BY variable_unit;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE variable_unit IS NULL;

SELECT period_type, COUNT(period_type)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY period_type
ORDER BY period_type;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE period_type IS NULL;

SELECT date, COUNT(date)
FROM gross_and_real_domestic_product_for_state_of_iowa
GROUP BY date
ORDER BY date;

SELECT * FROM gross_and_real_domestic_product_for_state_of_iowa
WHERE date IS NULL;

/* 
************************************
Insurance companies licensed in Iowa
************************************
*/

/* DMS #12: Change iowa_license_number to company_name */
ALTER TABLE insurance_companies_licensed_in_iowa
DROP CONSTRAINT insurance_companies_licensed_in_iowa_pkey;

ALTER TABLE insurance_companies_licensed_in_iowa
RENAME COLUMN temp_company_name TO company_name;

SELECT company_name, COUNT(company_name)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_name
ORDER BY company_name;
/* DMS #12: Change iowa_license_number to company_name */

/* DMS #13 Change company_name to company_type */
ALTER TABLE insurance_companies_licensed_in_iowa
RENAME COLUMN company_name TO company_type;

SELECT company_type, COUNT(iowa_license_number)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_type
ORDER BY company_type;
/* DMS #13 Change company_name to company_type */

/* DMS #14 Change company_type to naic_number */
ALTER TABLE insurance_companies_licensed_in_iowa
RENAME COLUMN company_type TO naic_number;

SELECT naic_number, COUNT(iowa_license_number)
FROM insurance_companies_licensed_in_iowa
GROUP BY naic_number
ORDER BY naic_number;
/* DMS #14 Change company_type to naic_number */

/* DMS #15 Change naic_number to iowa license_number */
ALTER TABLE insurance_companies_licensed_in_iowa
RENAME COLUMN naic_number TO iowa_license_number;

SELECT iowa_license_number, COUNT(iowa_license_number)
FROM insurance_companies_licensed_in_iowa
GROUP BY iowa_license_number
ORDER BY iowa_license_number;
/* DMS #15 Change naic_number to iowa license_number */

/* DMS #16: make iowa_license_number PK */
ALTER TABLE insurance_companies_licensed_in_iowa
ADD PRIMARY KEY (iowa_license_number);
/* DMS #16: make iowa_license_number PK */

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE iowa_license_number IS NULL;

SELECT company_name, COUNT(company_name)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_name
ORDER BY company_name;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_name IS NULL;

SELECT company_type, COUNT(company_type)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_type
ORDER BY company_type;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_type IS NULL;

SELECT naic_number, COUNT(naic_number)
FROM insurance_companies_licensed_in_iowa
GROUP BY naic_number
ORDER BY naic_number;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE naic_number IS NULL;

SELECT iowa_domiciled, COUNT(iowa_domiciled)
FROM insurance_companies_licensed_in_iowa
GROUP BY iowa_domiciled
ORDER BY iowa_domiciled;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE iowa_domiciled IS NULL;

SELECT company_address_1, COUNT(company_address_1)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_address_1
ORDER BY company_address_1;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_address_1 IS NULL;

SELECT company_address_2, COUNT(company_address_2)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_address_2
ORDER BY company_address_2;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_address_2 IS NULL;

SELECT company_city, COUNT(company_city)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_city
ORDER BY company_city;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_city IS NULL;

SELECT company_state, COUNT(company_state)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_state
ORDER BY company_state;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_state IS NULL;

SELECT company_zip, COUNT(company_zip)
FROM insurance_companies_licensed_in_iowa
GROUP BY company_zip
ORDER BY company_zip;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE company_zip IS NULL;

SELECT telephone, COUNT(telephone)
FROM insurance_companies_licensed_in_iowa
GROUP BY telephone
ORDER BY telephone;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE telephone IS NULL;

SELECT alternate_address_1, COUNT(alternate_address_1)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_address_1
ORDER BY alternate_address_1;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_address_1 IS NULL;

SELECT alternate_address_2, COUNT(alternate_address_2)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_address_2
ORDER BY alternate_address_2;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_address_2 IS NULL;

SELECT alternate_city, COUNT(alternate_city)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_city
ORDER BY alternate_city;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_city IS NULL;

SELECT alternate_state, COUNT(alternate_state)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_state
ORDER BY alternate_state;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_state IS NULL;

SELECT alternate_zip, COUNT(alternate_zip)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_zip
ORDER BY alternate_zip;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_zip IS NULL;

SELECT alternate_phone, COUNT(alternate_phone)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_phone
ORDER BY alternate_phone;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_phone IS NULL;

SELECT business_license_type, COUNT(business_license_type)
FROM insurance_companies_licensed_in_iowa
GROUP BY business_license_type
ORDER BY business_license_type;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE business_license_type IS NULL;

SELECT ownership_type, COUNT(ownership_type)
FROM insurance_companies_licensed_in_iowa
GROUP BY ownership_type
ORDER BY ownership_type;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE ownership_type IS NULL;

SELECT formerly_doing_business_as, COUNT(formerly_doing_business_as)
FROM insurance_companies_licensed_in_iowa
GROUP BY formerly_doing_business_as
ORDER BY formerly_doing_business_as;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE formerly_doing_business_as IS NULL;

SELECT primary_location, COUNT(primary_location)
FROM insurance_companies_licensed_in_iowa
GROUP BY primary_location
ORDER BY primary_location;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE primary_location IS NULL;

SELECT alternate_location, COUNT(alternate_location)
FROM insurance_companies_licensed_in_iowa
GROUP BY alternate_location
ORDER BY alternate_location;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE alternate_location IS NULL;

SELECT short_term_limited_duration_health_insurance, COUNT(short_term_limited_duration_health_insurance)
FROM insurance_companies_licensed_in_iowa
GROUP BY short_term_limited_duration_health_insurance
ORDER BY short_term_limited_duration_health_insurance;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE short_term_limited_duration_health_insurance IS NULL;

SELECT state_of_domicile, COUNT(state_of_domicile)
FROM insurance_companies_licensed_in_iowa
GROUP BY state_of_domicile
ORDER BY state_of_domicile;

SELECT * FROM insurance_companies_licensed_in_iowa
WHERE state_of_domicile IS NULL;

/* 
*********************************
Iowa Households by Household Type
*********************************
*/

/* DMS #17: Change type column to type_classifier */
ALTER TABLE iowa_households_by_household_type_acs
RENAME COLUMN type TO type_classifier;

SELECT type_classifier, COUNT(type_classifier)
FROM iowa_households_by_household_type_acs
GROUP BY type_classifier
ORDER BY type_classifier;
/* DMS #17: Change type column to type_classifier */

/* DMS #18: Change name column to location_name */
ALTER TABLE iowa_households_by_household_type_acs
RENAME COLUMN name TO location_name;

SELECT location_name, COUNT(location_name)
FROM iowa_households_by_household_type_acs
GROUP BY location_name
ORDER BY location_name;
/* DMS #18: Change name column to location_name */

/* DMS #19: Change name column to location_name */
ALTER TABLE iowa_households_by_household_type_acs
DROP COLUMN variable,
DROP COLUMN household_type;

SELECT * FROM iowa_households_by_household_type_acs;
/* DMS #19: Change name column to location_name */

/* DMS #20: Change variable_description column to household_type */
ALTER TABLE iowa_households_by_household_type_acs
RENAME COLUMN variable_description TO household_type;

SELECT household_type, COUNT(household_type)
FROM iowa_households_by_household_type_acs
GROUP BY household_type
ORDER BY household_type;
/* DMS #20: Change variable_description column to household_type */

/* DMS #21: Change location column to grid_coordinate */
ALTER TABLE iowa_households_by_household_type_acs
RENAME COLUMN location TO grid_coordinate;

SELECT grid_coordinate, COUNT(grid_coordinate)
FROM iowa_households_by_household_type_acs
GROUP BY grid_coordinate
ORDER BY grid_coordinate;
/* DMS #21: Change location column to grid_coordinate */

SELECT row_id, COUNT(row_id)
FROM iowa_households_by_household_type_acs
GROUP BY row_id
ORDER BY row_id;

SELECT * FROM iowa_households_by_household_type_acs
WHERE row_id IS NULL;

SELECT geography_id, COUNT(geography_id)
FROM iowa_households_by_household_type_acs
GROUP BY geography_id
ORDER BY geography_id;

SELECT * FROM iowa_households_by_household_type_acs
WHERE geography_id IS NULL;

SELECT data_collection_period, COUNT(data_collection_period)
FROM iowa_households_by_household_type_acs
GROUP BY data_collection_period
ORDER BY data_collection_period;

SELECT * FROM iowa_households_by_household_type_acs
WHERE data_collection_period IS NULL;

SELECT data_collection_end_date, COUNT(data_collection_end_date)
FROM iowa_households_by_household_type_acs
GROUP BY data_collection_end_date
ORDER BY data_collection_end_date;

SELECT * FROM iowa_households_by_household_type_acs
WHERE data_collection_end_date IS NULL;

SELECT household_type, COUNT(household_type)
FROM iowa_households_by_household_type_acs
GROUP BY household_type
ORDER BY household_type;

SELECT * FROM iowa_households_by_household_type_acs
WHERE household_type IS NULL;

SELECT households, COUNT(households)
FROM iowa_households_by_household_type_acs
GROUP BY households
ORDER BY households;

SELECT * FROM iowa_households_by_household_type_acs
WHERE households IS NULL;

/* 
*****************
Iowa Liquor Stores
*****************
*/

/* 
******************
Iowa Liqour Stores
******************
*/

/* DMS #22: Change name to store_name */
ALTER TABLE iowa_liquor_stores
RENAME COLUMN name TO store_name;

SELECT store_name, COUNT(store_name)
FROM iowa_liquor_stores
GROUP BY store_name
ORDER BY store_name;
/* DMS #22: Change name to store_name */

/* DMS #23: Change state to store_state */
ALTER TABLE iowa_liquor_stores
RENAME COLUMN state TO store_state;

SELECT store_state, COUNT(store_state)
FROM iowa_liquor_stores
GROUP BY store_state
ORDER BY store_state;
/* DMS #23: Change state to store_state */

/* DMS #24: Change state to store_state */
ALTER TABLE iowa_liquor_stores
DROP COLUMN address,
DROP COLUMN store_address;

SELECT * FROM iowa_liquor_stores;
/* DMS #24: Change state to store_state */

/* DMS #25: Change ARNOLD'S PARK to ARNOLDS PARK */
UPDATE iowa_liquor_stores
SET city = 'ARNOLDS PARK'
WHERE city = 'ARNOLD''S PARK';

SELECT * FROM iowa_liquor_stores
WHERE city = 'ARNOLDS PARK';
/* DMS #25: Change ARNOLD'S PARK to ARNOLDS PARK */

/* DMS #26: Change ARNOLD'S PARK to ARNOLDS PARK */
UPDATE iowa_liquor_stores
SET city = 'CLEAR LAKE'
WHERE city = 'CLEARLAKE';

SELECT * FROM iowa_liquor_stores
WHERE city = 'CLEAR LAKE';
/* DMS #26: Change ARNOLD'S PARK to ARNOLDS PARK */

SELECT store, COUNT(store)
FROM iowa_liquor_stores
GROUP BY store
ORDER BY store;

SELECT * FROM iowa_liquor_stores
WHERE store IS NULL;

SELECT store_status, COUNT(store_status)
FROM iowa_liquor_stores
GROUP BY store_status
ORDER BY store_status;

SELECT * FROM iowa_liquor_stores
WHERE store_status IS NULL;

SELECT city, COUNT(city)
FROM iowa_liquor_stores
GROUP BY city
ORDER BY city;

SELECT * FROM iowa_liquor_stores
WHERE city IS NULL;

SELECT zip_code, COUNT(zip_code)
FROM iowa_liquor_stores
GROUP BY zip_code
ORDER BY zip_code;

SELECT * FROM iowa_liquor_stores
WHERE zip_code IS NULL;

SELECT report_date, COUNT(report_date)
FROM iowa_liquor_stores
GROUP BY report_date
ORDER BY report_date;

SELECT * FROM iowa_liquor_stores
WHERE report_date IS NULL;

/*
*********************************
Iowa Population 16 Years and over
*********************************
*/

/* DMS #27: Change type column to type_classifier */
ALTER TABLE iowa_population_16_years_and_over_acs
RENAME COLUMN type TO type_classifier;

SELECT type_classifier, COUNT(type_classifier)
FROM iowa_population_16_years_and_over_acs
GROUP BY type_classifier
ORDER BY type_classifier;
/* DMS #27: Change type column to type_classifier */

/* DMS #28: Change type column to type_classifier */
ALTER TABLE iowa_population_16_years_and_over_acs
RENAME COLUMN name TO location_name;

SELECT location_name, COUNT(location_name)
FROM iowa_population_16_years_and_over_acs
GROUP BY location_name
ORDER BY location_name;
/* DMS #28: Change type column to type_classifier */

/* DMS #29: Change type column to type_classifier */
ALTER TABLE iowa_population_16_years_and_over_acs
DROP COLUMN variable,
DROP COLUMN variable_description;

SELECT * FROM iowa_population_16_years_and_over_acs;
/* DMS #29: Change type column to type_classifier */

/* DMS #30: Change both to total in sex column */
UPDATE iowa_population_16_years_and_over_acs
SET sex = 'Total'
WHERE sex = 'Both';

SELECT sex, COUNT(sex)
FROM iowa_population_16_years_and_over_acs
GROUP BY sex
ORDER BY sex;
/* DMS #30: Change both to total in sex column  */

/* DMS #31: Change location column to grid_coordinate */
ALTER TABLE iowa_population_16_years_and_over_acs
RENAME COLUMN location TO grid_coordinate;

SELECT grid_coordinate, COUNT(grid_coordinate)
FROM iowa_population_16_years_and_over_acs
GROUP BY grid_coordinate
ORDER BY grid_coordinate;
/* DMS #31: Change location column to grid_coordinate */

SELECT row_id, COUNT(row_id)
FROM iowa_population_16_years_and_over_acs
GROUP BY row_id
ORDER BY row_id;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE row_id IS NULL;

SELECT geography_id, COUNT(geography_id)
FROM iowa_population_16_years_and_over_acs
GROUP BY geography_id
ORDER BY geography_id;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE geography_id IS NULL;

SELECT data_collection_period, COUNT(data_collection_period)
FROM iowa_population_16_years_and_over_acs
GROUP BY data_collection_period
ORDER BY data_collection_period;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE data_collection_period IS NULL;

SELECT data_collection_end_date, COUNT(data_collection_end_date)
FROM iowa_population_16_years_and_over_acs
GROUP BY data_collection_end_date
ORDER BY data_collection_end_date;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE data_collection_end_date IS NULL;

SELECT sex, COUNT(sex)
FROM iowa_population_16_years_and_over_acs
GROUP BY sex
ORDER BY sex;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE sex IS NULL;

SELECT age, COUNT(age)
FROM iowa_population_16_years_and_over_acs
GROUP BY age
ORDER BY age;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE age IS NULL;

SELECT employment_status, COUNT(employment_status)
FROM iowa_population_16_years_and_over_acs
GROUP BY employment_status
ORDER BY employment_status;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE employment_status IS NULL;

SELECT population_estimate, COUNT(population_estimate)
FROM iowa_population_16_years_and_over_acs
GROUP BY population_estimate
ORDER BY population_estimate;

SELECT * FROM iowa_population_16_years_and_over_acs
WHERE population_estimate IS NULL;

/*
***********************
Iowa Population by Race
***********************
*/

/* DMS #32: Change type column to type_classifier */
ALTER TABLE iowa_population_by_race_acs
RENAME COLUMN type TO type_classifier;

SELECT type_classifier, COUNT(type_classifier)
FROM iowa_population_by_race_acs
GROUP BY type_classifier
ORDER BY type_classifier;
/* DMS #32: Change type column to type_classifier */

/* DMS #33: Change type column to type_classifier */
ALTER TABLE iowa_population_by_race_acs
RENAME COLUMN name TO location_name;

SELECT location_name, COUNT(location_name)
FROM iowa_population_by_race_acs
GROUP BY location_name
ORDER BY location_name;
/* DMS #33: Change type column to type_classifier */

/* DMS #34: Change location column to grid_coordinate */
ALTER TABLE iowa_population_by_race_acs
RENAME COLUMN location TO grid_coordinate;

SELECT grid_coordinate, COUNT(grid_coordinate)
FROM iowa_population_by_race_acs
GROUP BY grid_coordinate
ORDER BY grid_coordinate;
/* DMS #34: Change location column to grid_coordinate */

SELECT geography_id, COUNT(geography_id)
FROM iowa_population_by_race_acs
GROUP BY geography_id
ORDER BY geography_id;

SELECT * FROM iowa_population_by_race_acs
WHERE geography_id IS NULL;

SELECT data_collection_period, COUNT(data_collection_period)
FROM iowa_population_by_race_acs
GROUP BY data_collection_period
ORDER BY data_collection_period;

SELECT * FROM iowa_population_by_race_acs
WHERE data_collection_period IS NULL;

SELECT race, COUNT(race)
FROM iowa_population_by_race_acs
GROUP BY race
ORDER BY race;

SELECT * FROM iowa_population_by_race_acs
WHERE race IS NULL;

SELECT variable, COUNT(variable)
FROM iowa_population_by_race_acs
GROUP BY variable
ORDER BY variable;

SELECT * FROM iowa_population_by_race_acs
WHERE variable IS NULL;

SELECT data_collection_end_date, COUNT(data_collection_end_date)
FROM iowa_population_by_race_acs
GROUP BY data_collection_end_date
ORDER BY data_collection_end_date;

SELECT * FROM iowa_population_by_race_acs
WHERE data_collection_end_date IS NULL;

SELECT population_estimate, COUNT(population_estimate)
FROM iowa_population_by_race_acs
GROUP BY population_estimate
ORDER BY population_estimate;

SELECT * FROM iowa_population_by_race_acs
WHERE population_estimate IS NULL;

SELECT change_rate, COUNT(change_rate)
FROM iowa_population_by_race_acs
GROUP BY change_rate
ORDER BY change_rate;

SELECT * FROM iowa_population_by_race_acs
WHERE change_rate IS NULL;

SELECT value_change, COUNT(value_change)
FROM iowa_population_by_race_acs
GROUP BY value_change
ORDER BY value_change;

SELECT * FROM iowa_population_by_race_acs
WHERE value_change IS NULL;

SELECT previous_data_collection_period, COUNT(previous_data_collection_period)
FROM iowa_population_by_race_acs
GROUP BY previous_data_collection_period
ORDER BY previous_data_collection_period;

SELECT * FROM iowa_population_by_race_acs
WHERE previous_data_collection_period IS NULL;

/*
****************************************************
Iowa property Casualty Insurance Premiums and losses
****************************************************
*/

/* DMS #35: Change year to calendar_year */
ALTER TABLE iowa_property_casualty_insurance_premiums_and_losses
DROP CONSTRAINT iowa_property_casualty_insurance_premiums_and_losses_pkey;

ALTER TABLE iowa_property_casualty_insurance_premiums_and_losses
RENAME COLUMN year TO calendar_year;

SELECT calendar_year, COUNT(calendar_year)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY calendar_year
ORDER BY calendar_year;
/* DMS #35: Change year to calendar_year */

/* DMS #36: Add new serial column for PK */
ALTER TABLE iowa_property_casualty_insurance_premiums_and_losses
ADD COLUMN serial_id SERIAL;

ALTER TABLE iowa_property_casualty_insurance_premiums_and_losses
ADD PRIMARY KEY (serial_id);

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses;
/* DMS #36: Add new serial column for PK */

/* DMS #37: Change state to state_abr */
ALTER TABLE iowa_property_casualty_insurance_premiums_and_losses
RENAME COLUMN state TO state_abr;

SELECT state_abr, COUNT(state_abr)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY state_abr
ORDER BY state_abr;
/* DMS #37: Change state to state_abr */

/* DMS #38: Drop iowa_chapter_code */
ALTER TABLE iowa_property_casualty_insurance_premiums_and_losses
DROP COLUMN iowa_chapter_code;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses;
/* DMS #38: Drop iowa_chapter_code */

SELECT line_of_insurance, COUNT(line_of_insurance)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY line_of_insurance
ORDER BY line_of_insurance;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE line_of_insurance IS NULL;

SELECT naic_number, COUNT(naic_number)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY naic_number
ORDER BY naic_number;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE naic_number IS NULL;

SELECT company_name, COUNT(company_name)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY company_name
ORDER BY company_name;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE company_name IS NULL;

SELECT premiums_written, COUNT(premiums_written)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY premiums_written
ORDER BY premiums_written;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE premiums_written IS NULL;

SELECT losses_paid, COUNT(losses_paid)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY losses_paid
ORDER BY losses_paid;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE losses_paid IS NULL;

SELECT taxes_paid, COUNT(taxes_paid)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY taxes_paid
ORDER BY taxes_paid;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE taxes_paid IS NULL;

SELECT iowa_company_code, COUNT(iowa_company_code)
FROM iowa_property_casualty_insurance_premiums_and_losses
GROUP BY iowa_company_code
ORDER BY iowa_company_code;

SELECT * FROM iowa_property_casualty_insurance_premiums_and_losses
WHERE iowa_company_code IS NULL;

/*
************************************
Math and Reading Proficiency in Iowa
************************************
*/

/* DMS #39: Update id to serial_id */
ALTER TABLE math_and_reading_proficiency_in_iowa
DROP CONSTRAINT math_and_reading_proficiency_in_iowa_pkey;

ALTER TABLE math_and_reading_proficiency_in_iowa
RENAME COLUMN id TO serial_id;

ALTER TABLE math_and_reading_proficiency_in_iowa
ADD PRIMARY KEY (serial_id);

SELECT * FROM math_and_reading_proficiency_in_iowa;
/* DMS #39: Update id to serial_id */

/* DMS #40: Drop district_office_location */
ALTER TABLE math_and_reading_proficiency_in_iowa
DROP COLUMN district_office_location;

SELECT * FROM math_and_reading_proficiency_in_iowa;
/* DMS #40: Drop district_office_location */

/* DMS #41: Drop null values in percent_proficient */
DELETE FROM math_and_reading_proficiency_in_iowa
WHERE percent_proficient IS NULL;

SELECT percent_proficient, COUNT(percent_proficient)
FROM math_and_reading_proficiency_in_iowa
GROUP BY percent_proficient
ORDER BY percent_proficient;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE percent_proficient IS NULL;
/* DMS #41: Drop null values in percent_proficient */
SELECT school_year, COUNT(school_year)
FROM math_and_reading_proficiency_in_iowa
GROUP BY school_year
ORDER BY school_year;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE school_year IS NULL;

SELECT grade, COUNT(grade)
FROM math_and_reading_proficiency_in_iowa
GROUP BY grade
ORDER BY grade;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE grade IS NULL;

SELECT district, COUNT(district)
FROM math_and_reading_proficiency_in_iowa
GROUP BY district
ORDER BY district;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE district IS NULL;

SELECT topic, COUNT(topic)
FROM math_and_reading_proficiency_in_iowa
GROUP BY topic
ORDER BY topic;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE topic IS NULL;

SELECT district_name, COUNT(district_name)
FROM math_and_reading_proficiency_in_iowa
GROUP BY district_name
ORDER BY district_name;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE district_name IS NULL;

SELECT proficient, COUNT(proficient)
FROM math_and_reading_proficiency_in_iowa
GROUP BY proficient
ORDER BY proficient;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE proficient IS NULL;

SELECT total, COUNT(total)
FROM math_and_reading_proficiency_in_iowa
GROUP BY total
ORDER BY total;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE total IS NULL;

SELECT proficient_category, COUNT(proficient_category)
FROM math_and_reading_proficiency_in_iowa
GROUP BY proficient_category
ORDER BY proficient_category;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE proficient_category IS NULL;

SELECT district_office_location, COUNT(district_office_location)
FROM math_and_reading_proficiency_in_iowa
GROUP BY district_office_location
ORDER BY district_office_location;

SELECT * FROM math_and_reading_proficiency_in_iowa
WHERE district_office_location IS NULL;

/*
***************************************
Retail Sales Use Business Registrations
***************************************
*/