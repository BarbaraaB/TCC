install.packages("quanteda") 
library(readr)

cleaned_tweets <- read_csv("D:/Faculdade/TCC e IC/cleaned_tweets_10.csv")
N <- length(cleaned_tweets$created_at)

text_tokens <- quanteda::tokens(cleaned_tweets$full_text)

