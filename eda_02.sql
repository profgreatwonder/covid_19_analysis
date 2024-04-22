/*
	1. % of the population that got/died from covid
    2. the country(location) with the lowest and highest infection and death rate
    3. the continent with the lowest and highest infection and death rate
    4. comparing infection rate with the factors below by location
		a. stringency index
		b. population density
		c. population older than 65 years
		d. population older than 70 years
		e. handwashing facilities
		f. cardiovasc_death_rate
		g. human_development_index
		h. life_expectancy
		i. full vaccination
	5. comparing infection rate with the factors below by continent
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

SELECT * FROM covid_deaths;
SELECT * FROM covid_vaccinations;
SELECT * FROM population_info;

-- 1. % of the population that got/died from covid
DROP VIEW IF EXISTS infection_death_rate;
CREATE VIEW 
	infection_death_rate 
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS infection_death_rate_id, 
	cd.location, 
    cd.continent, 
    SUM(cd.total_cases) as total_cases, 
    SUM(cd.total_deaths) as total_deaths, 
    SUM(pi.population) as total_population,
	(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
    (SUM(cd.total_deaths) / SUM(pi.population)) * 100 AS death_rate,
    SUM(pi.population) - SUM(cd.total_cases) AS infected_population,
	SUM(pi.population) - SUM(cd.total_deaths) AS dead_population_no
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
ORDER BY
	infection_rate DESC;
    
-- 2. the country(location) with the lowest and highest infection and death rate -- resolve
DROP VIEW IF EXISTS min_max_location_view;
CREATE VIEW 
	min_max_location_view
AS
SELECT
	*
FROM
	(
		SELECT 
			location,
			MIN(infection_rate) AS min_infection_rate,
			MAX(infection_rate) AS max_infection_rate,
			MIN(death_rate) AS min_death_rate,
			MAX(death_rate) AS max_death_rate
		FROM 
			infection_death_rate
		GROUP BY location
    ) AS max_min_country
GROUP BY 
	location
ORDER BY
	max_infection_rate DESC;
select * from min_max_location_view;
    

-- 3. the continent with the lowest and highest infection and death rate
DROP VIEW IF EXISTS min_max_continent_view;
CREATE VIEW 
	min_max_continent_view
AS
SELECT
	*
FROM
	(
		SELECT 
			continent, 
			MAX(death_rate) AS max_death_rate,
			MIN(death_rate) AS min_death_rate,
			MAX(infection_rate) AS max_infection_rate,
			MIN(infection_rate) AS min_infection_rate,
            COUNT(DISTINCT location) AS country_count
		FROM 
			infection_death_rate
		GROUP BY 
			continent
    ) AS max_min_continent
ORDER BY
	max_death_rate DESC;

/*
4. comparing infection rate with the factors below by location
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
DROP VIEW IF EXISTS factors_by_location_view;
CREATE VIEW 
	factors_by_location_view
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY location) AS factors_by_location_view_id,
    cd.location, 
    SUM(cd.total_cases) as total_cases, 
	(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
	SUM(cd.total_deaths) as total_deaths, 
	(SUM(cd.total_deaths) / SUM(pi.population)) * 100 AS death_rate,
    SUM(pi.population) as total_population,
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
	location
ORDER BY
	infection_rate DESC;
    
/*
5. comparing infection rate with the factors below by continent
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

DROP VIEW IF EXISTS factors_by_continent_view;
CREATE VIEW 
	factors_by_continent_view
AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY continent) AS factors_by_continent_view_id,
    cd.continent, 
    COUNT(DISTINCT cd.location) as country_count,
	SUM(cd.total_cases) as total_cases, 
	(SUM(cd.total_cases) / SUM(pi.population)) * 100 AS infection_rate,
	SUM(cd.total_deaths) as total_deaths, 
	(SUM(cd.total_deaths) / SUM(pi.population)) * 100 AS death_rate,
	SUM(pi.population) as total_population,
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
	continent
ORDER BY
	death_rate DESC;