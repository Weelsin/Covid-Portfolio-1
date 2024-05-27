SELECT 
Location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths;
-- Pull out the location, date, total cases, new cases, total deaths, population


SELECT 
Location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 as DeathPercentage 
FROM covid_deaths
Order by 1, 2;
-- Looking at Total Cases vs Total Deaths

-- AS – Alias- Is a Temporary Name for a Table or Column. You can use it to create a column for the result of a calculation
SELECT 
Location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 as DeathPercentage 
FROM covid_deaths
WHERE location like 'Africa';
-- Looking at the percentage of population died in African from covid


-- Looking at coutries with the Highest Infection Rate  compared to population 
-- NOTE: When doing Functions such as MAX, MIN, SUM etc. You must use group by and add the columns on the SELECT line to the Group by function




SELECT 
location, population, MAX(total_cases), MAX(total_cases/Population) *100 as Infectedpopulation 
FROM covid_deaths
Group by location, Population;

SELECT SUM(total_count) AS total_sum
FROM (
    SELECT COUNT(*) AS total_count
    FROM covid_deaths
    WHERE date LIKE '2024%'
) AS counts;
-- SUM of all 2024 Data

SELECT
    Location,
    population,
    MAX(total_deaths / population) AS Deaths_per_population
FROM
    covid_deaths
GROUP BY
    Location, population;
    
    SELECT
    continent,
    MAX(total_deaths ) as TotalDeathCount
FROM
    covid_deaths
GROUP BY
    continent;
    -- looking at Total death counts per continent 
    
    SELECT
    date,
    SUM(new_cases) AS total_new_cases,
    SUM(CAST(new_deaths AS SIGNED)) AS total_new_deaths,
    (SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM
    Covid_deaths
    WHERE continent is not NULL
GROUP BY
    date
ORDER BY 1,2;
-- Looking at the GLobal Numbers 

SELECT
    SUM(new_cases) AS total_new_cases,
    SUM(CAST(new_deaths AS SIGNED)) AS total_new_deaths,
    (SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM
    Covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY
    total_new_cases, total_new_deaths;

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM covid_vaccinations vac
join Covid_deaths dea
ON vac. Location - Dea. Location
and vac. date - Vac.date
Where dea.continent is not NULL
order by 1,2,3;
-- looking at total population vs vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.New_vaccinations AS SIGNED)) OVER(Partition by dea.location ORDER BY dea.location, dea.date) as Rollingpeoplevaccinated
FROM covid_vaccinations vac
join Covid_deaths dea
ON vac. Location - Dea. Location
and vac. date - Vac.date
Where dea.continent is not NULL
order by 2,3;

-- Creating view to store data for data visualization
CREATE OR REPLACE VIEW covid_deaths_summary AS
SELECT
    date,
    SUM(new_cases) AS total_new_cases,
    SUM(CAST(new_deaths AS SIGNED)) AS total_new_deaths,
    (SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM
    Covid_deaths
    WHERE continent is not NULL
GROUP BY
    date;
-- ORDER BY 1,2;


CREATE OR REPLACE VIEW covid_vaccination_summary AS
SELECT continent,location, date, new_vaccinations, 
SUM(CAST(new_vaccinations AS SIGNED)) OVER(Partition by location ORDER BY location, date) as Rollingpeoplevaccinated
FROM covid_vaccinations 
Where continent is not NULL
order by location, continent;


 




    





