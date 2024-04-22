-- 1: choose the database
use covid_19_db;

-- 2: WRITE QUERIES TO BRING IN THE DATASET FOR ANALYSIS FROM DEVICE
-- A. writing a query to import the covid_deaths table from device
DROP TABLE IF EXISTS covid_deaths;
CREATE TABLE covid_deaths(
	-- covid_deaths BIGINT AUTO_INCREMENT,
    covid_deaths_id BIGINT NOT NULL PRIMARY KEY,
    continent VARCHAR(50),
	location VARCHAR(50),
	`date` DATE,
	total_cases	BIGINT,
    new_cases BIGINT,
    total_deaths BIGINT,	
    new_deaths BIGINT,
    total_cases_per_million	DOUBLE,
    new_cases_per_million DOUBLE,
    total_deaths_per_million DOUBLE,
    new_deaths_per_million DOUBLE

);
-- C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\
LOAD DATA INFILE 'Uploads/covid_dataset/covid_deaths.csv' INTO TABLE covid_deaths
FIELDS TERMINATED BY ','
ENCLOSED BY "'"
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from covid_deaths;

-- B. writing a query to import the covid_vaccinations table from device
DROP TABLE IF EXISTS covid_vaccinations;
CREATE TABLE covid_vaccinations(
	covid_vaccination_id BIGINT NOT NULL PRIMARY KEY,
	covid_deaths_id BIGINT NOT NULL,
	continent VARCHAR(50),
	location VARCHAR(50),
	`date` DATE,
	total_vaccinations BIGINT,	
    people_vaccinated BIGINT,
	people_fully_vaccinated	BIGINT,
    total_boosters BIGINT ,
    new_vaccinations BIGINT,
    total_vaccinations_per_hundred BIGINT,
	people_vaccinated_per_hundred BIGINT,
	people_fully_vaccinated_per_hundred BIGINT,
	total_boosters_per_hundred BIGINT,
	FOREIGN KEY(covid_deaths_id) REFERENCES covid_deaths(covid_deaths_id)
);


LOAD DATA INFILE 'Uploads/covid_dataset/covid_vaccinations.csv' INTO TABLE covid_vaccinations
FIELDS TERMINATED BY ','
ENCLOSED BY "'"
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from covid_vaccinations;

-- C. writing a query to import the population_info_id table from device
DROP TABLE IF EXISTS population_info;
CREATE TABLE population_info(
population_info_id BIGINT NOT NULL PRIMARY KEY,
covid_deaths_id BIGINT NOT NULL,
continent VARCHAR(50),
location VARCHAR(50),
`date` DATE,
stringency_index DOUBLE,
population_density DOUBLE,
median_age FLOAT,
aged_65_older FLOAT,
aged_70_older FLOAT,
gdp_per_capita DOUBLE,
extreme_poverty DOUBLE,
cardiovasc_death_rate DOUBLE,
diabetes_prevalence FLOAT,
female_smokers FLOAT,
male_smokers FLOAT,
handwashing_facilities FLOAT,
hospital_beds_per_thousand FLOAT,
life_expectancy FLOAT,
human_development_index FLOAT,
population BIGINT
);


LOAD DATA INFILE 'Uploads/covid_dataset/population_info.csv' INTO TABLE population_info
FIELDS TERMINATED BY ','
ENCLOSED BY "'"
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from covid_vaccinations;

-- to see the location from where we can upload files from into sql
SHOW VARIABLES LIKE 'secure_file_priv';


