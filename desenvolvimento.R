install.packages("quanteda") 
install.packages("syuzhet")
library(syuzhet)
library(readr)


cleaned_tweets <- read_csv("D:/Faculdade/TCC e IC/cleaned_tweets_10.csv")
N <- length(cleaned_tweets$created_at)

#text_tokens <- quanteda::tokens(cleaned_tweets$full_text)

text_tokens <- get_tokens(cleaned_tweets$full_text)

test <- "im very sad"
text_tokens <- get_tokens(test)
sentiment <- get_nrc_sentiment(text_tokens)
sentiment
text_tokens
