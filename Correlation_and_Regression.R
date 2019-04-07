# COURSE correlation-and-regression

# Scatterplot of weight vs. weeks
library(dplyr)
glimpse(ncbirths)

ggplot(ncbirths, aes(x=weeks, y=weight)) + geom_point()

# Boxplot of weight vs. weeks
ggplot(data = ncbirths, 
       aes(x = cut(weeks, breaks = 5), y = weight)) + 
  geom_boxplot()

# Mammals scatterplot
ggplot(mammals, aes(x=BodyWt, y=BrainWt)) + geom_point()
glimpse(mammals)

# Baseball player scatterplot
ggplot(mlbBat10, aes(x=OBP, y=SLG)) + geom_point()
glimpse(mlbBat10)


# Body dimensions scatterplot
ggplot(bdims, aes(x=hgt, y=wgt, color= factor(sex))) + geom_point()
glimpse(bdims)


# Smoking scatterplot
ggplot(smoking, aes(x=age, y=amtWeekdays)) + geom_point()
glimpse(smoking)

# Scatterplot with coord_trans()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + 
  coord_trans(x = "log10", y = "log10")

# Scatterplot with scale_x_log10() and scale_y_log10()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10() + scale_y_log10()


# Scatterplot of SLG vs. OBP
mlbBat10 %>% 
  filter(AB >= 200) %>%
  ggplot(aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
mlbBat10 %>%
  filter(AB >= 200, OBP < 0.2)

# correlation

# Compute correlation
ncbirths %>%
  summarize(N = n(), r = cor(weight, mage))

# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), r = cor(weight, weeks, use = "pairwise.complete.obs"))


# Compute properties of Anscombe
Anscombe %>%
  group_by(set) %>%
  summarize(N = n(), mean(x), sd(x), mean(y), sd(y), cor(x, y))
