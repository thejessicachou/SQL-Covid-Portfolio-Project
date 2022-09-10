--Looking at Total Population vs Vaccinations

WITH PopsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
AS 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM covid_deaths AS dea
INNER JOIN covid_vaccines AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL)

SELECT *, (RollingPeopleVaccinated/Population::float)*100
FROM PopsVac