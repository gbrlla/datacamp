##### COURSE: Importing data in R (PT2)

# Load the DBI package
library(DBI)

# Connect to the MySQL database: con
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")

# Build a vector of table names: tables
tables <- c(dbListTables(con))

# Display structure of tables
str(tables)

# Import the users table from tweater: users
users <- dbReadTable(con, "users")

# Print users
users

# Get table names
table_names <- dbListTables(con)

# Import all tables
tables <- lapply(table_names, dbReadTable, conn = con)

# Print out tables
tables

# Import tweat_id column of comments where user_id is 1: elisabeth
elisabeth <- dbGetQuery(con, "SELECT tweat_id
                        FROM comments
                        WHERE user_id = 1")

# Print elisabeth
elisabeth

# Import post column of tweats where date is higher than '2015-09-21': latest
latest <- dbGetQuery(con, "SELECT post
                     FROM tweats
                     WHERE date > '2015-09-21'")

# Print latest
latest

# Create data frame specific
specific <- dbGetQuery(con, "SELECT message
                       FROM comments
                       WHERE tweat_id = 77 
                       AND user_id > 4")


# Print specific
specific

# Create data frame short
short <- dbGetQuery(con, "SELECT id, name 
                    FROM users 
                    WHERE CHAR_LENGTH(name) < 5")

# Print short
short

# Send query to the database
res <- dbSendQuery(con, "SELECT * FROM comments WHERE user_id > 4")

# Use dbFetch() twice
dbFetch(res, n = 2)
dbFetch(res)
# Create the data frame  long_tweats
long_tweats <- dbGetQuery(con, "SELECT post, date FROM tweats WHERE CHAR_LENGTH(post) > 40")

# Print long_tweats
long_tweats

# Disconnect from the database
dbDisconnect(con)

# Load the readr package
library(readr)

# Import the csv file: pools
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
pools <- read_csv(url_csv)

# Import the txt file: potatoes
url_delim <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt"
potatoes <- read_tsv(url_delim)

# Print pools and potatoes
pools
potatoes



# https URL to the swimming_pools csv file.
url_csv <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"

# Import the file using read.csv(): pools1
pools1 <- read.csv(url_csv)

# Load the readr package
library(readr)

# Import the file using read_csv(): pools2
pools2 <- read_csv(url_csv)

# Print the structure of pools1 and pools2
str(pools1)
str(pools2)


# Load the readxl and gdata package
library(readxl)
library(gdata)

# Specification of url: url_xls
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

# Import the .xls file with gdata: excel_gdata
excel_gdata <- read.xls(url_xls)

# Download file behind URL, name it local_latitude.xls
download.file(url_xls, destfile = "local_latitude.xls")

# Import the local .xls file with readxl: excel_readxl
excel_readxl <- read_excel("local_latitude.xls")

# https URL to the wine RData file.
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"

# Download the wine file to your working directory
download.file(url_rdata, "wine_local.RData")

# Load the wine data into your workspace using load()
load("wine_local.RData")

# Print out the summary of the wine data
summary(wine)

# Load the httr package
library(httr)

# Get the url, save response to resp
resp <- GET("http://www.example.com/")

# Print resp
resp

# Get the raw content of resp: raw_content
raw_content <- content(resp, "raw")

# Print the head of raw_content
  head(raw_content)

  
  # Get the url
  url <- "http://www.omdbapi.com/?apikey=72bc447a&t=Annie+Hall&y=&plot=short&r=json"
  resp <- GET(url)
  
  # Print resp
  resp
  
  # Print content of resp as text
  content(resp, as = "text")
  
  # Print content of resp
  content(resp)

  # JSON and API
  
  # Load the jsonlite package
  install.packages("jsonlite")
  library(jsonlite)
  
  # wine_json is a JSON
  wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'
  
  
  # Convert wine_json into a list: wine
  wine <- fromJSON(wine_json)
  
  
  # Definition of quandl_url
  quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"
  
  # Import Quandl data: quandl_data
  quandl_data <- fromJSON(quandl_url)
  
  # Print structure of quandl_data
  str(quandl_data)

  # Definition of the URLs
  url_sw4 <- "http://www.omdbapi.com/?apikey=72bc447a&i=tt0076759&r=json"
  url_sw3 <- "http://www.omdbapi.com/?apikey=72bc447a&i=tt0121766&r=json"
  
  # Import two URLs with fromJSON(): sw4 and sw3
  sw4 <- fromJSON(url_sw4)
  sw3 <- fromJSON(url_sw3)
  
  # Print out the Title element of both lists
  sw4$Title
  sw3$Title
  
  # Is the release year of sw4 later than sw3?
  sw4$Year > sw3$Year
    
  # install.packages("tibble")
  # library(tibble)
  # teste <- as_tibble(sw4)
  # teste
  # str(teste)
  
  # Challenge 1
  json1 <- '[1, 2, 3, 4, 5, 6]'
  fromJSON(json1)
  
  # Challenge 2
  json2 <- '{"a": [1, 2, 3], "b": [4, 5, 6]}'
  fromJSON(json2)
  
  # URL pointing to the .csv file
  url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"
  
  # Import the .csv file located at url_csv
  water <- read.csv(url_csv, stringsAsFactors = FALSE)
  
  # Convert the data file according to the requirements
  water_json <- toJSON(water)
  
  # Print out water_json
  water_json
  
  # Convert mtcars to a pretty JSON: pretty_json
  pretty_json <- toJSON(mtcars, pretty = TRUE)
  
  # Print pretty_json
  pretty_json
  
  # Minify pretty_json: mini_json
  mini_json <- minify(pretty_json)
  
  # Print mini_json
  mini_json
  
  # Load the haven package
  library(haven)
  
  # Import sales.sas7bdat: sales
  sales <- read_sas("sales.sas7bdat")
  
  # Display the structure of sales
  str(sales)
  
  # Import person.sav: traits
  traits <- read_sav("person.sav")
  
  # Summarize traits
  summary(traits)
  
  
  # Print out a subset
  subset(traits, Extroversion > 40 & Agreeableness > 40)
  
  # Import SPSS data from the URL: work
  work <- read_sav("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")
  
  # Display summary of work$GENDER
  summary(work$GENDER)
  
  # Convert work$GENDER to a factor
  work$GENDER <- as_factor(work$GENDER)
  
  # Display summary of work$GENDER again
  summary(work$GENDER)
  
  # Load the foreign package
  library(foreign)
  
  # Import florida.dta and name the resulting data frame florida
  florida <- read.dta("florida.dta")
  
  # Check tail() of florida
  tail(florida)
  
  # foreign is already loaded
  
  # Specify the file path using file.path(): path
  path <- file.path("worldbank", "edequality.dta")
  
  # Create and print structure of edu_equal_1
  edu_equal_1 <- read.dta(path)
  str(edu_equal_1)
  
  # Create and print structure of edu_equal_2
  edu_equal_2 <- read.dta(path, convert.factors = FALSE)
  str(edu_equal_2)
  
  # Create and print structure of edu_equal_3
  edu_equal_3 <- read.dta(path, convert.underscore = TRUE)
  str(edu_equal_3)
  
  # foreign is already loaded
  
  # Import international.sav as a data frame: demo
  demo <- read.spss("international.sav", to.data.frame = TRUE)
  
  # Create boxplot of gdp variable of demo
  boxplot(demo$gdp)
