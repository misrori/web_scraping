install.packages('rvest')
install.packages('data.table')



library(rvest)
library(data.table)
# geting started

my_page <- 'https://www.itworld.com/search?query=big+data&t=2'
t <- read_html(my_page)
#check if it has the data that we want
write_html(t, 't.html')

# get titles
my_titles <- 
  t %>%
  html_nodes('h3 a')%>%
  html_text()


my_summary <- 
  t %>%
  html_nodes('.summary')%>%
  html_text()


my_topic <- 
  t %>%
  html_nodes('.taxo .edition-link-url')%>%
  html_text()


my_writer <- 
  t %>%
  html_nodes('.byline')%>%
  html_text()


# removing the leading and trailing spaces
my_writer <- trimws(my_writer)



strsplit(my_writer,',', fixed = T)

my_article_writers <- 
  unlist(
    lapply(my_writer, function(x){
      trimws(strsplit(x, ',', fixed = T)[[1]][1])
    })
  )


my_article_date <- 
  unlist(
    lapply(my_writer, function(x){
      trimws(strsplit(x, ',', fixed = T)[[1]][2])
    })
  )


my_article_date <-  as.Date(my_article_date, format = '%m/%d/%y')
#https://www.statmethods.net/input/dates.html

my_links <- 
  paste0('https://www.itworld.com',
         t %>%
           html_nodes('h3 a')%>%
           html_attr('href')
         
  )

View(data.frame('title'= my_titles, 'summary'= my_summary, 'writer'= my_article_writers, 'Date'= my_article_date, 'link'=my_links ))

# write function of it which need just the link input
get_info_of_itworld  <- function(my_page) {
  
  t <- read_html(my_page)
  #check if it has the data that we want
  write_html(t, 't.html')
  
  # get titles
  my_titles <- 
    t %>%
    html_nodes('h3 a')%>%
    html_text()
  
  
  my_summary <- 
    t %>%
    html_nodes('.summary')%>%
    html_text()
  
  
  my_topic <- 
    t %>%
    html_nodes('.taxo .edition-link-url')%>%
    html_text()
  
  
  my_writer <- 
    t %>%
    html_nodes('.byline')%>%
    html_text()
  
  
  # removing the leading and trailing spaces
  my_writer <- trimws(my_writer)
  
  
  
  strsplit(my_writer,',', fixed = T)
  
  my_article_writers <- 
    unlist(
      lapply(my_writer, function(x){
        trimws(strsplit(x, ',', fixed = T)[[1]][1])
      })
    )
  
  
  my_article_date <- 
    unlist(
      lapply(my_writer, function(x){
        trimws(strsplit(x, ',', fixed = T)[[1]][2])
      })
    )
  
  
  my_article_date <-  as.Date(my_article_date, format = '%m/%d/%y')
  #https://www.statmethods.net/input/dates.html
  
  my_links <- 
    paste0('https://www.itworld.com',
           t %>%
             html_nodes('h3 a')%>%
             html_attr('href')
           
    )
  
  return(data.frame('title'= my_titles, 'summary'= my_summary, 'writer'= my_article_writers, 'Date'= my_article_date, 'link'=my_links ))
  
  
}


my_res <- get_info_of_itworld('https://www.itworld.com/search?query=big+data&t=2&start=60')


seq(from=70, to=90, by=10)

my_urls <- paste0('https://www.itworld.com/search?contentType=article%2Cresource&query=big+data&start=',seq(from=90, to=100, by=10) )


my_res <- lapply(my_urls, get_info_of_itworld)

res_df <- rbindlist(my_res)


#get tables of html
t <- read_html('https://coinmarketcap.com')
write_html(t, 't.html')

coins <- 
t%>%
  html_table()

my_coin_df <- coins[[1]]

my_coin_df$Price <- as.numeric(sub('$','',my_coin_df$Price, fixed = T))












