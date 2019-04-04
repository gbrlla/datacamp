# COURSE: EXPLORATORY DATA ANALYSIS

# Print the first rows of the data
comics[1,]

# Check levels of align
levels(comics$align)

# Check the levels of gender
library(dplyr)
glimpse(comics)
levels(comics$gender)

# Create a 2-way contingency table
table(comics$align, comics$gender)

# Load dplyr
library(dplyr)

# Print tab
tab

# Remove align level
comics_filtered <- comics %>%
  filter(align != "Reformed Criminals") %>%
  droplevels()

# Load ggplot2
library(ggplot2)

# Create side-by-side barchart of gender by alignment
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "dodge")

# Create side-by-side barchart of alignment by gender
ggplot(comics, aes(x = gender, fill = align)) + 
  geom_bar(position = "dodge") +
  theme(axis.text.x = element_text(angle = 90))

# Plot of gender by align
ggplot(comics, aes(x = align, fill = gender)) +
  geom_bar()

# Plot proportion of gender, conditional on align
ggplot(comics, aes(x = align, fill = gender)) + 
  geom_bar(position = "fill") +
  ylab("proportion")

# Change the order of the levels in align
comics$align <- factor(comics$align, 
                       levels = c("Bad", "Neutral", "Good"))


# Create plot of align
ggplot(comics, aes(x = align)) + 
  geom_bar()


# Plot of alignment broken down by gender
ggplot(comics, aes(x = align)) + 
  geom_bar() +
  facet_wrap(~ gender)

# Put levels of flavor in decending order
lev <- c("apple", "key lime", "boston creme", "blueberry", "cherry", "pumpkin", "strawberry")
pies$flavor <- factor(pies$flavor, levels = lev)

# Create barchart of flavor
ggplot(pies, aes(x = flavor)) + 
  geom_bar(fill = "chartreuse") + 
  theme(axis.text.x = element_text(angle = 90))

# Load package
library(ggplot2)

# Learn data structure
str(cars)

# Create faceted histogram
ggplot(cars, aes(x = city_mpg)) +
  geom_histogram() +
  facet_wrap(~ suv)

# Filter cars with 4, 6, 8 cylinders
common_cyl <- filter(cars, ncyl %in% c(4, 6, 8))

# Create box plots of city mpg by ncyl
ggplot(common_cyl, aes(x = as.factor(ncyl), y = city_mpg)) +
  geom_boxplot()

# Create overlaid density plots for same data
ggplot(common_cyl, aes(x = city_mpg, fill = as.factor(ncyl))) +
  geom_density(alpha = .3)

# Create hist of horsepwr
cars %>%
  ggplot(aes(x=horsepwr)) +
  geom_histogram() +
  ggtitle("Distribution")

# Create hist of horsepwr for affordable cars
cars %>% 
  filter(msrp < 25000) %>%
  ggplot(aes(x=horsepwr)) +
  geom_histogram() +
  xlim(c(90, 550)) +
  ggtitle("Hist of bla")


# Construct box plot of msrp
cars %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()

# Exclude outliers from data
cars_no_out <- cars %>%
  filter(msrp < 100000)

# Construct box plot of msrp using the reduced dataset
cars_no_out %>%
  ggplot(aes(x = 1, y = msrp)) +
  geom_boxplot()

# Create plot of city_mpg
cars %>%
  ggplot(aes(x = 1, y = city_mpg)) +
  geom_boxplot()

# Create plot of width
cars %>% 
  ggplot(aes(x = width)) +
  geom_density()

# Facet hists using hwy mileage and ncyl
common_cyl %>%
  ggplot(aes(x = hwy_mpg)) +
  geom_histogram() +
  facet_grid(ncyl ~ suv) +
  ggtitle("hahahahaha")


# Measures of center

# Create dataset of 2007 data
gap2007 <- filter(gapminder, year == 2007)

# Compute groupwise mean and median lifeExp
gap2007 %>%
  group_by(continent) %>%
  summarize(mean(lifeExp),
            median(lifeExp))

# Generate box plots of lifeExp for each continent
gap2007 %>%
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()


# Compute groupwise measures of spread
gap2007 %>%
  group_by(continent) %>%
  summarize(sd(lifeExp),
            IQR(lifeExp),
            n())

# Generate overlaid density plots
gap2007 %>%
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.3)

gapminder$continent

# Compute stats for lifeExp in Americas
gap2007 %>%
  filter(continent == "Americas") %>%
  summarize(mean(lifeExp),
            sd(lifeExp))

# Compute stats for population
gap2007 %>%
  summarize(median(pop),
            IQR(pop))

# Create density plot of old variable
gap2007 %>%
  ggplot(aes(x = pop)) +
  geom_density()

# Transform the skewed pop variable
gap2007 <- gap2007 %>%
  mutate(log_pop = log(pop))

# Create density plot of new variable
gap2007 %>%
  ggplot(aes(x = log_pop)) +
  geom_density()


# Filter for Asia, add column indicating outliers
gap_asia <- gap2007 %>%
  filter(continent == "Asia") %>%
  mutate(is_outlier = lifeExp < 50)

# Remove outliers, create box plot of lifeExp
gap_asia %>% 
  filter(!is_outlier) %>%
  ggplot(aes(x = 1, y = lifeExp)) +
  geom_boxplot()

# Load packages
library(openintro)
library(ggplot2)
library(dplyr)

glimpse(email)

# Compute summary statistics
email %>%
  group_by(spam) %>%
  summarize(median(num_char),
            IQR(num_char))

# Create plot
email %>%
  mutate(log_num_char = log(num_char)) %>%
  ggplot(aes(x = spam, y = log_num_char)) +
  geom_boxplot()

# Compute center and spread for exclaim_mess by spam
email %>%
  group_by(spam) %>%
  summarize(median(exclaim_mess),
            IQR(exclaim_mess))

# Create plot for spam and exclaim_mess
email %>%
  mutate(log_exclaim_mess = log(exclaim_mess + 0.01)) %>%
  ggplot(aes(x = log_exclaim_mess)) +
  geom_histogram() +
  facet_wrap(~ spam)

# Alternative plot: side-by-side box plots
email %>%
  mutate(log_exclaim_mess = log(exclaim_mess + 0.01)) %>%
  ggplot(aes(x = 1, y = log_exclaim_mess)) +
  geom_boxplot() +
  facet_wrap(~ spam)

# Alternative plot: Overlaid density plots
email %>%
  mutate(log_exclaim_mess = log(exclaim_mess + .01)) %>%
  ggplot(aes(x = log_exclaim_mess, fill = spam)) +
  geom_density(alpha = 0.3)

# Create plot of proportion of spam by image
email %>%
  mutate(has_image = image > 0) %>%
  ggplot(aes(x = has_image, fill = spam)) +
  geom_bar(position = "fill")

# Test if images count as attachments
sum(email$image > email$attach)

# "Within non-spam emails, is the typical 
# length of emails shorter for those that were sent to multiple people?"
email %>%
  filter(spam == "not-spam") %>%
  group_by(to_multiple) %>%
  summarize(median(num_char))

# Question 1
email %>%
  filter(dollar > 0) %>%
  group_by(spam) %>%
  summarize(median(dollar))

# Question 2
email %>%
  filter(dollar > 10) %>%
  ggplot(aes(x = spam)) +
  geom_bar()

# Reorder levels
email$number <- factor(email$number, levels = c("none", "small", "big"))

# Construct plot of number
ggplot(email, aes(x = number)) +
  geom_bar() +
  facet_wrap(~ spam)