/*
1. % of the population that got covid by location and continent
2. % of the population that died from covid by location and continent
3. the country(location) with the lowest and highest infection rate
4. the continent with the lowest and highest death rate
5. the continent with the lowest and highest infection rate
6. the continent with the lowest and the highest death rate
7. what is the effect of the following factors on infection rate by location
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
8. what is the effect of the following factors on infection rate by continent
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
9. what is the effect of the following factors on death rate by location
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
10. what is the effect of the following factors on death rate by continent
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
*/

/*
COLUMNS TO RETURN FROM TABLES

a. covid_deaths
covid_deaths_id
continent
location
date
total_cases
total_deaths

b. covid_vaccination
covid_vaccination_id
continent
location
date
people_vaccinated
people_fully_vaccinated

c. population_info
population_info_id
continent
location
stringency_index
population_density
aged_65_older
aged_70_older
gdp_per_capita
cardiovasc_death_rate
handwashing_facilities
life_expectancy
human_development_index
population
*/

SELECT * FROM covid_deaths;
SELECT * FROM covid_vaccinations;
SELECT * FROM population_info;


-- 1. % of the population that got covid by location and continent
DROP VIEW IF EXISTS covid_infection_view;
CREATE VIEW 
	covid_infection_view 
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS covid_infection_view_id, 
	cd.location, 
    cd.continent, 
    SUM(cd.total_cases) as total_cases, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
    SUM(pi.population) - SUM(cd.total_cases) AS infected_population
FROM 
	covid_deaths cd
RIGHT JOIN 
	population_info pi
ON 
	cd.covid_deaths_id = pi.covid_deaths_id
WHERE 
	cd.total_cases <> 0 
AND 
	cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
AND 
	cd.continent NOT IN ('')
GROUP BY 
	cd.location, cd.continent;

/*
to get the total number of population, we group by death_rate - because it is a derived column, we have to use subqueries to get it.
turns out that we don't have to create a subquery since the calculation is straightforward but the learning here is that you cannot group by 
a derived column which in our case is columns from calculations
*/

/*
DROP VIEW IF EXISTS covid_infection_view;
CREATE VIEW covid_infection_view AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS covid_infection_view_id, 
	location, 
    continent, 
    total_cases, 
    population,
	infection_rate,
    infected_population
FROM 
	(
		SELECT
			cd.location, 
			cd.continent, 
			SUM(cd.total_cases) as total_cases, 
			SUM(pi.population) as total_population,
			(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
            SUM(pi.population) - SUM(cd.total_cases) AS infected_population
		FROM
			covid_deaths cd
		RIGHT JOIN 
			population_info pi
		ON 
			cd.covid_deaths_id = pi.covid_deaths_id
		WHERE 
			cd.total_cases <> 0 
		AND 
			cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
		AND 
			cd.continent NOT IN ('')
		GROUP BY 
			cd.location, cd.continent
) AS infection_data
GROUP BY 
	location, 
    continent, 
    total_cases, 
    population,
	infection_rate,
    infected_population;
    
select * from covid_infection_view;
*/


-- 2. % of the population that died from covid by location and continent
DROP VIEW IF EXISTS covid_deaths_view;
CREATE VIEW 
	covid_deaths_view 
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS covid_deaths_view_id, 
	cd.location, 
    cd.continent, 
    SUM(cd.total_deaths) as total_deaths, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_deaths) / SUM(pi.population)) * 100 AS death_rate,
    SUM(pi.population) - SUM(cd.total_deaths) AS dead_population_no
FROM 
	covid_deaths cd
RIGHT JOIN 
	population_info pi
ON 
	cd.covid_deaths_id = pi.covid_deaths_id
WHERE 
	cd.total_deaths <> 0 
AND 
	cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
AND 
	cd.continent NOT IN ('')
GROUP BY 
	cd.location, cd.continent;


-- 3. the country(location) with the lowest and highest infection rate -- resolve
DROP VIEW IF EXISTS min_max_location_infection_view;
CREATE VIEW 
	min_max_location_infection_view
AS
SELECT
	*
FROM
	(
		SELECT 
			location,
			MIN(infection_rate) AS min_infection_rate,
			MAX(infection_rate) AS max_infection_rate
		FROM 
			covid_infection_view
		GROUP BY location
    ) AS max_min_country
GROUP BY 
	location;

/*
minimum and max values are returning the same, why?
DROP VIEW IF EXISTS min_max_location_infection_vi;
CREATE VIEW 
	min_max_location_infection_vi
AS
SELECT
	*
FROM
	(
		SELECT 
			location,
			MIN(infection_rate) AS min_infection_rate
			-- MAX(infection_rate) AS max_infection_rate
		FROM 
			covid_infection_view
		GROUP BY location
    ) AS max_min_country
GROUP BY 
	location;
select * from min_max_location_infection_vi;
*/
 

-- 4. the continent with the lowest and highest infection rate
DROP VIEW IF EXISTS min_max_continent_infection_view;
CREATE VIEW 
	min_max_continent_infection_view
AS
SELECT
	*
FROM
	(
		SELECT 
			continent, 
			MAX(infection_rate) AS max_infection_rate,
			MIN(infection_rate) AS min_infection_rate,
            COUNT(DISTINCT location) AS country_count
		FROM 
			covid_infection_view
		GROUP BY 
			continent
    ) AS max_min_continent
GROUP BY 
	continent;

-- 5. the country with the lowest and the highest death rate ---- resolve
DROP VIEW IF EXISTS min_max_location_death_view;
CREATE VIEW 
	min_max_location_death_view
AS
SELECT
	*
FROM
	(
		SELECT 
			location,
			MIN(death_rate) AS min_death_rate,
			MAX(death_rate) AS max_death_rate
		FROM 
			covid_deaths_view
		GROUP BY 
			location
    ) AS max_min_country
GROUP BY
	location;
    
    
-- 6. the continent with the lowest and the highest death rate
DROP VIEW IF EXISTS min_max_continent_death_view;
CREATE VIEW 
	min_max_continent_death_view
AS
SELECT
	*
FROM
	(
		SELECT 
			continent, 
			MAX(death_rate) AS max_death_rate,
			MIN(death_rate) AS min_death_rate,
            COUNT(DISTINCT location) AS country_count
		FROM 
			covid_deaths_view
		GROUP BY 
			continent
    ) AS max_min_continent;
    
/*
7. what is the effect of the following factors on infection rate by location
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
*/
DROP VIEW IF EXISTS factors_by_location_infection_view;
CREATE VIEW 
	factors_by_location_infection_view
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS covid_infection_factors_id,
    cd.location, 
    SUM(cd.total_cases) as total_cases, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
    SUM(pi.stringency_index) AS sum_stringency_index, 
    SUM(pi.population_density) AS sum_population_density, 
    SUM(pi.aged_70_older) AS sum_aged_70_older, 
    SUM(pi.handwashing_facilities) AS sum_handwashing_facilities, 
    SUM(pi.cardiovasc_death_rate) AS sum_cardiovasc_death_rate, 
    SUM(pi.human_development_index) AS sum_human_development_index, 
    SUM(pi.life_expectancy) AS sum_life_expectancy, 
    SUM(cv.people_fully_vaccinated) AS sum_people_fully_vaccinated, 
    SUM(cv.total_vaccinations) AS sum_total_vaccinations,
    (SUM(cv.people_fully_vaccinated) / SUM(cv.total_vaccinations)) * 100 AS full_vaccination_rate
FROM 
	covid_deaths AS cd
RIGHT JOIN 
	population_info AS pi
ON 
	cd.covid_deaths_id = pi.covid_deaths_id
JOIN 
	covid_vaccinations AS cv
ON 
	pi.covid_deaths_id = cv.covid_deaths_id
WHERE 
	pi.population_density <> 0 
AND 
	cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
AND 
	cd.continent NOT IN ('')
GROUP BY 
	location;


/*
8. what is the effect of the following factors on infection rate by continent
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
*/
DROP VIEW IF EXISTS factors_by_continent_infection_view;
CREATE VIEW 
	factors_by_continent_infection_view
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY continent) AS covid_infection_factors_id,
    cd.continent, 
    COUNT(DISTINCT cd.location) as country_count,
    SUM(cd.total_cases) as total_cases, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
    SUM(pi.stringency_index) AS sum_stringency_index, 
    SUM(pi.population_density) AS sum_population_density, 
    SUM(pi.aged_70_older) AS sum_aged_70_older, 
    SUM(pi.handwashing_facilities) AS sum_handwashing_facilities, 
    SUM(pi.cardiovasc_death_rate) AS sum_cardiovasc_death_rate, 
    SUM(pi.human_development_index) AS sum_human_development_index, 
    SUM(pi.life_expectancy) AS sum_life_expectancy, 
    SUM(cv.people_fully_vaccinated) AS sum_people_fully_vaccinated, 
    SUM(cv.total_vaccinations) AS sum_total_vaccinations,
    (SUM(cv.people_fully_vaccinated) / SUM(cv.total_vaccinations)) * 100 AS full_vaccination_rate
FROM 
	covid_deaths AS cd
RIGHT JOIN 
	population_info AS pi
ON 
	cd.covid_deaths_id = pi.covid_deaths_id
JOIN 
	covid_vaccinations AS cv
ON 
	pi.covid_deaths_id = cv.covid_deaths_id
WHERE 
	pi.population_density <> 0 
AND 
	cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
AND 
	cd.continent NOT IN ('')
GROUP BY 
	continent;

/*
9. what is the effect of the following factors on death rate by location
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
*/
DROP VIEW IF EXISTS factors_by_location_death_view;
CREATE VIEW 
	factors_by_location_death_view
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS covid_death_factors_id,
    cd.location, 
    SUM(cd.total_cases) as total_cases, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_deaths) / SUM(pi.population)) * 100 AS infection_rate,
    SUM(pi.stringency_index) AS sum_stringency_index, 
    SUM(pi.population_density) AS sum_population_density, 
    SUM(pi.aged_70_older) AS sum_aged_70_older, 
    SUM(pi.handwashing_facilities) AS sum_handwashing_facilities, 
    SUM(pi.cardiovasc_death_rate) AS sum_cardiovasc_death_rate, 
    SUM(pi.human_development_index) AS sum_human_development_index, 
    SUM(pi.life_expectancy) AS sum_life_expectancy, 
    SUM(cv.people_fully_vaccinated) AS sum_people_fully_vaccinated, 
    SUM(cv.total_vaccinations) AS sum_total_vaccinations,
    (SUM(cv.people_fully_vaccinated) / SUM(cv.total_vaccinations)) * 100 AS full_vaccination_rate
FROM 
	covid_deaths AS cd
RIGHT JOIN 
	population_info AS pi
ON 
	cd.covid_deaths_id = pi.covid_deaths_id
JOIN 
	covid_vaccinations AS cv
ON 
	pi.covid_deaths_id = cv.covid_deaths_id
WHERE 
	pi.population_density <> 0 
AND 
	cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
AND 
	cd.continent NOT IN ('')	
GROUP BY 
	location;
    

/*
10. what is the effect of the following factors on death rate by continent
	a. stringency index
    b. population density
    c. population older than 65 years
    d. population older than 70 years
    e. handwashing facilities
    f. cardiovasc_death_rate
    g. human_development_index
    h. life_expectancy
    i. full vaccination
*/

DROP VIEW IF EXISTS factors_by_continent_death_view;
CREATE VIEW 
	factors_by_continent_death_view
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY continent) AS covid_death_factors_id,
    cd.continent, 
    COUNT(DISTINCT cd.location) as country_count,
    SUM(cd.total_cases) as total_cases, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_deaths) / SUM(pi.population)) * 100 AS infection_rate,
    SUM(pi.stringency_index) AS sum_stringency_index, 
    SUM(pi.population_density) AS sum_population_density, 
    SUM(pi.aged_70_older) AS sum_aged_70_older, 
    SUM(pi.handwashing_facilities) AS sum_handwashing_facilities, 
    SUM(pi.cardiovasc_death_rate) AS sum_cardiovasc_death_rate, 
    SUM(pi.human_development_index) AS sum_human_development_index, 
    SUM(pi.life_expectancy) AS sum_life_expectancy, 
    SUM(cv.people_fully_vaccinated) AS sum_people_fully_vaccinated, 
    SUM(cv.total_vaccinations) AS sum_total_vaccinations,
    (SUM(cv.people_fully_vaccinated) / SUM(cv.total_vaccinations)) * 100 AS full_vaccination_rate
FROM 
	covid_deaths AS cd
RIGHT JOIN 
	population_info AS pi
ON 
	cd.covid_deaths_id = pi.covid_deaths_id
JOIN 
	covid_vaccinations AS cv
ON 
	pi.covid_deaths_id = cv.covid_deaths_id
WHERE 
	pi.population_density <> 0 
AND 
	cd.location NOT IN ('Low income', 'Lower middle income', 'Reunion', 'High income', 'World', 'Africa', 'Europe', 'European Union')
AND 
	cd.continent NOT IN ('')	
GROUP BY 
	continent;