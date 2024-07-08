# world_co2
Exploration of countries and territories and their contribution to co2 levels
## SQL/Postgresql


## Python/Jupyter Notebook

- started by looking at only countries that currently exist and filtered out any groupings of countries or territories

- analyzed the cumulative CO2 emissions by country. The United States emerges as the largest contributor to cumulative CO2 levels, leading significantly ahead of other nations. China, although also a major emitter, follows at a considerable distance. This stark contrast highlights the historical impact of industrial activities in the United States on global CO2 emissions.

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


- analyzed the cumulative CO2 emissions by year and identified the top ten years with the highest emissions. These years span from 2012 to 2022, with a notable absence of 2020. This missing year likely reflects the global reduction in industrial activity and transportation due to the COVID-19 pandemic. The following data highlight the years with the highest emissions, providing insights into the recent trends in global CO2 production.

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


- analyzed the yearly CO2 emissions, breaking them down by the percentage contributions from different industries: oil, gas, coal, and cement. Starting from the year 1750, coal was responsible for 100% of CO2 emissions. Over the centuries, the contributions from oil, gas, and cement have increased, leading to a more diverse industrial impact on CO2 levels. By 2022, the reliance on coal has decreased significantly, with its share of CO2 emissions dropping by 73%. The following data and visualizations illustrate these changes, highlighting the evolving sources of CO2 emissions over time.
| Year |      CO2    | Coal CO2% | Oil CO2% | Gas CO2% | Cement CO2% |
|------|-------------|-----------|----------|----------|-------------|
| 1750 |   55.836    | 100.00    |  0.00    |  0.00    |   0.00      |
| 2022 | 237679.814  |  27.61    | 22.04    | 15.65    |   2.96      |

![Total Coal Emissions Over Time](total_coal_co2.png)
- Next, we examined the percentage of CO2 emissions attributable to coal. Overall, countries have significantly reduced their coal production. However, the two largest CO2 producers show markedly different trends.  The following plots illustrate these differences.

![United States Coal Emissions Over Time](united_states_co2_emissions_plot.png)

![China Coal Percentage of CO2 Emissions](china_co2_emissions_plot.png)

- form here then created a per capita column to see the countries that are the biggest offenders as far as per capita co2 creation is     concerned.

- though China is one of the largest co2 producers because of their massive amount of population, with a per capita number of 7.99 tons   their numbers are only middle of the pack. The highest of the countries being Qatar with a massive number of 37.13 tons,and countries   such as Australia, Canada, and the Unites States all at least double China's per capita numbers.

- looked at gdp, co2, and population changes and wether or not there is a correlation between gdp/co2, or population/co2.

- when looking at total co2 of all countries combined, compared with gdp and population. GDP has a much stronger corelattion than         population. But when you look at the correlation on a country by country basis, it vastly changes on what country you may be looking   at. Data for Canada shows that the correlation for gdp/co2 and population/co2 are very similar, and then China there is a slight       deviation between the two correlations. But Russia for example has a massive deviation between the two, with gdp correlation of 0.26   and a population correlation of 0.92. Which could point to a data inconsistency, whether in collection or some other reporting error,   or also within my own calculations.

