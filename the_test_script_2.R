# extract metoo trends (n = 1000) from Andorra 
# The most recent ones.
# Save the number of tweets and the tweets in a txt file

setwd("~/metoo_trend")

install.packages("twitteR")
install.packages("ROAuth")
install.packages("httr")

library(twitteR)
library(ROAuth)
library(httr)

api_key <- "xxx"
api_secret <- "xxx"
access_token <- "xxx"
access_token_secret <- "xxx"

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

library(plyr)

# world capital data file

# grab metoo tweets from the first 10 capitals on the list
# and extract how many from each capital

world_capitals2 <- world_capitals2[1:10,] # sav the first 10 
tweet_count <- c()
#for(i in 1:10){ # for loop not working with geocode
  tweets_metoo <- searchTwitter('#MeToo' , n=1000 , since='2017-10-25' , 
                               geocode="42.31,1.32,500mi" , resultType = 'recent') # Andorra
  #geocode="paste(world_capitals2[i,3], world_capitals2[i,4], sep=',')", lang='en')
  #geocode="34.2,69.11" , lang='en')
  #geocode="test[i,3],test[i,4]" , lang='en')
  feed_metto <- lapply(tweets_metoo , function(t) t$getText())
  tweet_count <- length(tweets_metoo)
  lapply(feed_metto , write , "recent_tweets-from_Andorra.txt" , append = T)
#}



world_capitals2$tweet_count <- cbind.data.frame(world_capitals2 , tweet_count)


  
  
