SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is null
ORDER BY 3,4


SELECT *
FROM covidvaccinations
ORDER BY 3,4

--Select Data that we are going to be using 

SELECT location,date,total_cases, new_cases,total_deaths, population
FROM CovidDeaths
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying of you contract in your country

SELECT location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like 'Austria'
ORDER BY 1,2

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_deaths float

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_cases float


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

SELECT location,date,population,total_cases,population, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location like 'Austria'
ORDER BY 1,2


--Looking at Countries with Highest Infection Rate compared to Population

SELECT location,population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%uzbekistan%'
GROUP BY location, population
ORDER BY PercentPopulationInfected desc

-- Showing the Countries with Highest Death Count per population
SELECT location,MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null 
GROUP BY location
ORDER BY  TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT


-- Showing continents with the highest death per population

SELECT location,MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is null 
and location not like '%income%'
GROUP BY location
ORDER BY  TotalDeathCount desc


--GLOBAL NUMBERS


SELECT SUM(new_cases)as total_cases,SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
 FROM PortfolioProject..CovidDeaths


 --Looking at Total Population vs Vaccinations
 SELECT dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
  FROM PortfolioProject..CovidDeaths as dea
  JOIN PortfolioProject..CovidVaccinations as vac
  ON dea.location=vac.location and dea.date=vac.date
  WHERE dea.continent is not null
ORDER BY 2,3

--Use CTE
With PopvsVac (Continent,Location,Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
  FROM PortfolioProject..CovidDeaths as dea
  JOIN PortfolioProject..CovidVaccinations as vac
  ON dea.location=vac.location and dea.date=vac.date
  WHERE dea.continent is not null
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac


-- TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
continent nvarchar (255),
Location nvarchar (255),
Date datetime, 
Population numeric,
New_vaccinations numeric, 
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
  FROM PortfolioProject..CovidDeaths as dea
  JOIN PortfolioProject..CovidVaccinations as vac
  ON dea.location=vac.location and dea.date=vac.date
  --WHERE dea.continent is not null
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


--Creating View to Store Data for Later Vizualizations
CREATE VIEW PercentPopulationVaccinated as 
SELECT dea.continent,dea.location,dea.date,dea.population, vac.new_vaccinations,
 SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
  FROM PortfolioProject..CovidDeaths as dea
  JOIN PortfolioProject..CovidVaccinations as vac
  ON dea.location=vac.location and dea.date=vac.date
  WHERE dea.continent is not null
--ORDER BY 2,3


SELECT *
FROM PercentPopulationVaccinated

