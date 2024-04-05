features <- read.csv("MH3511/data/features.csv", header = TRUE)
features <- features[, !(names(features) %in% c("sentence", "id"))]
head(features, 5)