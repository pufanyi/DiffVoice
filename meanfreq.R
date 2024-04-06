file_path <- "C:/Users/13248/Desktop/train.csv"
voice <- read.csv(file_path)
head(voice)
meanfreq_column <- voice$meanfreq
range(meanfreq_column)

par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#hist of meanfreq
sqrt(length(meanfreq_column))
hist(meanfreq_column, breaks = 80, main = "Histogram of meanfreq", xlab = "meanfreq")
#impose a normal curve on the histogram
xpt = seq(698, 7056, by = 0.1)
n_den = dnorm(xpt, mean = mean(meanfreq_column), sd = sd(meanfreq_column))
ypt = n_den * length(meanfreq_column) * 100
lines(xpt, ypt, col = "red")

#log-transformation of meanfreq
meanfreq_log <- log(meanfreq_column)
hist(meanfreq_log, breaks = 80, main = "Histogram of log(meanfreq)", xlab = "log(meanfreq)")
range(meanfreq_log)
#impose a normal curve on the histogram
xpt = seq(6, 9, by = 0.1)
n_den = dnorm(xpt, mean = mean(meanfreq_log), sd = sd(meanfreq_log))
ypt = n_den * length(meanfreq_log) * 0.05
lines(xpt, ypt, col = "red")

par(mfrow = c(1, 1))  # Reset plotting layout to default





par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns

# QQplot of meanfreq
qqnorm(meanfreq_column)
qqline(meanfreq_column, col = "blue")
title("QQplot for meanfreq", line = 1)  # Place title on the first line

qqnorm(meanfreq_log)
qqline(meanfreq_log, col = "red")
title("QQplot for meanfreq-log", line = 1)  # Place title on the first line

par(mfrow = c(1, 1))  # Reset plotting layout to default





#shapiro test-sample must be less than 5000. Therefore, we will take a sample of 5000 for 100 times
pvalue = numeric(100)
for(i in 1:100){
  meanfreq_sample <- sample(meanfreq_column, 5000)
  shapiro.test(meanfreq_sample)
  pvalue[i] <- shapiro.test(meanfreq_sample)$p.value
}
pvalue > 0.05
#Therefore, the data is not normally distributed



par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#boxplot of meanfreq
boxplot(meanfreq_column, main = "Boxplot of meanfreq", xlab = "meanfreq")
#boxplot of log(meanfreq)
boxplot(meanfreq_log, main = "Boxplot of log(meanfreq)", xlab = "log(meanfreq)")
par(mfrow = c(1, 1))  # Reset plotting layout to default


#remove outliers(log transformation)
summary(meanfreq_log)
IQR(meanfreq_log)
sd(meanfreq_log)
outlr = c(abs(meanfreq_log - mean(meanfreq_log)) > 2 * sd(meanfreq_log))
outlr
#append the outliers and id to the data
meanfreq_log_with_id = cbind(meanfreq_log, c(1:length(meanfreq_log)), outlr)
colnames(meanfreq_log_with_id)[2] <- "id"
meanfreq_log_with_id

#record the id of the outliers
outliers_id <- meanfreq_log_with_id[meanfreq_log_with_id[, 3] == 1, 2]
outliers_id
#check: length(outliers_id)

sum(outlr == TRUE) #number of outliers
sum(outlr == TRUE) > 0.05 * length(meanfreq_log)
#outliers are less than 5% of the data, Therefore, we can remove them
#final clean data(meanfreq_clean)
meanfreq_clean <- meanfreq_log_with_id[meanfreq_log_with_id[, 3] == 0, ]
meanfreq_clean 
