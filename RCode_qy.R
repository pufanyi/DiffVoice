features <- read.csv("~/Documents/GitHub/MH3511/data/train.csv", header = TRUE)
# extract column 1, and 5 to 8
id <- features[,1]
cols_5_to_8 <- features[,5:8]
data_toclean <- cbind(id, cols_5_to_8)
head(data_toclean, 10)
length(data_toclean)
# To analyse column Q25
Q25 <- data_toclean[,2]
summary(Q25)
hist(Q25, breaks = 200, col = "lightblue", main = "Histogram of Q25", xlab = "Q25")
boxplot(Q25, col = "lightblue", main = "Boxplot of Q25")
# It can be seen that there are a lot of outliers in Q25, we will remove them
Q1 <- quantile(Q25, 0.25)
Q3 <- quantile(Q25, 0.75)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR
outliers <- data_toclean$Q25 < lower_bound | data_toclean$Q25 > upper_bound
outlier_ids <- data_toclean$id[outliers]
cleaned_data <- Q25[!outliers]
boxplot(cleaned_data, col = "lightblue", main = "Boxplot of Q25 after removing outliers")
hist(cleaned_data, breaks = 200, col = "lightblue", main = "Histogram of Q25 after removing outliers", xlab = "Q25")
outlier_ids

# To analyse column Q75
Q75 <- data_toclean[,3]
summary(Q75)
hist(Q75, breaks = 200, col = "lightblue", main = "Histogram of Q75", xlab = "Q75")
boxplot(Q75, col = "lightblue", main = "Boxplot of Q75")
# It can be seen that there are a lot of outliers in Q75, we will remove them
Q1 <- quantile(Q75, 0.25)
Q3 <- quantile(Q75, 0.75)
IQR <- Q3 - Q1
lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR
outliers <- data_toclean$Q75 < lower_bound | data_toclean$Q75 > upper_bound
outlier_ids <- data_toclean$id[outliers]
cleaned_data <- Q75[!outliers]
boxplot(cleaned_data, col = "lightblue", main = "Boxplot of Q75 after removing outliers")
hist(cleaned_data, breaks = 200, col = "lightblue", main = "Histogram of Q75 after removing outliers", xlab = "Q75")
outlier_ids
