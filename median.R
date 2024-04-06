file_path <- "C:/Users/13248/Desktop/train.csv"
voice <- read.csv(file_path)
head(voice)


#median
median_column <- voice$median
range(median_column)
#total num of rows = 12135

par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#hist of median
sqrt(length(median_column))
hist(median_column, breaks = 80, main = "Histogram of median", xlab = "median")
#impose a normal curve on the histogram
xpt = seq(0, 8458, by = 0.1)
n_den = dnorm(xpt, mean = mean(median_column), sd = sd(median_column))
ypt = n_den * length(median_column) * 100
lines(xpt, ypt, col = "red")

#log-transformation of median
median_log <- log(median_column)
# Filter out infinite or negative values
median_log <- median_log[is.finite(median_log) & median_log > 0]

hist(median_log, breaks = 80, main = "Histogram of log(median)", xlab = "log(median)")
range(median_log)
#impose a normal curve on the histogram
xpt = seq(6, 10, by = 0.01)
n_den = dnorm(xpt, mean = mean(median_log), sd = sd(median_log))
ypt = n_den * length(median_log) * 0.05
lines(xpt, ypt, col = "red")

par(mfrow = c(1, 1))  # Reset plotting layout to default




par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns

# QQplot of meanfreq
qqnorm(median_column)
qqline(median_column, col = "blue")
title("QQplot for median", line = 1)  # Place title on the first line

qqnorm(median_log)
qqline(median_log, col = "red")
title("QQplot for median-log", line = 1)  # Place title on the first line


par(mfrow = c(1, 1))  # Reset plotting layout to default



#shapiro test-sample must be less than 5000. Therefore, we will take a sample of 5000 for 100 times
pvalue = numeric(100)
for(i in 1:100){
  median_sample <- sample(median_log10000, 5000)
  shapiro.test(median_sample)
  pvalue[i] <- shapiro.test(median_sample)$p.value
}
pvalue > 0.05
#Therefore, the data is not normally distributed


#boxplot
par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#boxplot of meanfreq
boxplot(median_column, main = "Boxplot of median", xlab = "median")
#boxplot of log(median)
boxplot(median_log10000, main = "Boxplot of log(median+10000)", xlab = "log(median+10000)")
par(mfrow = c(1, 1))  # Reset plotting layout to default


#remove outliers(log transformation)
summary(median_log10000)
IQR(median_log10000)
sd(median_log10000)
outlr = c(abs(median_log10000 - mean(median_log10000)) > 2 * sd(median_log10000))
outlr
#append the outliers and id to the data
median_log_with_id = cbind(median_log10000, c(1:length(median_log10000)), outlr)
colnames(median_log_with_id)[2] <- "id"
median_log_with_id

#record the id of the outliers
outliers_id <- median_log_with_id[median_log_with_id[, 3] == 1, 2]
outliers_id
#check: length(outliers_id)

sum(outlr == TRUE) #number of outliers
sum(outlr == TRUE) > 0.05 * length(median_log10000)
#outliers are less than 5% of the data, Therefore, we can remove them
#final clean data(meanfreq_clean)
median_clean <- median_log_with_id[median_log_with_id[, 3] == 0, ]
median_clean 
#check: length(median_clean[, 1])
