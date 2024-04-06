voice <- read.csv("data/train.csv", header = TRUE)
str(voice)

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

# Apply square root transform
sqrt_md = sqrt(md)
hist(sqrt_md, breaks = as.integer(sqrt(length(sqrt_md))), main = "Histogram of Sqrt_TransformMeanDom", xlab = "MeanDom")
xpt = seq(min(sqrt_md), max(sqrt_md), by = 0.001)
n_den = dnorm(xpt, mean = mean(sqrt_md), sd = sd(sqrt_md))
ypt = n_den * length(sqrt_md) * ((max(sqrt_md)-min(sqrt_md))/as.integer(sqrt(length(sqrt_md))))
lines(xpt, ypt, col = "red")

qqnorm(md)
qqline(md, col="blue")

qqnorm(sqrt_md)
qqline(sqrt_md, col="blue")

boxplot(md) 
boxplot(sqrt_md) 


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

qqnorm(md)
qqline(md, col="blue")

qqnorm(sqrt_md)
qqline(sqrt_md, col="blue")

boxplot(md) 
boxplot(sqrt_md)
