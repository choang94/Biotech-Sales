
#read files
data_2014 = read.csv("2014.csv")
data_2015 = read.csv("2015.csv")
data_2016 = read.csv("2016.csv")
#select columns 
column = c("id","sale","units","rating","product","industry","country","return.client")
data_2014 = data_2014[column]
data_2015 = data_2015[column]
data_2016 = data_2016[column]
#combine into a single data set
data = rbind(data_2014,data_2015,data_2016)
#create a new variable
data_2014$year = "2014"
data_2015$year = "2015"
data_2016$year = "2016"

data = rbind(data_2014,data_2015,data_2016)

#Examine the dataset
str(data)

# Recoding Values
#Find unique values
levels(data$country)

unique(data$country)
data$country = as.character(data$country)
data$country[data$country == "Switzerland, Switzerland"] = "Switzerland"
data$country = as.factor(data$country)

#recode the rest, only keep 3 countries
country = c ("United States","Switzerland","United Kingdom")
data$country = as.character(data$country)
data$country[!data$country %in% country] = "Other"
data$country = as.factor(data$country)
levels(data$country)

#combine product types (observation)
levels(data$product)
data$product[data$product == "Series A2|Series A13"] = "Series A" 
data$product[data$product == "Series B55"] = "Series B"
#Convert to NAs
levels(data$industry)
data$industry[data$industry == "999"] = NA
#Find missing values NA for each variable using for loop
for (i in names(data)) {
  sum_na = sum(is.na(data[,i]))
  output = paste(i,":",sum_na)
  print(output)
}

#change NA in "product" to "Delta"
data$product[is.na(data$product)] ="Delta"

#remove all observations with missing value

data = na.omit(data)
str(data)
#1673-1626 = 73 observations removed

#create variable
data$sale.per.unit = data$sale/data$units
#create a categorical variable
data$rating.level[data$rating >= 5] =  "excellent"
data$rating.level[data$rating > 4 & data$rating < 5] = "satisfactory"
data$rating.level[data$rating <=4 ] = "poor"
#create a "priority" variable
data$priority = 0
data$priority[data$return.client == 1 & data$rating.level == "poor"] = 1
#export csv
write.csv(data,"chau_hoang.csv", row.names = FALSE)
  
  
  
  
  
  

