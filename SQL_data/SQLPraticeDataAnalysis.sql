--Select location, last_updated_date, new_cases,total_cases, total_deaths, population
--from PortfolioProject..DeathTable
--order by 1, 2

--looking at total cases vs total deaths
Select location, last_updated_date, total_cases, total_deaths, (total_deaths/total_cases*100) as DeathPercentage
from PortfolioProject..DeathTable
where location like '%states'
order by 1, 2
