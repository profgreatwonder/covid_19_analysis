# Understanding Covid-19 and its Prevailing Factors Between 2020 to 2024

## Documentation Table of Contents

- Problem Statement
- Project Goal
- Project and Dataset Description
- Links to Files and Visualization
- Project Todos
- Software and Tools
- Queries Used
- Views Produced from Queries For Visualization
- Observations
- Challenges
- Recommendations

## Problem Statement

Understanding Covid-19 and its Prevailing Factors Between 2020 to 2024.

## Project Goal

The goal for this project is to understand the factors that increased or reduced the spread of covid-19 for different countries and continents between 2020 and 2024.

### Question

The questions below will enable us achieve the project goal and inform how to formulate the queries

1. What country experienced the highest infection rate
2. What country experienced the highest death rate
3. What continent experienced the highest infection rate
4. What continent experienced the most death rate
5. How did the following factors affect infection rate by country and continent
   - stringency index
   - population density
   - population older than 65 years
   - population older than 70 years
   - handwashing facilities
   - cardiovasc_death_rate
   - human_development_index
   - life_expectancy
   - full vaccination

## Project and Dataset Description

### Links to Files and Visualization

- [Original Dataset](<(https://github.com/owid/covid-19-data/blob/master/public/data/README.md)>)
- [Setup File]()
- [Exploratory Data File]()
- [Export Views File]()

## Project Todos

-- data was downloaded, database redesigned (write a note on this)

exporting all tables out to a csv file for visualization in tableau

## Software and Tools

- Excel: used to split the dataset in 3 and some data cleaning such as replacing null values in numerical columns with 0s.
- MySQL Workbench: used to write the queries
- Tableau: used for visualization
- VSCODE: used to work with github and do the readme
- Git/Github: used for version control

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

A view is a table gotten from the result of an SQL statement. They are also known as virtual tables. The list below are names of the csv files exported from the views created from queries made during the analysis.

1. infection_death_rate
2. min_max_location_view
3. min_max_continent_view
4. factors_by_location_view
5. factors_by_continent_view

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
        covid_infection_view_id,

## Recommendations

In this section, we have both health and technical recommendations.

### Data and Health

### Technical

It is advisable to add python to projects like this because they are some data manipulations that can be best achieved using achieved using it. There are manipulations that can only be achieved with it - one of such was trying to do a database design using the original dataset split in 3.

There are some columns in the original dataset that represented location which were repeating themes for all 3 datasets. They should be pulled out into a new table with an id column added. The id column is then used as foreign keys in each of the 3 tables gotten from the original dataset.

The table was successfully pulled out and id column added but we could not replace every instance of a given location with its id for our 3 datasets using excel. This would have been possible using the pandas library in python to read through the data, iterate and replace every instance of a given location with its id.
