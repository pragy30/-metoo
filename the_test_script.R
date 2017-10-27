# fetch 1000 metoo hastags from all over UK from the past two days

setwd("~/metoo_trend")

install.packages("twitteR")
install.packages("ROAuth")
install.packages("httr")

library(twitteR)
library(ROAuth)
library(httr)

api_key <- "***"
api_secret <- "***"
access_token <- "***"
access_token_secret <- "***"

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

library(plyr)

# grab n=1000 metoo tweets from UK (geocode) for the last two days
tweets_metoo <- searchTwitter('#MeToo' , n=10000 , since='2017-10-24' , 
                                geocode='53.3811, 1.4701 ,800mi' , lang='en')
# read the tweets 
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
