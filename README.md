# Querying Global Warming Datasets using SQL: Project Overview
Created SQL Scripts to generate queries from 5 datasets regarding global warming using MySQL.

## Query Results
For each year (2010 to 2014), display the average [extent] of sea ice, maximum 
[extent] of sea ice, minimum [extent] of sea ice, and the total amount of emission [value].

![image](https://user-images.githubusercontent.com/84263856/201735881-91912d17-362e-4c53-80c5-5f29237dd515.png)

For each year (2010 to 2014), display the average [extent] of sea ice, maximum 
[extent] of sea ice, minimum [extent] of sea ice, average [landaveragetemperature], 
minimum [landaveragetemperature], and maximum [landaveragetemperature].
![image](https://user-images.githubusercontent.com/84263856/201736022-95f71fa7-6266-4daf-9290-6a2467223b4c.png)

For each year (2010 to 2014), display the sum of emission [value], average 
temperature change [temperaturechangebycountry.value], minimum temperature 
change, and maximum temperature change in Australia.
![image](https://user-images.githubusercontent.com/84263856/201736106-881b4aa1-6f84-47bc-8d2d-06dfe83f8dfe.png)

Display a list of glaciers [name], [investigator], and amount of surveyed on the 
glacier done by the investigator, when the investigator has conducted more than 
11 surveys on the glacier. Sort the output in alphabetic order of [name].
![image](https://user-images.githubusercontent.com/84263856/201736183-c3a97520-a625-41ba-a784-0384a6b81f1b.png)

For each year (2010 to 2014), display a list of [area], [year], average [value] of 
temperature change of the ASEAN countries. Include the overall average of temperature change of all the ASEAN countries of each year.

![image](https://user-images.githubusercontent.com/84263856/201736268-2632ffb2-e480-4524-a70a-c9f58a2477f7.png)

Display a list of [country_or_area], [year], [category], and average emission [value] 
when the [country_or_area]’s emission [value] of the [year] is less than the 
average emission [value] of the [country_or_area].

![image](https://user-images.githubusercontent.com/84263856/201736320-a4c27b2b-a723-4624-86b6-ca3f581f3d27.png)

For each year (2008 to 2017), display the average [value] of temperature change 
in “United States of America”, the year’s average [extent] of [seaice.extent] sea 
ice, and the corresponding average [value] of 
[temperaturechangebycountry.elevation_change_unc] glacier elevation change 
surveyed by “Martina Barandun Robert McNabb” in the same year.

![image](https://user-images.githubusercontent.com/84263856/201736367-fb18f25c-adb0-40a6-b944-be880ee1922d.png)

## Code and Resources Used
**Datasets Sources:**
1. International Greenhouse Gas Emissions https://www.kaggle.com/datasets/unitednations/international-greenhouse-gasemissions?ref=hackernoon.com&select=greenhouse_gas_inventory_data_data.csv 
2. Temperature change statistics 1961–2021. Global, regional and country trends https://www.fao.org/food-agriculture-statistics/data-release/data-releasedetail/en/c/1492093/ 
3. Climate Change: Earth Surface Temperature Data https://www.kaggle.com/datasets/berkeleyearth/climate-change-earth-surfacetemperature-data?ref=hackernoon.com 
4. Daily Sea Ice Extent Data https://www.kaggle.com/datasets/nsidcorg/daily-sea-ice-extentdata?ref=hackernoon.com 
5. Glaciers elevation and mass change data from 1850 to present from the Fluctuations of Glaciers Database https://cds.climate.copernicus.eu/cdsapp#!/dataset/insitu-glaciers-elevationmass?tab=overview

**MySQL Workbench:** 8.0 CE


