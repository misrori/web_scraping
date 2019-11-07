# warm up task 
#get the news, the summary, and the title into a dataframe
#https://www.economist.com/leaders/
library(rvest)
my_url <- 'https://www.economist.com/leaders/'

get_one_page <- function(my_url) {
t <- read_html(my_url)
my_titles <- 
t %>% 
  html_nodes('.flytitle-and-title__title')%>%
  html_text()
  
my_relative_link <- 
t %>% 
  html_nodes('.teaser')%>%
  html_nodes('a')%>%
  html_attr('href')

my_links <- paste0('https://www.economist.com/', my_relative_link)
my_teaser <-
t %>% 
  html_nodes('.teaser__text')%>%
  html_text()
#

return(data.frame('title'= my_titles, 'teaser'= my_teaser, 'link'= my_links))
#
}  

res <- get_one_page('https://www.economist.com/leaders/')
#

# create named list
my_first_list <- list('first'='first_text', 'second'= 42, 'my_mtcars'= mtcars)
str(my_first_list)
my_first_list$first

my_first_list <- list('first'='first_text', 'second'= 42, 'my_mtcars'= mtcars,
                      "more_things" =list('my_letters'= letters, "my_hist"= hist(1:100) ))

#
getwd()

# game of thrones download

for (my_id in c(1:20)) {
  print(my_id)
  my_url <- paste0('https://deathtimeline.com/', my_id, '.jpg')
  print(my_url)
  my_saving_path <- paste0('gameofthrones/', my_id, '.jpg')
  download.file(my_url, my_saving_path)
  print(my_saving_path)
}

lapply(letters,function(my_id){
  print(my_id)
})



for (my_del_id in 2:4) {
  file.remove(paste0('/home/mihaly/R_codes/web_scraping/gameofthrones/',my_del_id,'.jpg'))
}
file.remove('/home/mihaly/R_codes/web_scraping/gameofthrones/1.jpg')

coins <- fromJSON('https://coinpaprika.com/ajax/coins/',simplifyDataFrame = F)

myurl<-paste0("https://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/HU-sky/HUF/en-US/BUD-sky/Anywhere/","2020-02-01","/","2020-02-10","?apiKey=ah395258861593902161819075536914")
t <- fromJSON(myurl)
View(t$Quotes)
View(t$Places)

coins$ath$usd$updated_at$

  mtcars$gear


plot(my_first_list$more_things$my_hist)

nrow(my_first_list$my_mtcars)
sum(my_first_list$my_mtcars$hp)

library(jsonlite)

my_first_list <- list('first'='first_text', 'second'= 42, 'my_mtcars'= mtcars,
                      "more_things" =list('my_letters'= letters ))

toJSON(my_first_list)
toJSON(my_first_list,auto_unbox = T)
toJSON(my_first_list,auto_unbox = T, pretty = T)
write_json(my_first_list, 'my_first.json', auto_unbox = T, pretty = T)



my_death_2 <- fromJSON('https://deathtimeline.com/api/deaths?season=2')

my_death_list_2 <- fromJSON('https://deathtimeline.com/api/deaths?season=2', simplifyDataFrame = F)


get_one_season <- function(season_id) {
  my_url <- paste0('https://deathtimeline.com/api/deaths?season=', season_id)
  t_table <- fromJSON(my_url)
  return(t_table)
}
get_one_season(5)

my_death_list_of_df <-lapply(1:6, get_one_season) 

library(data.table)
final_df <- rbindlist(my_death_list_of_df)





# geting started with lists
my_list <- list('first'='my_first_string', 'second'=42, 'hundred'= c(1:100), my_mtc = mtcars, 'list_again' = list('some_more'= 'it is not complicated', 'one_plot' = hist(1:100))  )

my_list <- list('first'='my_first_string', 'second'=42, 'hundred'= c(1:100), my_mtc = mtcars, 'list_again' = list('some_more'= 'it is not complicated')  )


my_list$first
sum(cumsum(my_list$hundred))
sum(my_list$my_mtc$cyl)
my_list$list_again$one_plot


my_list <- list()

for (i in c(1:10)) {
  #my_list[[paste0('the element ', i, ' is: ')]] <- letters[i]  
  my_list[[paste0('element_', i, '_is')]] <- letters[i]  
}

my_list[['ten']] <- c(1:10) 

library(jsonlite)
toJSON(my_list) 
toJSON(my_list,auto_unbox = T)
toJSON(my_list,auto_unbox = T,pretty = T)
write_json(my_list , 'my_res.json', auto_unbox = T, pretty=T)

back_to_list <- fromJSON('my_res.json')
toJSON(mtcars)

coins <- fromJSON('https://coinpaprika.com/ajax/coins/')
my_base_data<-do.call(data.frame, coins)
coins$tags <- NULL
my_base_data<-do.call(data.frame, coins)





death <- fromJSON('https://deathtimeline.com/api/deaths?season=1', simplifyDataFrame = F)


for (i in c(1:12)) {
  my_url <- paste0('https://deathtimeline.com/',i,'.jpg')
  print(my_url)
  download.file(my_url, paste0('gameofthrones/',i,'.jpg'))
  
}




my_list
names(my_list)

paste0( unlist(my_list), collapse = "#")

length(paste( unlist(my_list)))


