CREATE TABLE Active_Iowa_Business_Entities (
    Corp_Number VARCHAR PRIMARY KEY,
    Legal_Name VARCHAR,
    Corporation_Type VARCHAR,
    Effective_Date DATE,
    Registered_Agent VARCHAR,
    RA_Address_1 VARCHAR,
    RA_Address_2 VARCHAR,
    RA_City VARCHAR,
    RA_State VARCHAR,
    RA_Zip VARCHAR,
    Home_Office VARCHAR,
    HO_Address_1 VARCHAR,
    HO_Address_2 VARCHAR,
    HO_City VARCHAR,
    HO_State VARCHAR,
    HO_Zip VARCHAR,
    HO_Country VARCHAR,
    RA_Location VARCHAR,
    HO_Location VARCHAR
);

COPY Active_Iowa_Business_Entities
FROM '/Users/Public/Active_Iowa_Business_Entities.csv'
WITH (FORMAT CSV,HEADER)

CREATE TABLE City_Budget_and_Actual_Revenue (
    Record_Key VARCHAR PRIMARY KEY,
    Fiscal_Year INT,
    County_Code VARCHAR,
    County VARCHAR,
    GNIS_Feature_ID VARCHAR,
    City_Code VARCHAR,
    City VARCHAR,
    Revenue_Type VARCHAR,
    Budget NUMERIC,
    Actual NUMERIC,
    Primary_City_Coordinates VARCHAR
);

COPY City_Budget_and_Actual_Revenue
FROM '/Users/Public/City_Budget_and_Actual_Revenue.csv'
WITH (FORMAT CSV,HEADER)

CREATE TABLE Gross_and_Real_Domestic_Product_for_State_of_Iowa (
    Row_ID VARCHAR PRIMARY KEY,
    Table_Code VARCHAR,
    Table_Name VARCHAR,
    Variable_Code VARCHAR,
    Variable VARCHAR,
    Industry VARCHAR,
    Value NUMERIC,
    Variable_Unit VARCHAR,
    Period_Type VARCHAR,
    Date DATE
);

CREATE TABLE Insurance_Companies_Licensed_in_Iowa (
    Iowa_License_Number VARCHAR PRIMARY KEY,
    Company_Name VARCHAR,
    Company_Type VARCHAR,
    NAIC_Number VARCHAR, 
    Iowa_Domiciled BOOLEAN,
    Company_Address_1 VARCHAR,
    Company_Address_2 VARCHAR,
    Company_City VARCHAR,
    Company_State VARCHAR,
    Company_Zip VARCHAR,
    Telephone VARCHAR,
    Alternate_Address_1 VARCHAR,
    Alternate_Address_2 VARCHAR,
    Alternate_City VARCHAR,
    Alternate_State VARCHAR,
    Alternate_Zip VARCHAR,
    Alternate_Phone VARCHAR,
    Business_License_Type VARCHAR,
    Ownership_Type VARCHAR,
    Formerly_Doing_Business_As VARCHAR
);

ALTER TABLE Insurance_Companies_Licensed_in_Iowa 
ADD COLUMN Primary_Location VARCHAR,
ADD COLUMN Alternate_Location VARCHAR,
ADD COLUMN Short_Term_Limited_Duration_Health_Insurance VARCHAR,
ADD COLUMN State_of_Domicile VARCHAR;

ALTER TABLE insurance_companies_licensed_in_iowa
DROP CONSTRAINT insurance_companies_licensed_in_iowa_pkey;

ALTER TABLE insurance_companies_licensed_in_iowa
ADD PRIMARY KEY (naic_number, iowa_license_number);

CREATE TABLE Iowa_Households_by_Household_Type_ACS (
    Row_ID VARCHAR PRIMARY KEY,
    Geography_ID VARCHAR,
    Type VARCHAR,
    Name VARCHAR,
    Variable VARCHAR,
    Variable_Description VARCHAR,
    Data_Collection_Period VARCHAR,
    Data_Collection_End_Date DATE,
    Household_Type VARCHAR,
    Households INT,
    Location VARCHAR
);

CREATE TABLE Iowa_Liquor_Stores (
    Store INT PRIMARY KEY,
    Name VARCHAR,
    Store_Status VARCHAR,
    Address VARCHAR,
    City VARCHAR,
    State VARCHAR,
    Zip_Code VARCHAR,
    Store_Address VARCHAR,
    Report_Date DATE
);

CREATE TABLE Iowa_Liquor_Sales (
    Invoice_Item_Number VARCHAR PRIMARY KEY,
    Date DATE,
    Store_Number INT REFERENCES Iowa_Liquor_Stores(Store),
    Store_Name VARCHAR,
    Address VARCHAR,
    City VARCHAR,
    Zip_Code VARCHAR,
    Store_Location VARCHAR,
    County_Number VARCHAR,
    County VARCHAR,
    Category VARCHAR,
    Category_Name VARCHAR,
    Vendor_Number VARCHAR,
    Vendor_Name VARCHAR,
    Item_Number VARCHAR,
    Item_Description VARCHAR,
    Pack INT,
    Bottle_Volume_ml INT,
    State_Bottle_Cost NUMERIC,
    State_Bottle_Retail NUMERIC,
    Bottles_Sold INT,
    Sale_Dollars NUMERIC,
    Volume_Sold_Liters NUMERIC,
    Volume_Sold_Gallons NUMERIC
);

CREATE TABLE Iowa_Population_16_Years_and_Over_ACS (
    Row_ID VARCHAR PRIMARY KEY,
    Geography_ID VARCHAR,
    Type VARCHAR,
    Name VARCHAR,
    Variable VARCHAR,
    Variable_Description VARCHAR,
    Data_Collection_Period VARCHAR,
    Data_Collection_End_Date DATE,
    Sex VARCHAR,
    Age VARCHAR,
    Employment_Status VARCHAR,
    Population_Estimate INT,
    Location VARCHAR
);

CREATE TABLE Iowa_Population_by_Race_ACS (
    Geography_ID VARCHAR,
    Data_Collection_Period VARCHAR,
    Race VARCHAR,
    PRIMARY KEY (Geography_ID, Data_Collection_Period, Race),
    Type VARCHAR,
    Name VARCHAR,
    Variable VARCHAR,
    Data_Collection_End_Date DATE,
    Population_Estimate INT,
    Change_Rate NUMERIC,
    Value_Change INT,
    Location VARCHAR,
    Previous_Data_Collection_Period VARCHAR
);

CREATE TABLE Iowa_Property_Casualty_Insurance_Premiums_and_Losses (
    Year INT,
    Line_of_Insurance VARCHAR,
    NAIC_Number VARCHAR,
    PRIMARY KEY (Year, Line_of_Insurance, NAIC_Number),
    Iowa_Chapter_Code VARCHAR,
    State VARCHAR,
    Company_Name VARCHAR,
    Premiums_Written NUMERIC,
    Losses_Paid NUMERIC,
    Taxes_Paid NUMERIC,
    Iowa_Company_Code VARCHAR
);
/*
	Update Math and Reading PKEY
*/

ALTER TABLE Math_and_Reading_Proficiency_in_Iowa
DROP CONSTRAINT math_and_reading_proficiency_in_iowa_pkey;

ALTER TABLE Math_and_Reading_Proficiency_in_Iowa
ADD COLUMN id SERIAL PRIMARY KEY;

CREATE TABLE Math_And_Reading_Proficiency_in_Iowa (
    School_Year VARCHAR,
    Grade VARCHAR,
    District VARCHAR,
    PRIMARY KEY (School_Year, Grade, District),
    Topic VARCHAR,
    District_Name VARCHAR,
    Proficient INT,
    Total INT,
    Proficient_Category VARCHAR,
    District_Office_Location VARCHAR
);

ALTER TABLE Math_And_Reading_Proficiency_in_Iowa
ADD COLUMN Percent_Proficient NUMERIC(4,1);

/*
	Update Retail Sales PKEY
*/

ALTER TABLE Retail_Sales_and_Use_Business_Registrations
DROP CONSTRAINT Retail_Sales_and_Use_Business_Registrations_pkey;

ALTER TABLE Retail_Sales_and_Use_Business_Registrations
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE Retail_Sales_and_Use_Business_Registrations
ALTER COLUMN naics_code DROP NOT NULL;

ALTER TABLE Retail_Sales_and_Use_Business_Registrations
ALTER COLUMN Business_Zip_Code DROP NOT NULL;

CREATE TABLE Retail_Sales_and_Use_Business_Registrations (
    Retail_Permit_Number VARCHAR PRIMARY KEY,
    Active_or_Inactive_Business VARCHAR,
    Tax_Type VARCHAR,
    Consolidated_Number VARCHAR,
    Name_of_Business VARCHAR,
    Address_of_the_Business VARCHAR,
    State VARCHAR,
    County_Name VARCHAR,
    Registration_County_Number VARCHAR,
    Business_Location_County_Number VARCHAR,
    Department_City_Code VARCHAR,
    City_Location_of_Business VARCHAR,
    Business_Zip_Code VARCHAR,
    NAICS_Code VARCHAR,
    Description_of_NAICS VARCHAR,
    Date_Permit_Issued DATE,
    Date_Permit_Canceled DATE
);

COPY Gross_and_Real_Domestic_Product_for_State_of_Iowa
FROM '/Users/Public/Gross_and_Real_Gross_Domestic_Product_for_State_of_Iowa.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Gross_and_Real_Domestic_Product_for_State_of_Iowa;

COPY Insurance_Companies_Licensed_in_Iowa
FROM '/Users/Public/Insurance_Companies_Licensed_in_Iowa.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Insurance_Companies_Licensed_in_Iowa;

COPY Iowa_Households_by_Household_Type_ACS (
	geography_id,
    type,
    name,
    variable,
    variable_description,
    data_collection_period,
    data_collection_end_date,
    household_type,
    households,
    location,
    row_id
)
FROM '/Users/Public/Iowa_Households_by_Household_Type__ACS_5-Year_Estimates_.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Iowa_Households_by_Household_Type_ACS;

COPY Iowa_Liquor_Stores
FROM '/Users/Public/Iowa_Liquor_Stores.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Iowa_Liquor_Stores;

COPY Iowa_Liquor_Sales 
FROM '/Users/Public/Iowa_Liquor_Sales.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Iowa_Liquor_Sales;

/*
	store_number = 5284 present in Iowa_Liquor_Sales
	not in Iowa_liqour_Stores
	Dropping FKEY constraint
*/

ALTER TABLE iowa_liquor_sales
DROP CONSTRAINT iowa_liquor_sales_store_number_fkey;

COPY Iowa_Population_16_Years_and_Over_ACS (
    Geography_ID,
    Type,
    Name,
    Variable,
    Variable_Description,
    Data_Collection_Period,
    Data_Collection_End_Date,
    Sex,
    Age,
    Employment_Status,
    Population_Estimate,
    Location,
	Row_ID
)
FROM '/Users/Public/Iowa_Population_16_Years_and_Over_by_Sex__Age_and_Employment_Status__ACS_5-Year_Estimates_.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Iowa_Population_16_Years_and_Over_ACS;

COPY Iowa_Population_by_Race_ACS (
	Geography_ID,
	Type,
	Name,
    Variable,
    Data_Collection_Period,
    Data_Collection_End_Date,
	Race,
    Population_Estimate,
    Change_Rate,
    Value_Change,
    Location,
    Previous_Data_Collection_Period
)
FROM '/Users/Public/Iowa_Population_by_Race__ACS_5-Year_Estimates_.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Iowa_Population_by_Race_ACS;

COPY Iowa_Property_Casualty_Insurance_Premiums_and_Losses (
	Year,
	Iowa_Chapter_Code,
	State,
    Company_Name,
    Line_of_Insurance,
    Premiums_Written,
    Losses_Paid,
    Taxes_Paid,
	NAIC_Number,
    Iowa_Company_Code
)
FROM '/Users/Public/Iowa_Property_Casualty_Insurance_Premiums_and_Losses.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Iowa_Property_Casualty_Insurance_Premiums_and_Losses;

COPY Math_And_Reading_Proficiency_in_Iowa (
    School_Year,
	Topic,
    Grade,
    District,
    District_Name,
    Proficient,
    Total,
	Percent_Proficient,
    Proficient_Category,
    District_Office_Location
)
FROM '/Users/Public/Math_And_Reading_Proficiency_in_Iowa_by_School_Year__Public_School_District_and_Grade_Level.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Math_And_Reading_Proficiency_in_Iowa;

COPY Retail_Sales_and_Use_Business_Registrations (
    Active_or_Inactive_Business,
    Tax_Type,
	Retail_Permit_Number,
    Consolidated_Number,
    Name_of_Business,
    Address_of_the_Business,
    State,
    County_Name,
    Registration_County_Number,
    Business_Location_County_Number,
    Department_City_Code,
    City_Location_of_Business,
    Business_Zip_Code,
    NAICS_Code,
    Description_of_NAICS,
    Date_Permit_Issued,
    Date_Permit_Canceled
)
FROM '/Users/Public/Retail_Sales_and_Retail_Use_Business_Registrations.csv'
WITH (FORMAT CSV,HEADER);

SELECT * FROM Retail_Sales_and_Use_Business_Registrations;

SET enable_nestloop=0;SELECT 'postgresql' AS dbms,t.table_catalog,t.table_schema,t.table_name,c.column_name,c.ordinal_position,c.data_type,c.character_maximum_length,n.constraint_type,k2.table_schema,k2.table_name,k2.column_name FROM information_schema.tables t NATURAL LEFT JOIN information_schema.columns c LEFT JOIN(information_schema.key_column_usage k NATURAL JOIN information_schema.table_constraints n NATURAL LEFT JOIN information_schema.referential_constraints r)ON c.table_catalog=k.table_catalog AND c.table_schema=k.table_schema AND c.table_name=k.table_name AND c.column_name=k.column_name LEFT JOIN information_schema.key_column_usage k2 ON k.position_in_unique_constraint=k2.ordinal_position AND r.unique_constraint_catalog=k2.constraint_catalog AND r.unique_constraint_schema=k2.constraint_schema AND r.unique_constraint_name=k2.constraint_name WHERE t.TABLE_TYPE='BASE TABLE' AND t.table_schema NOT IN('information_schema','pg_catalog');