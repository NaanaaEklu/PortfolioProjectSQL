
SELECT*
FROM CovidDeathsWHO$
WHERE location IS NOT NULL AND total_cases IS NOT NULL
ORDER BY location 


SELECT*
FROM CovidVaccinationWHO$
WHERE location IS NOT NULL AND new_vaccinations IS NOT NULL
ORDER BY location

-- Percentage of people who died per country-(total_deaths vs population)-Death rate

SELECT CovidDeathsWHO$.Location,Population, MAX (CAST(total_deaths AS numeric)) AS Max_Total_Deaths, MAX ((total_deaths)/(population))*100 AS DeathPercentage
FROM CovidDeathsWHO$
JOIN CovidVaccinationWHO$
ON CovidDeathsWHO$.location = CovidVaccinationWHO$.location
AND CovidDeathsWHO$.date = CovidVaccinationWHO$.date
GROUP BY CovidDeathsWHO$.location, population
ORDER BY Max_total_deaths DESC
OFFSET 5 ROWS;


--Percentage of people who got infected per country-(infection rate vs population)-Infection rate

SELECT CovidDeathsWHO$.Location,Population, MAX (CAST(total_cases AS numeric)) AS Max_Total_Cases, MAX ((total_cases)/(population))*100 AS InfectionPercentage
FROM CovidDeathsWHO$
JOIN CovidVaccinationWHO$
ON CovidDeathsWHO$.location = CovidVaccinationWHO$.location
AND CovidDeathsWHO$.date = CovidVaccinationWHO$.date
GROUP BY CovidDeathsWHO$.location, population
ORDER BY InfectionPercentage DESC


--Total Cases vs. Total Deaths per country

SELECT Location, MAX (CAST (total_cases AS numeric)) AS Max_Total_Cases, MAX (CAST(total_deaths AS numeric)) AS Max_Total_Deaths, (MAX(CAST(total_deaths AS numeric)) / MAX(CAST(total_cases AS numeric))) * 100 AS InfectionDatePercentage
FROM CovidDeathsWHO$
GROUP BY location
ORDER BY InfectionDatePercentage DESC


--Continents with the highest death counts 

SELECT Continent, MAX (CAST(total_cases AS numeric)) AS Max_Total_Cases, MAX (CAST(total_deaths AS numeric)) AS Max_Total_Deaths
FROM CovidDeathsWHO$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Max_Total_Deaths DESC 


--Global daily numbers

SELECT date, SUM (CAST(new_cases AS numeric))AS sum_new_cases, SUM (cast(new_deaths AS numeric))  AS sum_new_deaths
FROM CovidDeathsWHO$
WHERE Continent IS NOT NULL
GROUP BY date
ORDER BY date


--Total vaccination vs population

SELECT Location, Population, MAX (CAST (new_vaccinations AS numeric)) AS Max_New_Vaccination, MAX (CAST (new_vaccinations AS numeric)/population)*100 AS VaccinationPercentage
FROM CovidVaccinationWHO$
GROUP BY location, Population
ORDER BY VaccinationPercentage DESC


--Overall trend of new COVID-19 cases worldwide over time

SELECT CovidDeathsWHO$.date, MAX (CovidDeathsWHO$.new_cases) AS Max_New_Cases, MAX (CAST(CovidDeathsWHO$.new_deaths AS numeric)) AS Max_New_Deaths
 FROM CovidDeathsWHO$
 JOIN CovidVaccinationWHO$
 ON CovidDeathsWHO$.date = CovidVaccinationWHO$.date
 AND CovidDeathsWHO$.location = CovidVaccinationWHO$.location
 GROUP BY CovidDeathsWHO$.date
 ORDER BY Max_New_Deaths DESC


