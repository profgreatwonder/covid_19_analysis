# Understanding Covid-19 and its Prevailing Factors Between 2020 to 2024

## Documentation Table of Contents

- [Problem Statement](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#problem-statement)
- [Project Goal](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#project-goal)
- [Project and Dataset Description](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#project-and-dataset-description)
- [Links to Files and Visualization](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#links-to-files-and-visualization)
- [Project Todos](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#project-todos)
- [Software and Tools Used](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#software-and-tools)
- [Queries Used](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#queries-used)
- [Views Produced from Queries For Visualization](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#views-produced-from-queries-for-visualization)
- [Observations](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#observations)
- [Challenges](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#challenges)
- [Recommendations](https://github.com/profgreatwonder/covid_19_analysis/blob/master/README.md#recommendations)

## Problem Statement

Understanding Covid-19 and its Prevailing Factors Between 2020 to 2024.

## Project Goal

The goal for this project is to understand the factors that increased or reduced the spread of covid-19 for different countries and continents between 2020 and 2024.

#### Questions

The questions below will enable us achieve the project goal and inform how to formulate the queries

1. What country experienced the highest infection rate
2. What country experienced the highest death rate
3. What continent experienced the highest infection rate
4. What continent experienced the most death rate
5. How did the following factors affect infection and death rates by country and continent
   - stringency index
   - population density
   - population older than 70 years
   - handwashing facilities
   - cardiovasc death rate
   - human development index
   - life expectancy
   - full vaccination

## Project and Dataset Description

#### Visualization Description

The exported table was then imported into tableau and visualizations created. The data was visualized into 6 separate dashboards. Below are the list of the visualization dashboards

1. **Dashboard Homepage:** The other visualizations can be interacted with from the link - [Dashboard Link](https://public.tableau.com/app/profile/chidinma.esther.muoghalu/viz/Covid-19DataDashboard_17140585534110/DashboardHome)

2. **Global Numbers:** On this dashboard, we have one table and 2 bar charts present. The table showcases the global numbers per continent is provided, showcasing their total population, total cases, infected population, and total deaths. The 2 charts showcases the `Global Max Infection Rate`, and `Global Max Death Rate`.

3. **Map Viz:** This dashboard visualizes the `Location`, `Max Death Rate`, `Max Infected Rate`, `Infected Population`, `Total Deaths`, `Death Rate`, and `Avg. Infection Rate`. Below is the list of how to interact with this dashboard to show the different data vizualizations

- **on hover:** hovering over a country/location shows `Location`, `Max Death Rate`, `Max Infected Rate`, `Infected Population`, `Total Deaths`

- **on click:** clicking on a country/location displays a bar chart below the map, showing `Death Rate`, and `Avg. Infection Rate`

4. **Cases by Year by Country:** This dashboard visualizes `Total Cases` and `Total Deaths` by `country` or `location` and `date(year)` using line charts. A filter is added to this chart in order to keep things neat. Depending on the country (ies) selected, a line chart or series of line charts is displayed with the `Total Cases` and `Total Deaths` by `country` or `location` and `date(year)` for that country or set of countries.

5. **Cases by Year by Continent:** This dashboard has the same description and does the same functions as the previous dashboard. The difference is that it does it by `continent`.

6. **Factors by Country:** This dashboard is necessary in understanding how the factors provided in the dataset affected covid-19 by country either positively or negatively. This helps in understanding what covid-19 prevailing factors are by finding out which of the factors minimized covid-19 the most in different countries. The dashboard visualizes data using bar charts to compare the rate of infection against the factors contained in the table/view (factors_by_location_view.csv).

7. **Factors by Continent:** This dashboard does the exact same thing as the previous visualization but does it by continents with the data found in the table/view (factors_by_location_view.csv).

#### Split Dataset Description

The csv version of the full dataset was downloaded and split into 3 csv files - `covid_deaths`, `covid_vaccination`, and `population_info`. The split files were then loaded into MySQL workbench using a a query.

Below are the list of tables and their corresponding columns.

1. **covid_deaths:** This dataset contains data about the covid deaths. It has the following:

   - `covid_deaths_id` unique identifier for the table
   - `continent` continent of the geographical location
   - `location` geographical location
   - `date` date of observation
   - `total_cases` total confirmed cases of COVID-19. Counts can include probable cases, where reported.
   - `new_cases` new confirmed cases of COVID-19. Counts can include probable cases, where reported. In rare cases where our source reports a negative daily change due to a data correction, we set this metric to NA.
   - `total_deaths` total deaths attributed to COVID-19. Counts can include probable deaths, where reported.
   - `new_deaths` new deaths attributed to COVID-19. Counts can include probable deaths, where reported. In rare cases where our source reports a negative daily change due to a data correction, we set this metric to NA.
   - `total_cases_per_million` total confirmed cases of COVID-19 per 1,000,000 people. Counts can include probable cases, where reported.
   - `new_cases_per_million` new confirmed cases of COVID-19 per 1,000,000 people. Counts can include probable cases, where reported.
   - `total_deaths_per_million` total deaths attributed to COVID-19 per 1,000,000 people. Counts can include probable deaths, where reported.
   - `new_deaths_per_million` new deaths attributed to COVID-19 per 1,000,000 people. Counts can include probable deaths, where reported.

2. **covid_vaccination:** This dataset contains information about the covid vaccination. It has the following:

   - `covid_vaccination_id` unique identifier for the table
   - `covid_deaths_id`
   - `continent` continent of the geographical location
   - `location` geographical location
   - `date` date of observation
   - `total_vaccinations` total number of COVID-19 vaccination doses administered
   - `people_vaccinated` total number of people who received at least one vaccine dose
   - `people_fully_vaccinated` total number of people who received all doses prescribed by the initial vaccination protocol
   - `total_boosters` total number of COVID-19 vaccination booster doses administered (doses administered beyond the number prescribed by the vaccination protocol)
   - `new_vaccinations` new COVID-19 vaccination doses administered (only calculated for consecutive days)
   - `total_vaccinations_per_hundred` total number of COVID-19 vaccination doses administered per 100 people in the total population
   - `people_vaccinated_per_hundred` total number of people who received at least one vaccine dose per 100 people in the total population
   - `people_fully_vaccinated_per_hundred` total number of people who received all doses prescribed by the initial vaccination protocol per 100 people in the total population
   - `total_boosters_per_hundred` total number of COVID-19 vaccination booster doses administered per 100 people in the total population

3. **population_info:** This dataset contains information about the population. It has the following:

   - `population_info_id` unique identifier for the table
   - `covid_deaths_id`
   - `continent` continent of the geographical location
   - `location` geographical location
   - `date` date of observation
   - `stringency_index` government Response Stringency Index: composite measure based on 9 response indicators including school closures, workplace closures, and travel bans, rescaled to a value from 0 to 100 (100 = strictest response)
   - `population_density` number of people divided by land area, measured in square kilometers, most recent year available
   - `median_age` median age of the population, UN projection for 2020
   - `aged_65_older` share of the population that is 65 years and older, most recent year available
   - `aged_70_older` share of the population that is 70 years and older in 2015
   - `gdp_per_capita` gross domestic product at purchasing power parity (constant 2011 international dollars), most recent year available
   - `extreme_poverty` share of the population living in extreme poverty, most recent year available since 2010
   - `cardiovasc_death_rate` death rate from cardiovascular disease in 2017 (annual number of deaths per 100,000 people)
   - `diabetes_prevalence` diabetes prevalence (% of population aged 20 to 79) in 2017
   - `female_smokers` share of women who smoke, most recent year available
   - `male_smokers` share of men who smoke, most recent year available
   - `handwashing_facilities` share of the population with basic handwashing facilities on premises, most recent year available
   - `hospital_beds_per_thousand` hospital beds per 1,000 people, most recent year available since 2010
   - `life_expectancy` life expectancy at birth in 2019
   - `human_development_index` A composite index measuring average achievement in three basic dimensions of human development—a long and healthy life, knowledge and a decent standard of living. Values for 2019, imported from http://hdr.undp.org/en/indicators/137506
   - `population` Population (latest available values). See https://github.com/owid/covid-19-data/blob/master/scripts/input/un/population_latest.csv for full list of sources

#### Views from EDA Dataset Description

Exploratory Data Analysis (EDA) was then carried out on these tables and 5 new set of tables (views) were created - `infection_death_rate`, `min_max_location_view`, `min_max_continent_view`, `factors_by_location_view`, and `factors_by_continent_view`.

1. **infection_death_rate:** this table contains information about the total infection and death including their rate. The table was created by joining parts of `covid_deaths` and `population_info` table. The goal of this table was to give an insight into the global numbers.

   - `infection_death_rate_id` unique identifier for the table
   - `date` date of the sum of observation per country
   - `location` geographical location
   - `continent` continent of the geographical location
   - `total_cases` sum of total confirmed cases of COVID-19 grouped by location. Counts can include probable cases, where reported.
   - `total_deaths` sum of total deaths attributed to COVID-19 grouped by location. Counts can include probable deaths, where reported.
   - `total_population` sum of population (latest available values) grouped by location. See https://github.com/owid/covid-19-data/blob/master/scripts/input/un/population_latest.csv for full list of sources
   - `infection_rate` sum of total_cases divided by sum of population multiplied by 100 and grouped by location
   - `death_rate` sum of total_deaths divided by sum of population multiplied by 100 and grouped by location
   - `infected_population` sum of population minus the sum of total_cases
   - `dead_population_no` sum of population minus the sum of total_deaths

2. **min_max_location_view:** the purpose of this table is to provides us with an insight into the `maximum` and `minimum` infection and death rate of all the countries provided in the dataset. This view was created from the `infection` and `death` columns of the `infection_death_rate` view.

   - `min_infection_rate` the lowest infection rate by country
   - `max_infection_rate` the highest infection rate by country
   - `min_death_rate` the lowest death rate by country
   - `max_death_rate` the highest death rate by country

3. **min_max_continent_view:** just like the previous view/table, this view provides us with an insight into the `maximum` and `minimum` infection and death rate but this time, its for all the continents provided in the dataset. It was also created from the `infection` and `death` columns of the `infection_death_rate` view.

   - `min_infection_rate` the lowest infection rate by continent
   - `max_infection_rate` the highest infection rate by continent
   - `min_death_rate` the lowest death rate by continent
   - `max_death_rate` the highest death rate by continent

4. **factors_by_location_view:** this is a major view/table in understanding the prevailing factors surrounding covid-19 between 2020 to 2024 by country. This table was created from the join between some columns from `covid_deaths`, `population_info`, and `covid_vaccinations`.

   - `factors_by_location_view_id` unique identifier for the table
   - `location` geographical location
   - `infection_rate` sum of total_cases divided by sum of population multiplied by 100 and grouped by location
   - `death_rate` sum of total_deaths divided by sum of population multiplied by 100 and grouped by location
   - `avg_stringency_index` average of all stringency_index provided in the dataset by location
   - `avg_population_density` average of all population_density provided in the dataset by location
   - `avg_cardiovasc_death_rate` average of all cardiovasc_death_rate provided in the dataset by location
   - `avg_aged_70_older` average of all aged_70_older provided in the dataset by location
   - `avg_handwashing_facilities` average of all handwashing_facilities provided in the dataset by location
   - `avg_human_development_index` average of all human_development_index provided in the dataset by location
   - `avg_life_expectancy` average of all life_expectancy provided in the dataset by location
   - `full_vaccination_rate` average of all people_fully_vaccinated provided in the dataset by location

5. **factors_by_continent_view:** this view/table does exactly the same as the previous view/table but this time, it gives info on the prevailing factors by continents

   - `factors_by_location_view_id` unique identifier for the table
   - `location` geographical location
   - `infection_rate` sum of total_cases divided by sum of population multiplied by 100 and grouped by location
   - `death_rate` sum of total_deaths divided by sum of population multiplied by 100 and grouped by location
   - `avg_stringency_index` average of all stringency_index provided in the dataset by location
   - `avg_population_density` average of all population_density provided in the dataset by location
   - `avg_cardiovasc_death_rate` average of all cardiovasc_death_rate provided in the dataset by location
   - `avg_aged_70_older` average of all aged_70_older provided in the dataset by location
   - `avg_handwashing_facilities` average of all handwashing_facilities provided in the dataset by location
   - `avg_human_development_index` average of all human_development_index provided in the dataset by location
   - `avg_life_expectancy` average of all life_expectancy provided in the dataset by location
   - `full_vaccination_rate` average of all people_fully_vaccinated provided in the dataset by location

## Links to Files and Visualization

- [Original Dataset](https://github.com/owid/covid-19-data/blob/master/public/data/README.md)
- [Split Dataset Folder](https://github.com/profgreatwonder/covid_19_analysis/tree/master/corona_dataset)
- [Setup File](https://github.com/profgreatwonder/covid_19_analysis/blob/master/setup_01.sql)
- [Exploratory Data File](https://github.com/profgreatwonder/covid_19_analysis/blob/master/eda_02.sql)
- [Export Views File](https://github.com/profgreatwonder/covid_19_analysis/blob/master/query_exports_03.sql)
- [Exported Views for Visualization Folder](https://github.com/profgreatwonder/covid_19_analysis/tree/master/tables_from_sql_eda)
- [Visualization Dashboard](https://public.tableau.com/app/profile/chidinma.esther.muoghalu/viz/Covid-19DataDashboard_17140585534110/DashboardHome)

## Project Todos

- Download [dataset](https://github.com/owid/covid-19-data/blob/master/public/data/README.md)
- Split dataset using excel and save as CSV
- Ingest split dataset into MySQL workbench
- Carry out Exploratory data analysis (EDA)
- Create Views from EDA queries
- Export Views from MySQL workbench in CSV file format
- Visualize the exported views in Tableau

## Software and Tools Used

- **Excel:** used to split the dataset in 3 and some data cleaning such as replacing null values in numerical columns with 0s and changing the date format from forward slash `(/)` to hyphen `(-)`
- **MySQL Workbench:** used to write the queries
- **Tableau:** used for visualization
- **VSCODE:** used to work with github and write the readme/documentation for the project
- **Git/Github:** used for version control

## Queries Used

1. % of the population that got/died from covid
2. the country(location) with the lowest and highest infection and death rate
3. the continent with the lowest and highest infection and death rate
4. comparing infection rate with the factors below by location
   - stringency index
   - population density
   - population older than 65 years
   - population older than 70 years
   - handwashing facilities
   - cardiovasc_death_rate
   - human_development_index
   - life_expectancy
   - full vaccination
5. comparing infection rate with the factors below by continent
   - stringency index
   - population density
   - population older than 65 years
   - population older than 70 years
   - handwashing facilities
   - cardiovasc_death_rate
   - human_development_index
   - life_expectancy
   - full vaccination

## Views Produced from Queries For Visualization

A view is a table gotten from the result of a SQL statement. They are also known as virtual tables. The list below are names of the csv files exported from the views created from queries made during the analysis.

1. [infection_death_rate](https://github.com/profgreatwonder/covid_19_analysis/blob/master/tables_from_sql_eda/infection_death_rate.csv)
2. [min_max_location_view](https://github.com/profgreatwonder/covid_19_analysis/blob/master/tables_from_sql_eda/min_max_location_view.csv)
3. [min_max_continent_view](https://github.com/profgreatwonder/covid_19_analysis/blob/master/tables_from_sql_eda/min_max_continent_view.csv)
4. [factors_by_location_view](https://github.com/profgreatwonder/covid_19_analysis/blob/master/tables_from_sql_eda/factors_by_location_view.csv)
5. [factors_by_continent_view](https://github.com/profgreatwonder/covid_19_analysis/blob/master/tables_from_sql_eda/factors_by_continent_view.csv)

## Observations

## Challenges

1.  The major challenge experienced was importing the dataset into MySQL workbench using the UI (User Interface). Doing so with the UI whent on for hours without successfully importing all the data. This was solved by first creating a table for each dataset and then using the `DATA INFILE` query method. Below is a sample

        LOAD DATA INFILE 'Uploads/covid_dataset/covid_deaths.csv' INTO TABLE covid_deaths
        FIELDS TERMINATED BY ','
        ENCLOSED BY "'"
        LINES TERMINATED BY '\n'
        IGNORE 1 ROWS;

    The next issue encountered using the query method was an error message

        Error Code: 1290. The MySQL server is running with the --secure-file-priv option so it cannot execute this statement

    To fix the issue on the windows system, a file `my.ini` had to be located and opened with administrative rights using the filepath provided below:

        C:/ProgramData/MySQL/MySQL Server version_number/my.ini

    the variable found in the `my.ini` file and provided below was set to an empty string and then saved.

        secure-file-priv = ""

    After this, the `DATA INFILE` query was uploaded into workbench from

        C:/ProgramData/MySQL/MySQL Server 8.0/Data/Uploads/covid_dataset

    Sending the dataset out of MySQL workbench used the query provided below

        SELECT
            *
        FROM
            covid_deaths_view
        INTO OUTFILE
            'Uploads/covid_dataset/tables_from_sql_eda/covid_deaths_view.csv'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n';

    and stored in the file location also provided below:

        C:/ProgramData/MySQL/MySQL Server 8.0/Data/Uploads/covid_dataset

2.  The error below was gotten from trying to push the original dataset that was split. It was resolved by deleting the dataset from project and sharing the link to where it was gotten instead which is [https://github.com/owid/covid-19-data/blob/master/public/data/README.md](https://github.com/owid/covid-19-data/blob/master/public/data/README.md)

        remote: warning: See https://gh.io/lfs for more information.
        remote: warning: File corona_dataset/original_dataset.xlsx is 59.26 MB; this is larger than GitHub's recommended maximum file size of 50.00 MB
        remote: warning: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.

    Though not a challenge but worthy of note, where we needed a way to add ids to the first 2 tables. the line of code below was added to the query

        ROW_NUMBER() OVER (ORDER BY location) AS
        covid_infection_view_id

## Recommendations

In this section, we have both health and technical recommendations.

### Data and Health

### Technical

It is advisable to add python to projects like this because they are some data manipulations that can be best achieved using achieved using it. There are manipulations that can only be achieved with it - one of such was trying to do a database design using the original dataset split in 3.

There are some columns in the original dataset that represented location which were repeating themes for all 3 datasets. They should be pulled out into a new table with an id column added. The id column is then used as foreign keys in each of the 3 tables gotten from the original dataset.

The table was successfully pulled out and id column added but we could not replace every instance of a given location with its id for our 3 datasets using excel. This would have been possible using the pandas library in python to read through the data, iterate and replace every instance of a given location with its id.
