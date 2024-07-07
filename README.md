# world_co2
Exploration of countries and territories and their contribution to co2 levels
## SQL/Postgresql


## Python/Jupyter Notebook

- started by looking at only countries that currently exist and filtered out any groupings of countries or territories

- examined the cumulative co2 levels by country and the clear winner in this is the United States, followed from a distance by China

| Country        |      CO2 Emissions |
|:---------------|--------------------:|
| United States  |         426914.556  |
| China          |         260619.243  |
| Russia         |         119290.814  |
| Germany        |          93985.871  |
| United Kingdom |          78834.706  |
| Japan          |          67734.911  |
| India          |          59740.694  |
| France         |          39397.693  |
| Canada         |          34613.228  |
| Ukraine        |          30961.508  |


- examined the cumulative co2 by years and filtered by the top ten years they range from 2012- 2022 with 2020 noticably missing.

| Year |        CO2 |   Coal CO2 |    Oil CO2 |    Gas CO2 | Cement CO2 |
|:-----|-----------:|-----------:|-----------:|-----------:|-----------:|
| 2022 | 237679.814 |  65615.326 |  52381.960 |  37194.995 |   7033.475 |
| 2019 | 236804.780 |  63757.935 |  54128.837 |  36884.891 |   7054.495 |
| 2021 | 236484.697 |  64734.981 |  50954.326 |  38299.411 |   7396.027 |
| 2018 | 235455.960 |  64199.107 |  53688.346 |  36409.482 |   6852.412 |
| 2017 | 231066.766 |  63263.172 |  53671.953 |  34742.105 |   6590.551 |
| 2016 | 227618.087 |  62590.770 |  52852.505 |  33991.622 |   6489.787 |
| 2015 | 227612.884 |  64096.988 |  52357.459 |  33055.487 |   6324.818 |
| 2014 | 227582.200 |  65481.224 |  51206.221 |  32448.060 |   6552.658 |
| 2013 | 226555.346 |  65565.896 |  51159.331 |  32106.497 |   6313.215 |
| 2012 | 225160.414 |  65333.733 |  50952.808 |  32064.065 |   6068.376 |


- yearly emmisions broken down by percentages of industry responsible for co2 levels(oil, gas, coal, and cement) Starting with the       earliest year we have data for being 1750 and 100% of co2 by coal, to the year of 2022 where the use of coal has gone down by 73%.

| Year |      CO2    | Coal CO2% | Oil CO2% | Gas CO2% | Cement CO2% |
|------|-------------|-----------|----------|----------|-------------|
| 1800 |   196.281   | 100.00    |  0.00    |  0.00    |   0.00      |
| 2022 | 237679.814  |  27.61    | 22.04    | 15.65    |   2.96      |


- and then when we look at specific countries especially the big co2 players in the United States and China, the United States coal       percentage is continously on the way down while China's coal use seems to be increasing again since 2020

![United States Coal Emissions Over Time](united_states_co2_emissions_plot.png)
![China Coal Percentage of CO2 Emissions](china_co2_emissions_plot.png)

- form here then created a per capita column to see the countries that are the biggest offenders as far as per capita co2 creation is     concerned.

- though China is one of the largest co2 producers because of their massive amount of population, with a per capita number of 7.99 tons   their numbers are only middle of the pack. The highest of the countries being Qatar with a massive number of 37.13 tons,and countries   such as Australia, Canada, and the Unites States all at least double China's per capita numbers.

- looked at gdp, co2, and population changes and wether or not there is a correlation between gdp/co2, or population/co2.

- when looking at total co2 of all countries combined, compared with gdp and population. GDP has a much stronger corelattion than         population. But when you look at the correlation on a country by country basis, it vastly changes on what country you may be looking   at. Data for Canada shows that the correlation for gdp/co2 and population/co2 are very similar, and then China there is a slight       deviation between the two correlations. But Russia for example has a massive deviation between the two, with gdp correlation of 0.26   and a population correlation of 0.92. Which could point to a data inconsistency, whether in collection or some other reporting error,   or also within my own calculations.

