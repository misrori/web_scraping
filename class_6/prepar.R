
library(XML)
library(data.table)
t<-xmlToList('/home/mihaly/R_codes/web_scraping/class_6/banks.txt')
my_df <- 
rbindlist(lapply( t$Body$GetAtmsAndBranchesResponse$GetAtmsAndBranchesResult$entity_list_response, function(x){
 return(cbind(data.frame(x$attributes[x$attributes!='NULL']), data.frame(x$location[x$location!='NULL']), data.frame(x$coordinates[x$coordinates!='NULL'])))
  
}), fill = T)
my_df$center.lon <- as.numeric(substring(my_df$center.lon,1,9))*10
my_df$center.lat <- as.numeric(substring(my_df$center.lat,1,9))*10

saveRDS(my_df, 'clean_data.rds')

leaflet(my_df) %>% addTiles() %>%
  addMarkers(~as.numeric(center.lon), ~as.numeric(center.lat),
             popup = ~paste(sep = "<br/>", as.character(varos), as.character(megye) )) #label = ~as.character(varoscity)
