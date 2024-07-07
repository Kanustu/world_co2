# world_co2
Exploration of countries and territories and their contribution to co2 levels
## SQL/Postgresql


## Python/Jupyter Notebook

- started by looking at only countries that currently exist and filtered out any groupings of countries or territories

- examined the cumulative co2 levels by country and the clear winner in this is the United States, followed from a distance by China
| country        |      co2 |\n|:---------------|---------:|\n| United States  | 426915   |\n| China          | 260619   |\n| Russia         | 119291   |\n| Germany        |  93985.9 |\n| United Kingdom |  78834.7 |\n| Japan          |  67734.9 |\n| India          |  59740.7 |\n| France         |  39397.7 |\n| Canada         |  34613.2 |\n| Ukraine        |  30961.5 |

- examined the cumulative co2 by years and filtered by the top ten and bottom ten years. within the top ten years they range from 2012

- 2022 with 2020 noticably missing, a preliminary guess for that reason would be 2020 being the height of the global pandemic.

- yearly emmisions broken down by percentages of industry responsible for co2 levels(oil, gas, coal, and cement) Starting with the       earliest year we have data for being 1750 and 100% of co2 by coal, to the year of 2022 where the use of coal has gone down by 73%.

- and then when we look at specific countries especially the big co2 players in the United States and China, the United States coal       percentage is continously on the way down while China's coal use seems to be increasing again since 2020

- form here then created a per capita column to see the countries that are the biggest offenders as far as per capita co2 creation is     concerned.

- though China is one of the largest co2 producers because of their massive amount of population, with a per capita number of 7.99 tons   their numbers are only middle of the pack. The highest of the countries being Qatar with a massive number of 37.13 tons,and countries   such as Australia, Canada, and the Unites States all at least double China's per capita numbers.

- looked at gdp, co2, and population changes and wether or not there is a correlation between gdp/co2, or population/co2.

- when looking at total co2 of all countries combined, compared with gdp and population. GDP has a much stronger corelattion than         population. But when you look at the correlation on a country by country basis, it vastly changes on what country you may be looking   at. Data for Canada shows that the correlation for gdp/co2 and population/co2 are very similar, and then China there is a slight       deviation between the two correlations. But Russia for example has a massive deviation between the two, with gdp correlation of 0.26   and a population correlation of 0.92. Which could point to a data inconsistency, whether in collection or some other reporting error,   or also within my own calculations.

