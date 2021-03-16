install.packages("syuzhet")
library(syuzhet)
library(readr)


cleaned_tweets <- read_csv("D:/Faculdade/TCC e IC/cleaned_tweets_10.csv")
N <- length(cleaned_tweets$created_at)

#text_tokens <- get_tokens(cleaned_tweets$full_text)

sentiment <- get_nrc_sentiment(cleaned_tweets$full_text, language = "portuguese")
sentiment
text_tokens
