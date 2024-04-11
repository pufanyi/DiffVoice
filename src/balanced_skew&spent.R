file_path <- "/Users/Jenny/Desktop/MH3511/Project.../data/gender/balanced_train.csv"
voice <- read.csv(file_path)
head(voice)

MALE_COLOR <- rgb(0, 0, 1, 0.2)
FEMALE_COLOR <- rgb(1, 0, 0, 0.2)

male_data <- voice[voice$gender == "male", ]
female_data <- voice[voice$gender == "female", ]
head(male_data)
head(female_data)

visualize_data <- function(column) {
  # return(male_data[column])
  hist(male_data[[column]], col = MALE_COLOR, prob = TRUE, breaks = 80, border = "white", main = sprintf("Histogram and KDE of %s", column))
  hist(female_data[[column]], col = FEMALE_COLOR, prob = TRUE, add = TRUE, breaks = 80, border = "white")

  # Calculate and plot KDE for male data
  male_density <- density(male_data[[column]])
  lines(male_density, col = "blue", lwd = 2)

  # Calculate and plot KDE for female data
  female_density <- density(female_data[[column]])
  lines(female_density, col = "red", lwd = 2)

  legend("topright", legend = c("Male", "Female"), col = c("blue", "red"), lwd = 2, fill = c(MALE_COLOR, FEMALE_COLOR))
}

# skewness
visualize_data("skew")
qqnorm(male_data$skew)
qqline(male_data$skew, col = "red")
qqnorm(female_data$skew)
qqline(female_data$skew, col = "red")

# skewness not normally distributed, use Wilcoxon test to compare mean
wilcox.test(male_data$skew, female_data$skew, alt = "less")
# The p-value is less than 0.05, therefore, we would reject the null hypothesis that mean of dataset is the same

# sp.ent
visualize_data("sp.ent")
qqnorm(male_data$sp.ent)
qqline(male_data$sp.ent, col = "red")
qqnorm(female_data$sp.ent)
qqline(female_data$sp.ent, col = "red")

# sp.ent not normally distributed, use Wilcoxon test to compare mean
wilcox.test(male_data$sp.ent, female_data$sp.ent, alt = "less")
# The p-value is greater than 0.05, therefore, we would not reject the null hypothesis that mean of dataset is the same
