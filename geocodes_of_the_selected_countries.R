# gathering geocodes for the capitals to be analyzed
capitals <- read_delim("~/metoo_trend/-metoo/capitals_to_gather_data_from.txt", sep="\t", escape_double = FALSE, trim_ws = TRUE)
world_capitals2 <- read_delim("~/metoo_trend/world_capitals2.txt", sep="\t", escape_double = FALSE, trim_ws = TRUE)

file_we_need <- world_capitals2[world_capitals2$country %in% capitals$country,]
# manually adding Russia, UK and Japan
file_we_need <- rbind(file_we_need, world_capitals2[153,] , world_capitals2[188,])
file_we_need <- file_we_need[-c(40,39),]
file_we_need[39,] <- c("Japan" , "Tokyo" , "35.6895" , "139.69")
write.table(file_we_need , "geocodes_of_the_selected_countries.txt" , row.names = F , quote = F , sep = "\t")
