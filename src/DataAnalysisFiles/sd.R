file_path <- "C:/Users/13248/Desktop/train.csv"
voice <- read.csv(file_path)
head(voice)

#sd
sd_column <- voice$sd
range(sd_column)

par(mfrow = c(1, 3)) # Set up plotting layout with one row and two columns
#hist of sd
sqrt(length(sd_column))
hist(sd_column, breaks = 80, main = "Histogram of sd", xlab = "sd")
#impose a normal curve on the histogram
xpt = seq(402, 4203, by = 0.1)
n_den = dnorm(xpt, mean = mean(sd_column), sd = sd(sd_column))
ypt = n_den * length(sd_column) * 50
lines(xpt, ypt, col = "red")

#log-transformation of sd
sd_log <- log(sd_column)
hist(sd_log, breaks = 80, main = "Histogram of log(sd)", xlab = "log(sd)")
range(sd_log)
#impose a normal curve on the histogram
xpt = seq(5, 9, by = 0.01)
n_den = dnorm(xpt, mean = mean(sd_log), sd = sd(sd_log))
ypt = n_den * length(sd_log) * 0.05
lines(xpt, ypt, col = "red")


#log-transformation of sd
sd_log10000 <- log(sd_column + 10000)
hist(sd_log10000, breaks = 80, main = "Histogram of log(sd + 10000)", xlab = "log(sd)")
range(sd_log10000)
#impose a normal curve on the histogram
xpt = seq(9, 10, by = 0.01)
n_den = dnorm(xpt, mean = mean(sd_log10000), sd = sd(sd_log10000))
ypt = n_den * length(sd_log10000) * 0.005
lines(xpt, ypt, col = "red")

par(mfrow = c(1, 1))  # Reset plotting layout to default




par(mfrow = c(1, 3)) # Set up plotting layout with one row and two columns

# QQplot of sd
qqnorm(sd_column)
qqline(sd_column, col = "blue")
title("QQplot for sd", line = 1)  # Place title on the first line

qqnorm(sd_log)
qqline(sd_log, col = "red")
title("QQplot for sd-log", line = 1)  # Place title on the first line


qqnorm(sd_log10000)
qqline(sd_log10000, col = "red")
title("QQplot for sd-log+10000", line = 1)  # Place title on the first line

par(mfrow = c(1, 1))  # Reset plotting layout to default



#shapiro test-sample must be less than 5000. Therefore, we will take a sample of 5000 for 100 times
pvalue = numeric(100)
for(i in 1:100){
  sd_sample <- sample(sd_column, 5000)
  shapiro.test(sd_sample)
  pvalue[i] <- shapiro.test(sd_sample)$p.value
}
pvalue > 0.05
#Therefore, the data is not normally distributed


#boxplot
par(mfrow = c(1, 2)) # Set up plotting layout with one row and two columns
#boxplot of sd
boxplot(meanfreq_column, main = "Boxplot of meanfreq", xlab = "meanfreq")
#boxplot of log(sd)
boxplot(sd_log10000, main = "Boxplot of log(sd+10000)", xlab = "log(sd+10000)")
par(mfrow = c(1, 1))  # Reset plotting layout to default


#remove outliers(log transformation)
summary(sd_log10000)
IQR(sd_log10000)
sd(sd_log10000)
outlr = c(abs(sd_log10000 - mean(sd_log10000)) > 2 * sd(sd_log10000))
outlr
#append the outliers and id to the data
sd_log_with_id = cbind(sd_log10000, c(1:length(sd_log10000)), outlr)
colnames(sd_log_with_id)[2] <- "id"
sd_log_with_id

#record the id of the outliers
outliers_id <- sd_log_with_id[sd_log_with_id[, 3] == 1, 2]
outliers_id
#check: length(outliers_id)

sum(outlr == TRUE) #number of outliers
sum(outlr == TRUE) > 0.05 * length(sd_log10000)
#outliers are less than 5% of the data, Therefore, we can remove them
#final clean data(meanfreq_clean)
sd_clean <- sd_log_with_id[sd_log_with_id[, 3] == 0, ]
sd_clean 

