library(data.table)
library(jsonlite)
library(readr)
install.packages("stopwords")
install.packages("tm")
require(stringr)
require("tm")

tweets_df <- read_csv("D:/Faculdade/TCC e IC/tweets_df.csv", 
                      col_types = cols(truncated = col_skip(), retweet_count = col_skip(), 
                                       favorite_count = col_skip(), favorited = col_skip(), 
                                       retweeted = col_skip(), place_type = col_skip(), 
                                       place_full_name = col_skip(), country_code = col_skip(), 
                                       user_id_str = col_skip(), user_name = col_skip(), 
                                       user_screen_name = col_skip(), user_location = col_skip()))
N <- length(tweets_df$created_at)

mmm_to_mm <- function(mmm) {
  result = switch (mmm,
           "Jan" = "01",
           "Feb" = "02",
           "Mar" = "03",
           "Apr" = "04",
           "May" = "05",
           "Jun" = "06",
           "Jul" = "07",
           "Aug" = "08",
           "Sep" = "09",
           "Oct" = "10",
           "Nov" = "11",
           "Dec" = "12"
  )
  return(result)
}

#Stopwords from Neutral Language Tool Kit lexicon dictionary 
stop_words <- stopwords::stopwords("pt", source = "nltk")
#head(stop_words)

#Cleaning data
for (I in 1:N){
  #Aligns date in the right position
  tweets_df$created_at[I] <- paste(str_sub(tweets_df$created_at[I], 9, 10),
                                   mmm_to_mm(str_sub(tweets_df$created_at[I], 5, 7)),
                                   str_sub(tweets_df$created_at[I], 27, 30),sep="-",collapse=NULL)
  #Remove breaklines
  tweets_df$full_text[I] <- gsub("\r?\n|\r", " ", tweets_df$full_text[I])
  #Remove special charaters  
  tweets_df$full_text[I] <- gsub("[][!#$%()*,.:;<=>@^_`|~.{}]", " ", tweets_df$full_text[I])
  #Remove stopwords 
  tweets_df$full_text[I] <- removeWords(tolower(tweets_df$full_text[I]),stop_words)
  #Remove URLs
  str_remove_all(tweets_df$full_text[I], "(?:https |http).*:(.*)?([^/]+).*")
}
#Formats date in YYYY-MM-DD
tweets_df$created_at <- as.Date(as.character(tweets_df$created_at), format = "%d-%m-%Y")

head(tweets_df)

fwrite(tweets_df,"D:/Faculdade/TCC e IC/cleaned_tweets.csv")
