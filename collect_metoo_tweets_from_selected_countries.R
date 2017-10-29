# extract metoo trends (n = 100,000) from over the weekend from the selected capitals
###########################################################################################################
###########################################################################################################

setwd("~/metoo_trend")

install.packages("twitteR")
install.packages("ROAuth")
install.packages("httr")

library(twitteR)
library(ROAuth)
library(httr)
library(plyr)

api_key <- "xxx"
api_secret <- "xxx"
access_token <- "xxx"
access_token_secret <- "xxx"

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

##############################################################################################################
# Geocodes of the selected capitals
geocodes_of_sel_capitals <- read_delim("~/metoo_trend/-metoo/geocodes_of_the_selected_countries.txt", "\t", escape_double = FALSE, trim_ws = TRUE)
geocodes_of_sel_capitals$capital <- gsub(" " , "_" ,geocodes_of_sel_capitals$capital )

# cluster the capitals according to their continents
#asia <- geocodes_of_sel_capitals[(geocodes_of_sel_capitals$capital == "Beijing" | "New_Delhi" | "Jerusalem" | 
 #                                  "Islamabad" | "Bangkok" | "Tokyo"),]
asia <- subset(geocodes_of_sel_capitals , (capital == "Beijing" )| (capital == "New_Delhi" )|
                 (capital == "Jerusalem" )| (capital == "Islamabad" )| (capital == "Bangkok" )| (capital == "Tokyo"))
asia <- as.data.frame(asia)

africa <- subset(geocodes_of_sel_capitals , (capital == "Cairo") | (capital == "Nairobi") | (capital == "Pretoria"))
africa <- as.data.frame(africa)

australia <- subset(geocodes_of_sel_capitals , capital == "Canberra")
australia <- as.data.frame(australia)

samerica <- subset(geocodes_of_sel_capitals , (capital == "Brasilia") | (capital == "Bogota"))
samerica <- as.data.frame(samerica)

namerica <- subset(geocodes_of_sel_capitals , (capital == "Ottawa") | (capital == "Washington_DC"))
namerica <- as.data.frame(namerica)

not_europe <- rbind(asia , africa , australia , samerica , namerica)
europe <- geocodes_of_sel_capitals[!(geocodes_of_sel_capitals$capital %in% not_europe$capital),]
europe <- as.data.frame(europe)

########################################################################################################
# gather tweets from Africa from the list
########################################################################################################
tweet_count_africa <- c()
# Egypt
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="30.01,31.14,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_africa <- cbind(tweet_count_africa , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Egypt.txt" , append = T)
# Nairobi
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="1.17,36.48,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_africa <- cbind(tweet_count_africa , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Nairobi.txt" , append = T)
# S. Africa
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="25.44,28.12,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_africa <- cbind(tweet_count_africa , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Pretoria.txt" , append = T)

tweet_count <- t(tweet_count_africa)
rownames(tweet_count_africa) <- NULL
africa <- cbind(africa , tweet_count_africa)
colnames(africa) <- c("country" , "capital" , "latitude" , "longitude" , "tweet_count")

#################################################################################################################
# gather tweets from asia
#################################################################################################################
tweet_count_asia <- c()
# China
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="39.55,116.2,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_asia <- cbind(tweet_count_asia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Beijing.txt" , append = T)
# India
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="28.37,77.13,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_asia <- cbind(tweet_count_asia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_N_Delhi.txt" , append = T)
# Israel
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="31.71,35.1,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_asia <- cbind(tweet_count_asia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Israel.txt" , append = T)
# Pakistan
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="33.4,73.1,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_asia <- cbind(tweet_count_asia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Islamabad.txt" , append = T)
# Thailand
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="13.45,100.35,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_asia <- cbind(tweet_count_asia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Bangkok.txt" , append = T)
# Japan
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="35.6895,139.69,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_asia <- cbind(tweet_count_asia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Tokyo.txt" , append = T)

asia <- cbind(asia , t(tweet_count_asia))
colnames(asia) <- c("country" , "capital" , "latitude" , "longitude" , "tweet_count")

##################################################################################################################
# gather tweets from australasia
##################################################################################################################
tweet_count_australasia <- c()
# Australia
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="35.15,149.08,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_australasia <- cbind(tweet_count_australasia , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Canberra.txt" , append = T)

rownames(tweet_count_australasia) <- NULL
australia <- cbind(australia , t(tweet_count_australasia))
#australia <- australia[1,]
colnames(australia) <- c("country" , "capital" , "latitude" , "longitude" , "tweet_count")

##################################################################################################################
# gather tweets from S. America
##################################################################################################################
tweet_count_samerica <- c()
# Brazil
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="15.47,47.55,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_samerica <- cbind(tweet_count_samerica , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Brasilia.txt" , append = T)
# Colombia
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="4.34,74,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_samerica <- cbind(tweet_count_samerica , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Bogota.txt" , append = T)

samerica <- cbind(samerica , t(tweet_count_samerica))
colnames(samerica) <- c("country" , "capital" , "latitude" , "longitude" , "tweet_count")

####################################################################################################################
# gather tweets from N. America
####################################################################################################################
tweet_count_namerica <- c()
# Canada
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="45.27,75.42,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_namerica <- cbind(tweet_count_namerica , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Ottawa.txt" , append = T)
# United States of America
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="39.91,77.02,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_namerica <- cbind(tweet_count_namerica , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Washington.txt" , append = T)

namerica <- cbind(namerica , t(tweet_count_namerica))
colnames(namerica) <- c("country" , "capital" , "latitude" , "longitude" , "tweet_count")

###################################################################################################################
###################################################################################################################
# TODO: Add Europe dataset
# TODO: Add map analysis


####################################################################################################################
# gather tweets from Europe
####################################################################################################################
tweet_count_europe <- c()
# Austria
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="48.12,16.22,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Vienna.txt" , append = T)
# Belgium
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="50.51,4.21,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Brussels.txt" , append = T)
# Czech
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="50.05,14.22,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Prague.txt" , append = T)
# Denmark
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="55.41,12.34,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Copenhagen.txt" , append = T)
# Finland
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="60.15,25.03,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Helsinki.txt" , append = T)
# France
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="48.5,2.2,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Paris.txt" , append = T)
# Germany
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="52.3,13.25,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Berlin.txt" , append = T)
# Greece
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="37.58,23.46,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Athens.txt" , append = T)
# Hungary
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="47.29,19.05,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Budapest.txt" , append = T)
# Iceland
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="64.1,21.57,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Reykjavik.txt" , append = T)
# Ireland
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="53.21,6.15,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Dublin.txt" , append = T)
# Italy
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="41.54,12.29,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Rome.txt" , append = T)
# Netherland
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="59.55,10.45,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Oslo.txt" , append = T)
# Poland
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="52.13,21,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Warsaw.txt" , append = T)
# Portugal
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="38.42,9.1,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Lisbon.txt" , append = T)
# Romania
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="44.27,26.1,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Bucharest.txt" , append = T)
# Spain
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="40.25,3.45,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Madrid.txt" , append = T)
# Sweden
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="59.2,18.03,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Stockholm.txt" , append = T)
# Switzerland
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="46.57,7.28,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Bern.txt" , append = T)
# Turkey
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="39.57,32.54,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Ankara.txt" , append = T)
# Russia
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="55.45,37.35,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_Moscow.txt" , append = T)
# United Kingdom
tweets_metoo <- searchTwitter('#MeToo',n=100000,since='2017-10-25',geocode="21.36,0.005,800mi",resultType='recent')
feed_metto <- lapply(tweets_metoo , function(t) t$getText())
tweet_count <- length(tweets_metoo)
tweet_count_europe <- cbind(tweet_count_europe , tweet_count)
lapply(feed_metto , write , "recent_tweets_from_London.txt" , append = T)

europe <- cbind(europe , t(tweet_count_europe))
colnames(europe) <- c("country" , "capital" , "latitude" , "longitude" , "tweet_count")

###################################################################################################################
###################################################################################################################
# 