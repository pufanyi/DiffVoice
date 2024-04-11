voice <- read.csv("C:/Users/ASUS/MH3511/data/gender/balanced_train.csv", header = TRUE)
str(voice)
str(voice[voice$gender=="male",])
str(voice[voice$gender=="female",])

shapiro.test(voice$meanfun)

# Histplot + Impose a normal curve on the histogram
par(mfrow = c(1, 2))
md <- voice$Q25
hist(md, breaks = as.integer(sqrt(length(md))), main = "Histogram of MeanDom", xlab = "MeanDom")
xpt = seq(min(md), max(md), by = 0.001)
n_den = dnorm(xpt, mean = mean(md), sd = sd(md))
ypt = n_den * length(md) * ((max(md)-min(md))/as.integer(sqrt(length(md))))
lines(xpt, ypt, col = "red")
shapiro.test(md)

md = sqrt(md)
hist(md, breaks = as.integer(sqrt(length(md))), main = "Histogram of MeanDom", xlab = "MeanDom")
xpt = seq(min(md), max(md), by = 0.001)
n_den = dnorm(xpt, mean = mean(md), sd = sd(md))
ypt = n_den * length(md) * ((max(md)-min(md))/as.integer(sqrt(length(md))))
lines(xpt, ypt, col = "red")
shapiro.test(md)

qqnorm(md)
qqline(md, col="blue")

boxplot(md, main="Boxplot of MeanDom") 

shapiro.test(voice$meanfun)

#meandom 
md <- voice$meandom

# A summary of the variable is shown
summary(md)
length(md)
null_counts <- sum(is.na(md))
print(null_counts)

# Set up plotting layout with one row and two columns
par(mfrow = c(1, 2)) 

# Histplot + Impose a normal curve on the histogram
hist(md, breaks = as.integer(sqrt(length(md))), main = "Histogram of MeanDom", xlab = "MeanDom")

xpt = seq(min(md), max(md), by = 0.001)
n_den = dnorm(xpt, mean = mean(md), sd = sd(md))
ypt = n_den * length(md) * ((max(md)-min(md))/as.integer(sqrt(length(md))))
lines(xpt, ypt, col = "red")

qqnorm(md)
qqline(md, col="blue")

boxplot(md, main="Boxplot of MeanDom") 

# Apply square root transform
sqrt_md = sqrt(md)
hist(sqrt_md, breaks = as.integer(sqrt(length(sqrt_md))), main = "Histogram of Sqrt_TransformMeanDom", xlab = "MeanDom")
xpt = seq(min(sqrt_md), max(sqrt_md), by = 0.001)
n_den = dnorm(xpt, mean = mean(sqrt_md), sd = sd(sqrt_md))
ypt = n_den * length(sqrt_md) * ((max(sqrt_md)-min(sqrt_md))/as.integer(sqrt(length(sqrt_md))))
lines(xpt, ypt, col = "red")

qqnorm(sqrt_md)
qqline(sqrt_md, col="blue")

boxplot(sqrt_md, main="Boxplot of Sqrt_TransformMeanDom") 

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# mindom
mindom <- voice$mindom

summary(mindom)
length(mindom)

# Set up plotting layout with one row and two columns
par(mfrow = c(1, 2)) 

# Histplot + Impose a normal curve on the histogram
hist(mindom, breaks = as.integer(sqrt(length(mindom))), main = "Histogram of MinDom", xlab = "MinDom")

xpt = seq(min(mindom), max(mindom), by = 0.000001)
n_den = dnorm(xpt, mean = mean(mindom), sd = sd(mindom))
ypt = n_den * length(mindom) * ((max(mindom)-min(mindom))/as.integer(sqrt(length(mindom))))
lines(xpt, ypt, col = "red")

qqnorm(mindom)
qqline(mindom, col="blue")

boxplot(mindom, main="Boxplot of MinDom") 

# Apply log transform
log_mindom = log(mindom)
hist(log_mindom, breaks = as.integer(sqrt(length(log_mindom))), main = "Histogram of Log_TransformMinDom", xlab = "MinDom")
xpt = seq(min(log_mindom), max(log_mindom), by = 0.000001)
n_den = dnorm(xpt, mean = mean(log_mindom), sd = sd(log_mindom))
ypt = n_den * length(log_mindom) * (max(log_mindom)-min(log_mindom))/as.integer(sqrt(length(log_mindom)))
lines(xpt, ypt, col = "red")


# Apply square root transform
sqrt_mindom = sqrt(mindom)
hist(sqrt_mindom, breaks = as.integer(sqrt(length(sqrt_mindom))), main = "Histogram of Sqrt_TransformMinDom", xlab = "MinDom")
xpt = seq(min(sqrt_mindom), max(sqrt_mindom), by = 0.001)
n_den = dnorm(xpt, mean = mean(sqrt_mindom), sd = sd(sqrt_mindom))
ypt = n_den * length(sqrt_mindom) * ((max(sqrt_mindom)-min(sqrt_mindom))/as.integer(sqrt(length(sqrt_mindom))))
lines(xpt, ypt, col = "red")

sqrt_mindom = sqrt(sqrt_mindom)
hist(sqrt_mindom, breaks = as.integer(sqrt(length(sqrt_mindom))), main = "Histogram of Sqrt_TransformMinDom", xlab = "MinDom")
xpt = seq(min(sqrt_mindom), max(sqrt_mindom), by = 0.001)
n_den = dnorm(xpt, mean = mean(sqrt_mindom), sd = sd(sqrt_mindom))
ypt = n_den * length(sqrt_mindom) * ((max(sqrt_mindom)-min(sqrt_mindom))/as.integer(sqrt(length(sqrt_mindom))))
lines(xpt, ypt, col = "red")

sqrt_mindom = sqrt(sqrt_mindom)
hist(sqrt_mindom, breaks = as.integer(sqrt(length(sqrt_mindom))), main = "Histogram of Sqrt_TransformMinDom", xlab = "MinDom")
xpt = seq(min(sqrt_mindom), max(sqrt_mindom), by = 0.001)
n_den = dnorm(xpt, mean = mean(sqrt_mindom), sd = sd(sqrt_mindom))
ypt = n_den * length(sqrt_mindom) * ((max(sqrt_mindom)-min(sqrt_mindom))/as.integer(sqrt(length(sqrt_mindom))))
lines(xpt, ypt, col = "red")

qqnorm(sqrt_mindom)
qqline(sqrt_mindom, col="blue")

boxplot(sqrt_mindom, main="Boxplot of Sqrt_TransformMinDom")


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# maxdom
maxdom <- voice$maxdom

summary(maxdom)
length(maxdom)

# Set up plotting layout with one row and two columns
par(mfrow = c(1, 2)) 

# Histplot + Impose a normal curve on the histogram
hist(maxdom, breaks = as.integer(sqrt(length(maxdom))), main = "Histogram of MaxDom", xlab = "MaxDom")

xpt = seq(min(maxdom), max(maxdom), by = 5)
n_den = dnorm(xpt, mean = mean(maxdom), sd = sd(maxdom))
ypt = n_den * length(maxdom) * ((max(maxdom)-min(maxdom))/as.integer(sqrt(length(maxdom))))
lines(xpt, ypt, col = "red")

qqnorm(maxdom)
qqline(maxdom, col="blue")

boxplot(maxdom, main="Boxplot of MaxDom") 

# Apply log transform
log_maxdom = log(maxdom+3.5)
hist(log_maxdom, breaks = as.integer(sqrt(length(log_maxdom))), main = "Histogram of Log_TransformMaxDom", xlab = "MaxDom")
xpt = seq(min(log_maxdom), max(log_maxdom), by = 0.001)
n_den = dnorm(xpt, mean = mean(log_maxdom), sd = sd(log_maxdom))
ypt = n_den * length(log_maxdom) * ((max(log_maxdom)-min(log_maxdom))/as.integer(sqrt(length(log_maxdom))))
lines(xpt, ypt, col = "red")

qqnorm(log_maxdom)
qqline(log_maxdom, col="blue")

# Apply sqrt transform
sqrt_maxdom = sqrt(maxdom)
hist(sqrt_maxdom, breaks = as.integer(sqrt(length(sqrt_maxdom))), main = "Histogram of Sqrt_TransformMaxDom", xlab = "MaxDom")
xpt = seq(min(sqrt_maxdom), max(sqrt_maxdom), by = 0.001)
n_den = dnorm(xpt, mean = mean(sqrt_maxdom), sd = sd(sqrt_maxdom))
ypt = n_den * length(sqrt_maxdom) * ((max(sqrt_maxdom)-min(sqrt_maxdom))/as.integer(sqrt(length(sqrt_maxdom))))
lines(xpt, ypt, col = "red")

qqnorm(sqrt_maxdom)
qqline(sqrt_maxdom, col="blue")

qqnorm(log_maxdom)
qqline(log_maxdom, col="blue")

boxplot(sqrt_maxdom, main = "Boxplot of Sqrt_TransformMaxDom")
boxplot(log_maxdom, main = "Boxplot of Log_TransformMaxDom")


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# dfrange
dfr <- voice$dfrange

summary(dfr)
length(dfr)

# Set up plotting layout with one row and two columns
par(mfrow = c(1, 2))

# Histplot + Impose a normal curve on the histogram
hist(dfr, breaks = as.integer(sqrt(length(dfr))), main = "Histogram of DfRange", xlab = "DfRange")
xpt = seq(min(dfr), max(dfr), by = 0.1)
n_den = dnorm(xpt, mean = mean(dfr), sd = sd(dfr))
ypt = n_den * length(dfr) * ((max(dfr)-min(dfr))/as.integer(sqrt(length(dfr)))
lines(xpt, ypt, col = "red")

qqnorm(dfr)
qqline(dfr, col="blue")

boxplot(dfr, main="Boxplot of DfRange")

range(dfr)

# Apply log transform
log_dfr = log(dfr)
hist(log_dfr, breaks = as.integer(sqrt(length(log_dfr))), main = "Histogram of Log_TransformDfRange", xlab = "DfRange")
xpt = seq(min(log_dfr), max(log_dfr), by = 0.1)
n_den = dnorm(xpt, mean = mean(log_dfr), sd = sd(log_dfr))
ypt = n_den * length(log_dfr) * (max(log_dfr)-min(log_dfr))/as.integer(sqrt(length(log_dfr)))
lines(xpt, ypt, col = "red")

qqnorm(log_dfr)
qqline(log_dfr, col="blue")

# Apply sqrt transform
sqrt_dfr = sqrt(dfr)
hist(sqrt_dfr, breaks = as.integer(sqrt(length(sqrt_dfr))), main = "Histogram of Sqrt_TransformDfRange", xlab = "DfRange")
xpt = seq(min(sqrt_dfr), max(sqrt_dfr), by = 0.1)
n_den = dnorm(xpt, mean = mean(sqrt_dfr), sd = sd(sqrt_dfr))
ypt = n_den * length(sqrt_dfr) * (max(sqrt_dfr)-min(sqrt_dfr))/as.integer(sqrt(length(sqrt_dfr)))
lines(xpt, ypt, col = "red")

qqnorm(sqrt_dfr)
qqline(sqrt_dfr, col="blue")

qqnorm(log_dfr)
qqline(log_dfr, col="blue")

boxplot(sqrt_dfr, main = "Boxplot of Sqrt_TransformDfRange")
boxplot(log_dfr, main = "Boxplot of Log_TransformDfRange")


