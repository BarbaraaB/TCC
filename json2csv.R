library(readr)
library(data.table)
library(jsonlite)

linhas <-readLines("C:/Users/User/Documents/Downloads/Nova_pasta/tts_hy.jsonl", encoding="UTF-8")
lst <- list()
N <- length(linhas)

for (I in 1:N) {
  df <- parse_json(linhas[I],simplifyVector = TRUE)
  df2 <- df[c("created_at","id_str", "full_text","truncated","retweet_count","favorite_count","favorited","retweeted","lang")]
  df_disp_txt_range <- data.frame(disp_txt_range_start = df$display_text_range[1],
                                  disp_txt_range_end = df$display_text_range[2])
  if (is.null(df$place)) {
    df_place <- data.frame(place_type=NA,
                           place_name=NA,
                           place_full_name=NA,
                           country_code=NA,
                           country=NA)
  } else {
    df_place <- df$place[c("place_type","name","full_name","country_code","country")]
    names(df_place) <- c("place_type","place_name","place_full_name","country_code","country")
  }
  if(is.null(df$user)) {
    df_user <- data.frame(user_id_str=NA,
                          user_name=NA,
                          user_screen_name=NA,
                          user_location=NA)
  } else {
    df_user <- df$user[c("id_str","name","screen_name","location")]
    names(df_user) <- c("user_id_str","user_name","user_screen_name","user_location")
  }
  df2 <- append(df2,df_place)
  df2 <- append(df2, df_user)
  df2 <- append(df2, df_disp_txt_range)
  lst <- append(lst,list(df2))
  rm(list = c("df","df2","df_place","df_user","df_disp_txt_range"))
}
X <- data.table::rbindlist(lst) 
assign("tweets_df",X)
fwrite(tweets_df,"C:/Users/User/Documents/Downloads/Nova_pasta/tweets_df.csv")
