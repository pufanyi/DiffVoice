voice <- read.csv("data/train.csv", header = TRUE)
str(voice)
dim(voice)

# drop all the rows with null value in column gender
voice <- subset(voice, gender != 'nan')
dim(voice)

# choose 10 columns to perform the analysis
selected_columns <- c('meanfreq', 'sd', 'median', 'Q25', 'Q75', 'skew', 'sp.ent', 'sfm', 'meanfun')

# check the number of rows with gender == female
num_female <- sum(voice$gender == "female")
num_female

# ramdom sample 755 rows with 'gender' == male
sampled_male_rows <- subset(voice, gender == 'male', select = selected_columns)
sampled_male_rows <- sampled_male_rows[sample(nrow(sampled_male_rows), num_female), ]

sampled_female_rows <- subset(voice, gender == 'female', select = selected_columns)

# 偷鸡一波
var = "meanfun"
var_male <- mean(sampled_male_rows[[var]])
var_female <- mean(sampled_female_rows[[var]])
print("偷鸡一波")
print(var_male)
print(var_female)

# combine the sampled rows
sampled_rows <- rbind(sampled_male_rows, sampled_female_rows)
dim(sampled_rows)

# define a outlier removing function
remove_outliers <- function(column_name, dataframe, threshold = 1.5) {
  column <- dataframe[[column_name]]
  
  # Calculate the first and third quartiles
  Q1 <- quantile(column, 0.25)
  Q3 <- quantile(column, 0.75)
  
  # Calculate the interquartile range (IQR)
  IQR <- Q3 - Q1
  
  # Define the upper and lower bounds to identify outliers
  lower_bound <- Q1 - threshold * IQR
  upper_bound <- Q3 + threshold * IQR
  
  # Subset the dataframe to remove outliers
  cleaned_dataframe <- dataframe[column >= lower_bound & column <= upper_bound, ]
  
  return(cleaned_dataframe)
}

for (column in selected_columns) {
  sampled_rows <- remove_outliers(column, sampled_rows)
  print(dim(sampled_rows))  # Print the dimensions after removing outliers
}
