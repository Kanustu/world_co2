import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

def cumulative_co2(df: pd.DataFrame, direction: str, entry_count: int) -> pd.DataFrame:
    """
    Returns a DataFrame containing the cumulative CO2 emissions for the specified number of countries.

    Parameters:
    df (pd.DataFrame): The input DataFrame containing CO2 emissions data.
    direction (str): Specifies whether to return the top or bottom entries by CO2 emissions. Must be either 'top' or 'bottom'.
    entry_count (int): The number of countries to include in the result. Must be a positive integer.

    Returns:
    pd.DataFrame: A DataFrame with the cumulative CO2 emissions for the specified number of countries.

    Raises:
    ValueError: If the 'direction' parameter is not 'top' or 'bottom'.
    ValueError: If the 'entry_count' parameter is not a positive integer.
    """
    # Validate direction parameter
    if direction not in {'top', 'bottom'}:
        raise ValueError('Invalid value for direction. Please select "top" or "bottom".')

    # Validate entry_count parameter
    if entry_count <= 0:
        raise ValueError('Entry_count must be a positive integer.')

    # Filter out rows with null CO2 values and group by country
    data = df[df['co2'].notnull()].groupby('country').sum()[['co2']]

    # Retrieve the top or bottom entries
    if direction == 'top':
        return data.nlargest(entry_count, 'co2').reset_index()
    elif direction == 'bottom':
        return data.nsmallest(entry_count, 'co2').reset_index()

def percent_calc(df: pd.DataFrame, calculations: dict) -> pd.DataFrame:
    """
    Calculates percentage columns in the DataFrame based on the specified calculations.

    Parameters:
    df (pd.DataFrame): The input DataFrame.
    calculations (dict): A dictionary where keys are the new column names and values are tuples containing
                         the column to be divided (minor_col) and the column to divide by (total_col).

    Returns:
    pd.DataFrame: The DataFrame with new percentage columns added.
    """
    for new_col_name, (minor_col, total_col) in calculations.items():
        df[new_col_name] = round(df[minor_col] / df[total_col] * 100, 2)
    return df

def per_capita_creation(df: pd.DataFrame) -> pd.DataFrame:
    """
    Creates a per capita CO2 emissions column in the DataFrame.

    Parameters:
    df (pd.DataFrame): The input DataFrame.

    Returns:
    pd.DataFrame: The DataFrame with the 'co2_per_capita' column added.
    """
    df['co2_per_capita'] = round((df['co2'] * 1e6) / df['population'], 2)
    return df[df['co2'].notnull()][['year', 'country', 'co2', 'co2_per_capita']].reset_index(drop=True)

def industry_perct_emiss_country(country: str, df: pd.DataFrame) -> pd.DataFrame:
    """
    Retrieves the industry percentage emissions data for a specified country.

    Parameters:
    country (str): The name of the country to retrieve data for.
    df (pd.DataFrame): The input DataFrame.

    Returns:
    pd.DataFrame: A DataFrame containing the industry percentage emissions data for the specified country.

    Raises:
    ValueError: If the specified country does not exist within the dataset.
    """
    countries = set(df['country'])
    if country not in countries:
        raise ValueError(f'{country} not found in current dataframe.')
    
    return df[(df['country'] == country) & (df['co2'].notnull())][['country', 'year', 'co2', 'coal_prct', 'oil_prct', 'gas_prct', 'cement_prct']]

def per_cap_by_year(df: pd.DataFrame, direction: str, entry_count: int, year: int) -> pd.DataFrame:
    """
    Returns a DataFrame containing the per capita CO2 emissions for a specified year,
    and the specified number of countries, either top or bottom.

    Parameters:
    df (pd.DataFrame): The input DataFrame.
    direction (str): Specifies whether to return the top or bottom entries by per capita CO2 emissions. Must be either 'top' or 'bottom'.
    entry_count (int): The number of countries to include in the result. Must be a positive integer.
    year (int): The year for which to retrieve the data. Must be less than 2023.

    Returns:
    pd.DataFrame: A DataFrame with the per capita CO2 emissions for the specified number of countries for the given year.

    Raises:
    ValueError: If the 'direction' parameter is not 'top' or 'bottom'.
    ValueError: If the 'entry_count' parameter is not a positive integer.
    ValueError: If the 'year' parameter is not less than 2023.
    """
    # Validate parameters
    if direction not in {'top', 'bottom'}:
        raise ValueError('Invalid value for direction. Please select "top" or "bottom".')

    if entry_count <= 0:
        raise ValueError('Entry_count must be a positive integer.')
    
    if year >= 2023:
        raise ValueError('Year must be less than 2023.')

    # Filter the DataFrame for the specified year and non-null CO2 values
    data = df[(df['year'] == year) & (df['co2'].notnull())]

    # Retrieve the top or bottom entries by per capita CO2 emissions
    if direction == 'top':
        return data.nlargest(entry_count, 'co2_per_capita').reset_index(drop=True)
    elif direction == 'bottom':
        return data.nsmallest(entry_count, 'co2_per_capita').reset_index(drop=True)

def country_per_cap_co2(df: pd.DataFrame, country: str) -> pd.DataFrame:
    """
    Retrieves the CO2 and per capita CO2 emissions data for a specified country.

    Parameters:
    df (pd.DataFrame): The input DataFrame.
    country (str): The name of the country to retrieve data for. Must be a string.

    Returns:
    pd.DataFrame: A DataFrame containing the CO2 emissions data for the specified country, 
                  including columns for 'country', 'year', 'co2', and 'co2_per_capita'.

    Raises:
    ValueError: If the 'country' parameter is not a string.
    ValueError: If the specified country does not exist within the dataset.
    """
    # Check if the country parameter is a string
    if not isinstance(country, str):
        raise ValueError('Country parameter must be a string.')

    # Create a set of valid country names from the DataFrame
    countries = set(df['country'])

    # Check if the specified country exists in the dataset
    if country not in countries:
        raise ValueError(f'Country "{country}" does not exist within the given dataset.')

    # Filter the DataFrame for the specified country and non-null per capita CO2 values
    data = df[(df['country'] == country) & (df['co2_per_capita'].notnull())]

    # Return the relevant columns, resetting the index
    return data[['country', 'year', 'co2', 'co2_per_capita']].reset_index(drop=True)

def country_demo(country: str, data: pd.DataFrame) -> pd.DataFrame:
    """
    Filters and returns a dataframe containing demographic data for a specified country.

    Parameters:
    country (str): The name of the country to filter the dataframe by.

    Returns:
    pd.DataFrame: A dataframe containing the demographic data for the specified country 
                  with the index reset and 'index' column removed.

    Raises:
    ValueError: If the specified country does not exist in the dataframe or if no data 
                is found for the specified country.
    """
    # Validate if the country exists in the dataframe
    countries = set(data['country'])
    if country not in countries:
        raise ValueError(f'{country} does not exist within given dataframe.')

    # Filter the dataframe
    df = data.loc[(data['country'] == country) & (data['population'].notnull())]

    # Check if the filtered dataframe is empty
    if df.empty:
        raise ValueError(f'No data found for {country}.')

    # Reset the index and drop the old index column
    df = df[df['co2'].notnull()].reset_index().drop(columns='index')[['country', 'year', 'population', 'gdp', 'co2']]

    return df

def yearly_prct_chng(df: pd.DataFrame, column_creation: dict, prct_calculations: dict) -> pd.DataFrame:
    """
    Calculates yearly percentage changes for specified columns in the DataFrame.

    Parameters:
    df (pd.DataFrame): The input DataFrame.
    column_creation (dict): A dictionary where keys are the new column names and values are the columns to create a shifted version of.
    prct_calculations (dict): A dictionary where keys are the new percentage change column names and values are tuples containing
                              the current year column and the last year column.

    Returns:
    pd.DataFrame: The DataFrame with new percentage change columns added.
    """
    for new_column, orig_column in column_creation.items():


        df[new_column] = df[orig_column].shift(1)
    for new_column, (current_year, last_year) in prct_calculations.items():
        df[new_column] = round((df[current_year] - df[last_year]) / df[last_year] * 100, 2)
    return df[['country', 'year', 'population', 'pop_prct_chng', 'gdp', 'gdp_prct_chng', 'co2', 'co2_prct_chng']]

def dual_scatter(country: str, data: pd.DataFrame):
    """
    Generates a dual scatter plot for CO2 emissions vs. population and CO2 emissions vs. GDP for a specified country.

    Parameters:
    country (str): The name of the country to generate the scatter plots for.

    Returns:
    None
    """
    # Determine if the country is 'Total' or a specific country
    if country == 'Total':
        data = data
    else:
        data = country_demo(country, data)

    # Calculate correlations for titles
    pop_co2_corr = data['co2'].corr(data['population'])
    gdp_co2_corr = data['co2'].corr(data['gdp'])

    # Create subplots
    fig, axes = plt.subplots(1, 2, figsize=(12, 5))

    # Scatter plot for CO2 vs. Population
    sns.scatterplot(ax=axes[0], x='co2', y='population', data=data)
    axes[0].set_title(f'{country} CO2 vs Population\nCorrelation: {pop_co2_corr:.2f}')
    axes[0].set_xlabel('CO2 Emissions')
    axes[0].set_ylabel('Population')

    # Scatter plot for CO2 vs. GDP
    sns.scatterplot(ax=axes[1], x='co2', y='gdp', data=data)
    axes[1].set_title(f'{country} CO2 vs GDP\nCorrelation: {gdp_co2_corr:.2f}')
    axes[1].set_xlabel('CO2 Emissions')
    axes[1].set_ylabel('GDP')

    # Display plots
    plt.show()

# Sample dictionaries for calculations
calculations = {
    'coal_prct': ('coal_co2', 'co2'),
    'oil_prct': ('oil_co2', 'co2'),
    'gas_prct': ('gas_co2', 'co2'),
    'cement_prct': ('cement_co2', 'co2')
}

column_creation = {
    'last_population': 'population',
    'last_gdp': 'gdp',
    'last_co2': 'co2'
}

prct_calculations = {
    'pop_prct_chng': ('population', 'last_population'),
    'gdp_prct_chng': ('gdp', 'last_gdp'),
    'co2_prct_chng': ('co2', 'last_co2')
}
