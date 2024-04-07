file_path <- "C:/Users/13248/Desktop/train.csv"
voice <- read.csv(file_path)
head(voice)


#Q25
Q25_column <- voice$Q25
range(Q25_column)
#total num of rows = 12135

par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#hist of Q25
sqrt(length(Q25_column))
hist(Q25_column, breaks = 80, main = "Histogram of Q25", xlab = "Q25")
#impose a normal curve on the histogram
xpt = seq(0, 6644, by = 0.1)
n_den = dnorm(xpt, mean = mean(Q25_column), sd = sd(Q25_column))
ypt = n_den * length(Q25_column) * 100
lines(xpt, ypt, col = "red")

#log-transformation of Q25
Q25_log <- log(Q25_column)
# Filter out infinite or negative values
#length(Q25_log[is.finite(Q25_log) & Q25_log > 0]) = 12114
Q25_log <- Q25_log[is.finite(Q25_log) & Q25_log > 0]
hist(Q25_log, breaks = 80, main = "Histogram of log(Q25)", xlab = "log(Q25)")
range(Q25_log)
#impose a normal curve on the histogram
xpt = seq(5, 9, by = 0.01)
n_den = dnorm(xpt, mean = mean(Q25_log), sd = sd(Q25_log))
ypt = n_den * length(Q25_log) * 0.05
lines(xpt, ypt, col = "red")



par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
# QQplot of Q25
qqnorm(Q25_column)
qqline(Q25_column, col = "blue")
title("QQplot for Q25", line = 1)  # Place title on the first line

qqnorm(Q25_log)
qqline(Q25_log, col = "red")
title("QQplot for Q25-log", line = 1)  # Place title on the first line

par(mfrow = c(1, 1))  # Reset plotting layout to default



#shapiro test-sample must be less than 5000. Therefore, we will take a sample of 5000 for 100 times
pvalue = numeric(100)
for(i in 1:100){
  Q25_sample <- sample(Q25_log, 5000)
  shapiro.test(Q25_sample)
  pvalue[i] <- shapiro.test(Q25_sample)$p.value
}
pvalue > 0.05
#Therefore, the data is not normally distributed


#boxplot
par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#boxplot of Q25
boxplot(Q25_column, main = "Boxplot of Q25", xlab = "Q25")
#boxplot of log(Q25)
boxplot(median_log10000, main = "Boxplot of log(Q25)", xlab = "log(Q25)")
par(mfrow = c(1, 1))  # Reset plotting layout to default


#remove outliers(log transformation)
summary(Q25_log)
IQR(Q25_log)
sd(Q25_log)
outlr = c(abs(Q25_log - mean(Q25_log)) > 2 * sd(Q25_log))
outlr
#append the outliers and id to the data
Q25_log_with_id = cbind(Q25_log, c(1:length(Q25_log)), outlr)
colnames(Q25_log_with_id)[2] <- "id"
Q25_log_with_id

#record the id of the outliers
outliers_id <- Q25_log_with_id[Q25_log_with_id[, 3] == 1, 2]
outliers_id
#check: length(outliers_id) = 571

sum(outlr == TRUE) #number of outliers
sum(outlr == TRUE) > 0.05 * length(Q25_log)
#outliers are less than 5% of the data, Therefore, we can remove them
#final clean data(Q25_clean)
Q25_clean <- Q25_log_with_id[Q25_log_with_id[, 3] == 0, ]
Q25_clean 
#check: length(Q25_clean[, 1]) = 11543
