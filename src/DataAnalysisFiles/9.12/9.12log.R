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

