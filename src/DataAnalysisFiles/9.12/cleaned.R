# Set working directory to where your CSV file is located
setwd("/Users/Jenny/Desktop/MH3511/Project")

# Read the CSV file into a data frame
my_data <- read.csv("train (1).csv")

# Quickly check the first few rows to ensure it's loaded correctly
head(my_data)

# Checking for missing values in columns 9 to 12
sum(is.na(my_data[, 9:12]))

# Column names for reference based on your information
column_names <- c("kurt", "sp.ent", "sfm", "mode")

# Process each column by index
for (i in 9:12) {
  # QQ plot for the column
  qqnorm(my_data[,i], main = paste("QQ Plot of", column_names[i-8]))
  qqline(my_data[,i])
  
  # Histogram for the column
  hist(my_data[,i], main = paste("Histogram of", column_names[i-8]), xlab = column_names[i-8], breaks = "Scott", col = "lightblue")
  
  # Check if the column contains only positive values for log transformation
  if (all(my_data[,i] > 0, na.rm = TRUE)) {
    # Apply a log transformation
    my_data[,paste("log_", column_names[i-8], sep = "")] <- log(my_data[,i])
    
    # Reassess normality with a QQ plot for the log-transformed data
    qqnorm(my_data[,paste("log_", column_names[i-8], sep = "")], main = paste("QQ Plot of Log-Transformed", column_names[i-8]))
    qqline(my_data[,paste("log_", column_names[i-8], sep = "")])
    
    # Reassess the distribution with a histogram for the log-transformed data
    hist(my_data[,paste("log_", column_names[i-8], sep = "")], main = paste("Histogram of Log-Transformed", column_names[i-8]), xlab = paste("Log-Transformed", column_names[i-8]), breaks = "Scott", col = "lightgreen")
  } else {
    warning(paste("Column", column_names[i-8], "contains non-positive values. Log transformation not applied."))
  }
}
library(nortest)

# Shapiro-Wilk test 
results <- list()  # To store the results of the tests

# Sample size for the Shapiro-Wilk test
sample_size <- 5000

for (i in 9:12) {
  column_name <- column_names[i-8]
  log_column_name <- paste("log_", column_name, sep = "")
  
  # Ensure the column is present and has no missing values before performing the test
  if (!is.null(my_data[[log_column_name]]) && sum(is.na(my_data[[log_column_name]])) == 0) {
    # Take a sample of 5000 observations from the log-transformed column
    sample_data <- sample(my_data[[log_column_name]], sample_size, replace = FALSE)
    
    # Perform Shapiro-Wilk test on the sample
    results[[column_name]] <- shapiro.test(sample_data)
  } else {
    results[[column_name]] <- NA  # Assign NA if the column does not exist or has NAs
  }
}

# To view the results of the Shapiro-Wilk test for each column
results

# Function to identify and remove outliers based on the IQR method
remove_outliers <- function(data_column) {
  Q1 <- quantile(data_column, 0.25, na.rm = TRUE)
  Q3 <- quantile(data_column, 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  # Create a logical vector where TRUE indicates a non-outlier
  non_outliers <- (data_column >= (Q1 - 1.5 * IQR)) & (data_column <= (Q3 + 1.5 * IQR))
  return(data_column[non_outliers])
}

# Column indices excluding 'kurt'
columns_to_process <- c(10, 11, 12)

# Process each column by index, remove outliers from log-transformed columns, and store results
cleaned_data <- my_data  # Create a copy of the original data to store cleaned data

for (i in columns_to_process) {
  log_column_name <- paste("log_", column_names[i-8], sep = "")
  
  # Check if the log-transformed column exists in the data
  if (!is.null(my_data[[log_column_name]])) {
    # Apply the remove_outliers function to the log-transformed column
    cleaned_data[[log_column_name]] <- remove_outliers(my_data[[log_column_name]])
  }
}