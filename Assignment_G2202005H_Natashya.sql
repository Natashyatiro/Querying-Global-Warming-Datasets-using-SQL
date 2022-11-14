-- SQL Queries

-- Q1
SELECT DISTINCT(category) AS categories
FROM greenhouse_gas_inventory_data_data;

-- Q2
-- Show the total from every year's emission
SELECT SUM(value) AS Total_Emission_Value
FROM greenhouse_gas_inventory_data_data
WHERE country_or_area = "European Union" AND
year BETWEEN 2010 AND 2014;

-- Q3
SELECT year, category, value
FROM greenhouse_gas_inventory_data_data
WHERE country_or_area = "Australia"
AND value > 530000
ORDER BY year;

-- Q4
-- Creating copy of seaice table to retreive the right data type
CREATE TABLE new_seaice
AS
SELECT * FROM seaice;

ALTER TABLE new_seaice    
MODIFY Year INT,
MODIFY Month INT,
MODIFY Day INT,
MODIFY Extent FLOAT,
MODIFY Missing FLOAT;  

SELECT g.year, s.avg_extent, s.max_extent, s.min_extent, SUM(g.value) AS total_emission
FROM greenhouse_gas_inventory_data_data g, 
	(SELECT year, AVG(Extent) AS avg_extent, MAX(Extent) AS max_extent,
    MIN(Extent) AS min_extent
    FROM new_seaice
    GROUP BY year
	HAVING year BETWEEN 2010 AND 2014
    ) s
WHERE g.year = s.year
GROUP BY year
ORDER BY year;

-- Q5
-- Creating copy of  globaltemperatures table to retreive the right data type
CREATE TABLE new_globaltemperatures
AS
SELECT recordedDate,
  NULLIF(LandAverageTemperature,'') AS LandAverageTemperature,
  NULLIF(LandAverageTemperatureUncertainty,'') AS LandAverageTemperatureUncertainty
FROM globaltemperatures;

ALTER TABLE new_globaltemperatures   
MODIFY recordedDate DATE,
MODIFY LandAverageTemperature FLOAT,
MODIFY LandAverageTemperatureUncertainty FLOAT;

SELECT s.year, AVG(s.Extent) AS avg_extent, MAX(s.Extent) AS max_extent, MIN(s.Extent) AS min_extent,
	avgLandTemperature, minLandTemperature, maxLandTemperature
FROM new_seaice s, 
	(SELECT EXTRACT(YEAR FROM recordedDate) AS year, 
		AVG(LandAverageTemperature) AS avgLandTemperature,
		MIN(LandAverageTemperature) AS minLandTemperature,
		MAX(LandAverageTemperature) AS maxLandTemperature
	FROM new_globaltemperatures
	GROUP BY year
	HAVING year BETWEEN 2010 AND 2014) g
WHERE s.year = g.year
GROUP BY year;

-- Q6
-- Creating copy of  temperaturechangebycountry table to retreive the right data type
CREATE TABLE new_temperaturechangebycountry
AS
SELECT DomainCode, Domain, AreaCode, Area, ElementCode, Element, MonthsCode, Months, YearCode, Year, Unit,
  NULLIF(Value,'') AS Value, Flag, FlagDescription
FROM temperaturechangebycountry;

ALTER TABLE new_temperaturechangebycountry   
MODIFY Year INT,
MODIFY Value FLOAT;

SELECT g.year, SUM(g.value) total_emission, t.avgTemperatureChange, t.minTemperatureChange, t.maxTemperatureChange
FROM greenhouse_gas_inventory_data_data g, 
	(SELECT Year, AVG(Value) avgTemperatureChange, MIN(Value) minTemperatureChange, MAX(Value) maxTemperatureChange
    FROM new_temperaturechangebycountry
    WHERE Area = "Australia"
    GROUP BY Year
	HAVING Year BETWEEN 2010 AND 2014) t
WHERE g.year = t.Year AND
g.country_or_area = "Australia"
GROUP BY g.year
ORDER BY g.year;

-- Q7
SELECT NAME name, INVESTIGATOR investigator, COUNT(*) surveyedAmt
FROM mass_balance_data
GROUP BY NAME, INVESTIGATOR
HAVING COUNT(*) > 11
ORDER BY NAME;

-- Q8
SELECT IFNULL(Area,'ASEAN') area, Year year, AVG(convert(Value, double)) avgValueChange
FROM temperaturechangebycountry
WHERE Area in ("Brunei Darussalam", "Cambodia", "Indonesia", "Myanmar", "Lao People's Democratic Republic", "Malaysia", "Philippines", "Singapore", "Thailand", "Viet Nam")
GROUP BY Year, AREA with ROLLUP
HAVING Year BETWEEN 2010 AND 2014;

-- Q9
SELECT g1.country_or_area, year, value, category, g2.avgValue
FROM greenhouse_gas_inventory_data_data g1,
	(SELECT country_or_area, AVG(Value) avgValue
	FROM greenhouse_gas_inventory_data_data
	GROUP BY country_or_area) g2
WHERE value < g2.avgValue AND
g1.country_or_area = g2.country_or_area
GROUP BY country_or_area, year;

-- Q10
-- Creating copy of elevation_change_data table to retreive the right data type
CREATE TABLE new_elevation_change_data
AS
SELECT PU, NAME, WGMS_ID, SURVEY_ID, SURVEY_DATE, REFERENCE_DATE, AREA_SURVEY_YEAR, 
AREA_CHANGE, ELEVATION_CHANGE, NULLIF(ELEVATION_CHANGE_UNC,'') AS ELEVATION_CHANGE_UNC,
INVESTIGATOR, SPONS_AGENCY
FROM elevation_change_data;

ALTER TABLE new_elevation_change_data   
MODIFY ELEVATION_CHANGE_UNC INT;

SELECT t.Year, t.avgValue, s.avgExtent, e.avgElevationChange
FROM 
	(SELECT Year, AVG(Value) avgValue
	FROM new_temperaturechangebycountry
	WHERE Area = "United States of America"
	GROUP BY Year
	HAVING YEAR BETWEEN 2008 AND 2017) t,
    
	(SELECT Year, avg(Extent) as avgExtent
	FROM new_seaice
	GROUP BY Year) s,
    
    (SELECT SUBSTR(SURVEY_DATE,1,4) Year, Avg(ELEVATION_CHANGE_UNC) avgElevationChange 
	FROM new_elevation_change_data
	WHERE INVESTIGATOR = "Martina Barandun Robert McNabb"
	GROUP BY Year) e
    
WHERE t.Year = s.Year AND
s.Year = e.Year
ORDER BY t.Year;