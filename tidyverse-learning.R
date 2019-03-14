install.packages("gapminder")
install.packages("tidyverse")


library(tidyverse)
library(gapminder)
library(ggplot2)


# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp), 
            medianGdPercap = median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x=medianGdPercap, y=medianLifeExp, color = continent)) + 
  geom_point()

# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x=year, y=medianGdpPercap)) + 
         geom_line() + 
         expand_limits(y=0)

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x=year, y=medianGdpPercap, color=continent)) + 
  geom_line() + 
  expand_limits(y=0)

# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x=continent, y=medianGdpPercap)) + 
  geom_col() + 
  expand_limits(y=0)

# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>%
  filter(continent == "Oceania", year == 1952)

# Create a bar plot of gdpPercap by country
ggplot(oceania_1952, aes(x=country, y=gdpPercap)) + 
  geom_col()

# select 1952
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(x=pop)) + geom_histogram()
  
# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x=pop)) + geom_histogram() + scale_x_log10()

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x=continent, y=gdpPercap)) + 
  geom_boxplot() + scale_y_log10()

# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() +
  ggtitle("Comparing GDP per capita across continents")
