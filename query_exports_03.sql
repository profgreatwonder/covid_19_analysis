/*
exporting all tables out to a csv file for visualization in tableau
1. covid_deaths_view
2. covid_infection_view
3. factors_by_continent_death_view
4. factors_by_continent_infection_view
5. factors_by_location_death_view
6. factors_by_location_infection_view
7. min_max_continent_death_view
8. min_max_continent_infection_view
9. min_max_location_death_view
10. min_max_location_infection_view
*/

-- 1. covid_deaths_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/covid_deaths_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	covid_deaths_view;


-- 2. covid_infection_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/covid_infection_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	covid_infection_view;
 
 
-- 3. factors_by_continent_death_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/factors_by_continent_death_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	factors_by_continent_death_view;
    
    
-- 4. factors_by_continent_infection_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/factors_by_continent_infection_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	factors_by_continent_infection_view;
    
    
-- 5. factors_by_location_death_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/factors_by_location_death_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	factors_by_location_death_view;
    

-- 6. factors_by_location_infection_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/factors_by_location_infection_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	factors_by_location_infection_view;
    

-- 7. min_max_continent_death_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/min_max_continent_death_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	min_max_continent_death_view;
    
    
-- 8. min_max_continent_infection_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/min_max_continent_infection_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	min_max_continent_infection_view;
    
    
-- 9. min_max_location_death_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/min_max_location_death_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	min_max_location_death_view;
    
    
-- 10. min_max_location_infection_view
SELECT 
	*
INTO OUTFILE 
    'Uploads/covid_dataset/tables_from_sql_eda/min_max_location_infection_view.csv'
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM
	min_max_location_infection_view;
    