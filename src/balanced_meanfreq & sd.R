file_path <- "C:/Users/13248/Desktop/balanced_train.csv"
voice <- read.csv(file_path)
head(voice)

male_voice = voice[voice$gender == "male",]
male_meanfreq = male_voice$meanfreq
male_meanfreq

female_voice = voice[voice$gender == "female",]
female_meanfreq = female_voice$meanfreq
female_meanfreq

#F-test
#pvalue are the same < 0.05, different variances
var.test(male_meanfreq, female_meanfreq)
var.test(voice$meanfreq~voice$gender)

#t-test
#pvalue are the same > 0.05, same means
t.test(male_meanfreq, female_meanfreq)
t.test(voice$meanfreq~voice$gender)

#box-plot
boxplot(voice$meanfreq~voice$gender, main="Mean Frequency")
#histogram
par(mfrow = c(1, 2))
hist(male_meanfreq, main="Mean Frequency", xlab="Mean Frequency", col="lightblue", border="black")
hist(female_meanfreq, main="Mean Frequency", xlab="Mean Frequency", col="lightblue", border="black")
par(mfrow = c(1, 1))


