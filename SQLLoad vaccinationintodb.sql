Declare @JSON varchar(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET (BULK 'C:\Users\smith\Desktop\DataAnalysis_notes\Newdatavaccination.json', SINGLE_CLOB) import

insert into PortfolioProject.dbo.VaccinationTable
SELECT *
FROM OPENJSON (@JSON)
WITH 
(
    continent varchar(20), 
    location varchar(20),
	last_updated_date varchar(20),
	total_cases DECIMAL(18),
	new_cases DECIMAL(18),
    new_cases_smoothed DECIMAL(18),
    total_deaths DECIMAL(18),
    new_deaths DECIMAL(18),
    new_deaths_smoothed DECIMAL(18),
    total_cases_per_million DECIMAL(18),
    new_cases_per_million DECIMAL(18),
    new_cases_smoothed_per_million DECIMAL(18),
    total_deaths_per_million DECIMAL(18),
    new_deaths_per_million DECIMAL(18),
    new_deaths_smoothed_per_million DECIMAL(18),
    population DECIMAL(18),
   total_vaccinations Decimal(18),
   people_vaccinated Decimal(18),
   people_fully_vaccinated Decimal(18),
   total_boosters Decimal(18),
   new_vaccinations Decimal(18),
   new_vaccinations_smoothed Decimal(18),
   total_vaccinations_per_hundred Decimal(18),
   people_vaccinated_per_hundred Decimal(18),
   people_fully_vaccinated_per_hundred Decimal(18),
   total_boosters_per_hundred Decimal(18),
   new_vaccinations_smoothed_per_million Decimal(18),
   new_people_vaccinated_smoothed Decimal(18),
   new_people_vaccinated_smoothed_per_hundred  Decimal(18)

)
SELECT * from PortfolioProject.dbo.VaccinationTable
