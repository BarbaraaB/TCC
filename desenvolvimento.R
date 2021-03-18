install.packages("syuzhet")
install.packages('pander')
library(syuzhet)
library(readr)
library(tidyverse)

cleaned_tweets <- read_csv("D:/Faculdade/TCC e IC/cleaned_tweets.csv")
#only part of the base, for testing
cleaned_tweets <- slice_sample(cleaned_tweets, n = 1000, replace = FALSE)
N <- length(cleaned_tweets$created_at)

#extracts the feeling of every word from the tweet
sentiment <- get_nrc_sentiment(cleaned_tweets$full_text, language = "portuguese")

#dataframe of the tweet date + the extraction of emotions
sentiment_df <- bind_cols(cleaned_tweets[,"created_at"],sentiment)

#grouping the dataframe months together with the sum of emotions
sentiment_month <- sentiment_df %>% 
  group_by(mes = month(created_at, label = TRUE, abbr = TRUE)) %>% 
  summarise(across(.cols = anger:positive, sum))

#database on longer format for chart
sentiment_month_longer <- pivot_longer(sentiment_month, anger:positive)

#scatter plot
g <- ggplot(sentiment_month_longer)+geom_point(aes(x=mes, y=value, color = name))
ggsave("D:/Faculdade/TCC e IC/Imagens/grafico_dispers.png", g)