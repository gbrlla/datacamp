# Fitting a parallel slopes model
# We use the lm() function to fit linear models to data. In this case, 
# we want to understand how the price of MarioKart games sold at auction 
# varies as a function of not only the number of wheels included in the 
# package, but also whether the item is new or used. Obviously, it is 
# expected that you might have to pay a premium to buy these new. 
# But how much is that premium? Can we estimate its value after 
# controlling for the number of wheels?
# 
# We will fit a parallel slopes model using lm(). 
# In addition to the data argument, lm() needs to know 
# which variables you want to include in your regression
# model, and how you want to include them. It accomplishes
# this using a formula argument. A simple linear regression
# formula looks like y ~ x, where y is the name of the 
# response variable, and x is the name of the explanatory 
# variable. Here, we will simply extend this formula to 
# include multiple explanatory variables. A parallel slopes
# model has the form y ~ x + z, where z is a categorical 
# explanatory variable, and x is a numerical explanatory variable.
# 
# The output from lm() is a model object, which when printed, 
# will show the fitted coefficients.



# The dataset mario_kart is already loaded for you. Explore the data 
# using glimpse() or str().
# Use lm() to fit a parallel slopes model for total price as a 
# function of the number of wheels and the condition of the item. 
# Use the argument data to specify the dataset you're using.

# Explore the data
glimpse(mario_kart)

# fit parallel slopes
lm(totalPr ~ wheels + cond, mario_kart)


# Using geom_line() and augment()
# 
# Parallel slopes models are so-named because we can visualize 
# these models in the data space as not one line, but two parallel 
# lines. To do this, we'll draw two things:
# 
# a scatterplot showing the data, with color separating the points into groups
# a line for each value of the categorical variable Our plotting strategy 
# is to compute the fitted values, plot these, and connect the points to 
# form a line. The augment() function from the broom package provides an 
# easy way to add the fitted values to our data frame, and the geom_line() 
# function can then use that data frame to plot the points and connect them.
# 
# Note that this approach has the added benefit of automatically coloring 
# the lines apropriately to match the data.
# 
# You already know how to use ggplot() and geom_point() to make 
# the scatterplot. The only twist is that now you'll pass your 
# augment()-ed model as the data argument in your ggplot() call. 
# When you add your geom_line(), instead of letting the y aesthetic 
# inherit its values from the ggplot() call, you can set it to the 
# .fitted column of the augment()-ed model. This has the advantage 
# of automatically coloring the lines for you.



# The parallel slopes model mod relating total price to the number of 
# wheels and condition is already in your workspace.
# 
# augment() the model mod and explore the returned data frame using 
# glimpse(). Notice the new variables that have been created.
# 
# Draw the scatterplot and save it as data_space by passing the 
# augment()-ed model to ggplot() and using geom_point().
# Use geom_line() once to add two parallel lines corresponding to our model.

# Augment the model
augmented_mod <- augment(mod)
glimpse(augmented_mod)

# scatterplot, with color
data_space <- ggplot(augmented_mod, aes(x = wheels, y = totalPr, color = cond)) + 
  geom_point()

# single call to geom_line()
data_space + 
  geom_line(aes(y = .fitted))


# Syntax from math
# The babies data set contains observations about the birthweight and 
# other characteristics of children born in the San Francisco Bay area 
# from 1960--1967.
# 
# We would like to build a model for birthweight as a function of 
# the mother's age and whether this child was her first (parity == 0). 
# Use the mathematical specification below to code the model in R.
# 
# birthweight=Î²0+Î²1âage+Î²2âparity+Ïµ

# The birthweight variable is recorded in the column bwt.
#
# Use lm() to build the parallel slopes model specified above. It's not
# necessary to use factor() in this case as the variable parity is coded
# using binary numeric values.

# build model
lm(bwt ~ age + parity, data = babies)

# Syntax from plot
# This time, we'd like to build a model for birthweight as a 
# function of the length of gestation and the mother's smoking 
# status. Use the plot to inform your model specification.

# Use lm() to build a parallel slopes model implied by the plot. 
# It's not necessary to use factor() in this case either.
# build model
lm(bwt ~ gestation + smoke, data = babies)


# R-squared vs. adjusted R-squared
# Two common measures of how well a model fits to data are R2 (the coefficient of determination) 
# and the adjusted R2. The former measures the percentage of the variability in the response 
# variable that is explained by the model. To compute this, we define
# R2=1−SSESST,
# where SSE and SST are the sum of the squared residuals, and the total sum of the squares, 
# respectively. One issue with this measure is that the SSE can only decrease as new variable
# are added to the model, while the SST depends only on the response variable and therefore is
# not affected by changes to the model. This means that you can increase R2 by adding any 
# additional variable to your model—even random noise.
# 
# The adjusted R2 includes a term that penalizes a model for each additional explanatory 
# variable (where p is the number of explanatory variables).
# R2adj=1−SSESST⋅n−1n−p−1



# Use summary() to compute R2 and adjusted R2 on the model object called mod.
summary(mod)


# Use mutate() and rnorm() to add a new variable called noise to the mario_kart
# data set that consists of random noise. Save the new dataframe as mario_kart_noisy.
mario_kart_noisy <- mario_kart %>%
  mutate(noise = rnorm(nrow(mario_kart)))


# Use lm() to fit a model that includes wheels, cond, and the random noise term.
mod2 <- lm(totalPr ~ wheels + cond + noise, data = mario_kart_noisy)

# Use summary() to compute R2 and adjusted R2 on the new model object. Did the value 
# of R2 increase? What about adjusted R2?
summary(mod2)


# Prediction
# Once we have fit a regression model, we can use it to make predictions for unseen 
# observations or retrieve the fitted values. Here, we explore two methods for doing the latter.
# 
# A traditional way to return the fitted values (i.e. the y^'s) is to run the predict() 
# function on the model object. This will return a vector of the fitted values. Note that 
# predict() will take an optional newdata argument that will allow you to make predictions 
# for observations that are not in the original data.
# 
# A newer alternative is the augment() function from the broom package, which returns 
# a data.frame with the response varible (y), the relevant explanatory variables (the x's), 
# the fitted value (y^) and some information about the residuals (e). augment() will also 
# take a newdata argument that allows you to make predictions.

# Compute the fitted values of the model as a vector using predict().
predict(mod)

# Compute the fitted values of the model as one column in a data.frame using augment().
augment(mod)


# Fitting a model with interaction
# Including an interaction term in a model is easy—we just have to tell lm() that we want 
# to include that new variable. An expression of the form
# 
# lm(y ~ x + z + x:z, data = mydata)
# will do the trick. The use of the colon (:) here means that the interaction between x 
# and z will be a third term in the model.

# The data frame mario_kart is already loaded in your workspace.
# 
# Use lm() to fit a model for the price of a MarioKart as a function of its
# condition and the duration of the auction, with interaction.
lm(totalPr ~ duration + cond + cond:duration, data = mario_kart)


#Visualizing interaction models
#Interaction allows the slope of the regression line in each group to vary. In this case, 
#this means that the relationship between the final price and the length of the auction is 
#moderated by the condition of each item.

#Interaction models are easy to visualize in the data space with ggplot2 because they have 
#the same coefficients as if the models were fit independently to each group defined by the 
#level of the categorical variable. In this case, new and used MarioKarts each get their own 
#regression line. To see this, we can set an aesthetic (e.g. color) to the categorical variable, 
#and then add a geom_smooth() layer to overlay the regression line for each color.

#The dataset mario_kart is already loaded in your workspace.

#Use the color aesthetic and the geom_smooth() function to plot the interaction model between 
#duration and condition in the data space. Make sure you set the method and se arguments of geom_smooth().

# interaction plot
ggplot(mario_kart, aes(y = totalPr, x = duration, color = cond)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

#Simpson's paradox in action
#A mild version of Simpson's paradox can be observed in the MarioKart auction data. 
#Consider the relationship between the final auction price and the length of the auction.
#It seems reasonable to assume that longer auctions would result in higher prices, since—other 
#things being equal—a longer auction gives more bidders more time to see the auction and bid on the item.

#However, a simple linear regression model reveals the opposite: longer auctions are associated 
#with lower final prices. The problem is that all other things are not equal. In this case, the 
#new MarioKarts—which people pay a premium for—were mostly sold in one-day auctions, while a 
#plurality of the used MarioKarts were sold in the standard seven-day auctions.

#Our simple linear regression model is misleading, in that it suggests a negative relationship 
#between final auction price and duration. However, for the used MarioKarts, the relationship is positive.

#The object slr is already defined for you.
#Fit a simple linear regression model for final auction price (totalPr) as a function of duration (duration).
#Use aes() to add a color aesthetic that's mapped to the condition variable to the slr object, which is the plot shown at right.

slr <- ggplot(mario_kart, aes(y = totalPr, x = duration)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = 0)

# model with one slope
lm(totalPr ~ duration, data = mario_kart)

# plot with two slopes
slr + aes(color = cond)

#Fitting a MLR model
#In terms of the R code, fitting a multiple linear regression model is easy: simply add 
#variables to the model formula you specify in the lm() command.

#In a parallel slopes model, we had two explanatory variables: one was numeric and one was categorical. 
#Here, we will allow both explanatory variables to be numeric.

# Fit the model using duration and startPr
lm(totalPr ~ duration + startPr, data = mario_kart)

#Tiling the plane
#One method for visualizing a multiple linear regression model is to create a heatmap of the fitted 
#values in the plane defined by the two explanatory variables. This heatmap will illustrate how the 
#model output changes over different combinations of the explanatory variables.

#This is a multistep process:
#First, create a grid of the possible pairs of values of the explanatory variables. The grid 
#should be over the actual range of the data present in each variable. We've done this for 
#you and stored the result as a data frame called grid.
#Use augment() with the newdata argument to find the y^'s corresponding to the values in grid.
#Add these to the data_space plot by using the fill aesthetic and geom_tile().

#The model object mod is already in your workspace.

#Use augment() to create a data.frame that contains the values the model outputs for each row of grid.
#Use geom_tile to illustrate these predicted values over the data_space plot. Use the fill aesthetic and set alpha = 0.5.
# add predictions to grid
price_hats <- augment(mod, newdata = grid)
head(price_hats)
# tile the plane
data_space + 
  geom_tile(data = price_hats, aes(fill = .fitted), alpha = 0.5)


#Models in 3D
#An alternative way to visualize a multiple regression model with two numeric explanatory variables is as a plane in three dimensions. This is possible in R using the plotly package.

#We have created three objects that you will need:

#x: a vector of unique values of duration
#y: a vector of unique values of startPr
#plane: a matrix of the fitted values across all combinations of x and y
#Much like ggplot(), the plot_ly() function will allow you to create a plot object with variables mapped 
#to x, y, and z aesthetics. The add_markers() function is similar to geom_point() in that it allows you to add points to your 3D plot.

#Note that plot_ly uses the pipe (%>%) operator to chain commands together.
#Run the plot_ly command to draw 3D scatterplot for totalPr as a function of duration and startPr 
#by mapping the z variable to the response and the x and y variables to the explanatory variables. 
#Duration should be on the x-axis and starting price should be on the y-axis.
#Use add_surface() to draw a plane through the cloud of points by setting z = ~plane.
# draw the 3D scatterplot
p <- plot_ly(data = mario_kart, z = ~totalPr, x = ~duration, y = ~startPr, opacity = 0.6) %>%
  add_markers() 
  
# draw the plane
p %>%
  add_surface(x = ~x, y = ~y, z = ~plane, showscale = FALSE)

