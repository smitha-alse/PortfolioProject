--SELECT location,last_updated_date,total_cases,new_cases,total_deaths,population
--FROM PortfolioProject.dbo.DeathTable
--order by 1,2

--total cases vs total deaths
--SELECT location,last_updated_date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathrate
--FROM PortfolioProject.dbo.DeathTable
--where location like '%states'
--order by Deathrate desc


--total cases vs population
--shows percentage of people who got covid
--SELECT location,last_updated_date,total_cases,population,(total_cases/population)*100 as InfectionRate
--FROM PortfolioProject.dbo.DeathTable
--where location like '%states'
--order by 1,2 asc


--total cases vs population
--shows percentage of people who got covid
SELECT location,population, MAX(total_cases) as HIghestInfectionCount, 
MAX((total_cases/population))*100 as InfectionRate
FROM PortfolioProject.dbo.DeathTable
--where location like '%states'
group by location,population
order by InfectionRate   desc        


--showing the countries with highest death count for population

SELECT location,population,continent, MAX(total_deaths) as HIghestDeathCount, 
MAX((total_deaths/population))*100 as DeathPercentage
FROM PortfolioProject.dbo.DeathTable
where continent is null
group by location,population,continent
order by DeathPercentage   desc

--ordering by continent

--showing highest death count for population based on continent

SELECT location,population,continent, MAX(total_deaths) as HIghestDeathCount,
MAX((total_deaths/population))*100 as DeathPercentage
FROM PortfolioProject.dbo.DeathTable
where continent is null
group by location,population,continent
order by DeathPercentage   desc

--Global Numbers

Select last_updated_date,SUM(new_cases) as total_new_cases, SUM(new_deaths) as Total_newDeaths,
(SUM(cast (new_deaths as int))/ SUM(new_cases))*100 as DeathPercentage
from PortfolioProject.dbo.DeathTable
where continent is not null
group by last_updated_date
order by 1,2 


--Accessing covid vaccnation table

--looking at total population vs vaccination

WITH PopvsVAC (last_updated_date ,continent, location, population, new_vaccinations,RollingPeopleVaccinated)
as
(
Select dea.last_updated_date ,dea.continent, dea.location, dea.population, vac.new_vaccinations
,SUM(vac.new_vaccinations) OVER (PARTITION by dea.location order by dea.location,dea.last_updated_date) as RollingPeopleVaccinated

from PortfolioProject.dbo.DeathTable dea
join PortfolioProject.dbo.VaccinationTable vac
	on dea.location=vac.location
	and dea.last_updated_date = vac.last_updated_date
--where dea.continent is not null
where dea.location like '%states'
--order by 3,1

)

select * ,(RollingPeopleVaccinated/population)*100 as PercentageOfPopulationVaccinated
from PopvsVAC


--pending create view and eliminate booster data when calculating % of people vaccinated