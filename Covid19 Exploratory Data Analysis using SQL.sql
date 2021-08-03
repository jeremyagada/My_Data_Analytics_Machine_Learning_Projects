--this selects all the data in the data set.
select *
from CovidEDA..CovidDeaths$
order by 3,4

--select *
--from CovidEDA..CovidVaccination$
--order by 3,4

-- Let's Select the Columns we will be using:
select location, date,total_cases,new_cases,total_deaths,population
from CovidEDA..CovidDeaths$
order by 1,2

-- Let's look at the total cases vs total deaths (the percentage death per country)
select location, total_cases, total_deaths, (total_deaths / total_cases) * 100 as Death_Percentage
from CovidEDA..CovidDeaths$
--Let's see the Death percentage in Africa
where location like '%Africa%'
--order by 2,3

-- Let's the country with the highest Infection rate
select location, population, MAX(total_cases) as highest_cases, Max((total_cases / population)) * 100 as PercentageInfection
from CovidEDA..CovidDeaths$
group by location,population
order by PercentageInfection desc

--Now we are going to explore the data by CONTINENT

--Let's Display the countries with the highest death count.
select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from CovidEDA..CovidDeaths$
where continent is not null
group by continent
order by TotalDeathCount desc

--Let's get the total number of new cases and new deaths globally
select date, SUM(cast(new_cases as int)) as New_Case_Globally, SUM(cast(new_deaths as int)) as New_Death_Globally
from CovidEDA..CovidDeaths$
where continent is not null
group by date 
order by 1,2 desc

--Let's get the total number of Population vs Vaccination
-- first let's pull out the vaccine table to see the columns we have
select *
from CovidEDA..CovidVaccination$


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidEDA..CovidDeaths$ dea join CovidEDA..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

--Let's get the population that is vaccinated.
select dea.date, dea.location, dea.population, vac.total_vaccinations
from CovidEDA..CovidDeaths$ dea join CovidEDA..CovidVaccination$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null



--Let's get the highest number of places with  highest vaccination
select location, MAX(total_vaccinations) as TotalVaccination , date
from CovidEDA..CovidVaccination$
where continent is not null
group by location, date
order by 1,2 desc
