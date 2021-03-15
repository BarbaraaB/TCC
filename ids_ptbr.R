library(data.table)
install.packages('bit64')

# Loading data from txt
pre <- fread("C:/Users/User/Documents/Downloads/Nova_pasta/tts_hy.jsonl", sep = "\t", header= FALSE, fill=TRUE)

# getting tweets in pt-br
tt_in_br <- pre[pre$V4 == 'pt' & pre$V5 == 'BR']

# getting only Id's from dataframe
ids <- tt_in_br$V1

# writing data into csv file
write.table(ids, row.names=FALSE, col.names=FALSE,'C:/Users/User/Documents/Downloads/Nova_pasta/tts_36.csv')