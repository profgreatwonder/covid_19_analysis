/*
exporting all tables out to a csv file for visualization in tableau
1. infection_death_rate
2. min_max_location_view
3. min_max_continent_view
4. factors_by_location_view
5. factors_by_continent_view
*/

-- 1. infection_death_rate
SELECT 
	*
FROM 
	infection_death_rate
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/infection_death_rate.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- 2. min_max_location_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/min_max_location_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	min_max_location_view;
 
 
-- 3. min_max_continent_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/min_max_continent_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	min_max_continent_view;
    
    
-- 4. factors_by_location_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/factors_by_location_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	factors_by_location_view;
    
    
-- 5. factors_by_continent_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/factors_by_continent_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	factors_by_continent_view;