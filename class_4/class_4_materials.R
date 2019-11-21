# start with imdb
library(rvest)
library(jsonlite)
library(data.table)

# find any movie
t <- read_html('https://www.imdb.com/title/tt4154796/')

# get the json of it. 
json_data <- 
  fromJSON(
    t %>%
      html_nodes(xpath = "//script[@type='application/ld+json']")%>%
      html_text()
  )
# database publicly available: https://www.imdb.com/interfaces/
# you can make network analysis with the data
# more info about xpath: https://www.guru99.com/xpath-selenium.html
# https://www.youtube.com/watch?v=r_AP1I3T9yM
# I think you do not have to know how it works, most of the time it will be:
#just this two option:
#html_nodes(xpath = "//script[@type='application/ld+json']")
#html_nodes(xpath = "//script[@type='application/json']")


# payscale 
# https://www.payscale.com/research/US/Job    the base url
# finance   last/B means startswith B
t <- read_html('https://www.payscale.com/research/US/Job/Accounting-Finance/B')

# there is no a 'anchor'
rel_links <- 
t%>%
  html_nodes('.subcats__links__item')%>%
  html_attr('href')

my_links <- 
paste0('https://www.payscale.com', rel_links)


# task get all the jobs 
# write a function which return the data of the sallary save it into json. 
t <- read_html('https://www.payscale.com/research/US/Job=Product_Manager%2C_Software/Salary')
my_data  <- fromJSON(t %>%
                       html_nodes(xpath = "//script[@type='application/ld+json']")%>%
                       html_text()
)

my_data2  <- fromJSON(t %>%
                        html_nodes(xpath = "//script[@type='application/json']")%>%
                        html_text()
)

# yachts

my_url <- 'https://www.boatinternational.com/yachts-for-sale/lady-r--79963'
t <- read_html(my_url)

my_names <- 
  t %>% 
  html_nodes('.yacht-profilold-stat-block__title') %>% 
  html_text()

my_values <- 
  t %>% 
  html_nodes('.yacht-profilold-stat-block__value') %>% 
  html_text()

my_data <- data.frame('title'= my_names, 'values'= my_values)
spread(my_data, key = title, value = values)


# make a function of it

get_boat_info <- function(my_url) {
  
  #my_url <- 'https://www.boatinternational.com/yachts-for-sale/lady-r--79963'
  t <- read_html(my_url)
  
  my_names <- 
    t %>% 
    html_nodes('.yacht-profilold-stat-block__title') %>% 
    html_text()
  
  my_values <- 
    t %>% 
    html_nodes('.yacht-profilold-stat-block__value') %>% 
    html_text()
  
  my_data <- data.frame('title'= my_names, 'values'= my_values)
  # if you choose this task, you have to download the other informations found of the yachts
  
  return(spread(my_data, key = title, value = values))
  
}

my_boat_list <- c('https://www.boatinternational.com/yachts-for-sale/lady-r--79963', 'https://www.boatinternational.com/yachts-for-sale/aglaia--95303')

final_df <- 
  rbindlist(
    lapply(my_boat_list, get_boat_info)
    ,fill = T)
# fill= T make the rbind all the time, even if they do not have the same colomns. 



# for loop and list 
my_list <- list()

# very simply just write the letters one by one
for (my_letter in LETTERS) {
  print(my_letter)
}

# now fill to the list

for (my_letter in LETTERS) {
  print(my_letter)
  # my_list[[ # between this brackets you can paste a string or just write a string this will be the name of the value  ]]  <- than just send the value 
  my_list[['This is one capital letter']] <- my_letter
  
}
my_list
#it has just one becouse with every run we overvrite the value
# so lets create counter value and have paste it into the name

my_list <- list()
my_counter <- 1
for (my_letter in LETTERS) {
  print(my_letter)
  # my_list[[ # between this brackets you can paste a string or just write a string this will be the name of the value  ]]  <- than just send the value 
  my_list[[ paste0('The ', my_counter, ' letter is')   ]] <- my_letter
  # than increase the my_counter 
  my_counter <- my_counter+1
  
}
my_list


# one omore thing have an if statement if the counter will be ten than the value should be just 10
my_list <- list()
my_counter <- 1
for (my_letter in LETTERS) {
  if (my_counter ==10) {
    my_list[[ 'tenth element'  ]] <- 10
    my_counter <- my_counter+1
    
  }else{
  
  print(my_letter)
  # my_list[[ # between this brackets you can paste a string or just write a string this will be the name of the value  ]]  <- than just send the value 
  my_list[[ paste0('The ', my_counter, ' letter is')   ]] <- my_letter
  # than increase the my_counter 
  my_counter <- my_counter+1
  }
}
my_list




# the idea is that after reading the html create a list, put everything that you want into the list, than make a data.frame of the liist and it will just one simple line.
get_car_info <- function(my_url) {
  
  my_page <- read_html(my_url)
  # write put lets check if it has the data 
  #write_html(my_page, "t.html")
  
  # process with list and for loop
  
  my_car_info_list <- list()
  
  my_car_info_list[['type']] <- my_page%>% html_node('.no-gutter .breadcrumb') %>%html_text()
  my_car_info_list[['title']] <- my_page%>% html_node('h1') %>%html_text()
  my_car_info_list[['url']] <- my_url

  my_info_df <- 
    my_page%>%
    html_table() %>% 
    "[[" (1)
  
  str(my_info_df)
  names(my_info_df) <- c('key', 'value')
  for (i in c(1:nrow(my_info_df))) {
    if (my_info_df$key[i]==my_info_df$value[i]) {
      next # jost go to the next row
    }else{
      my_car_info_list[[my_info_df$key[i]]] <- my_info_df$value[i]
      
    }
  }
  
  return(data.frame(my_car_info_list))
}

my_urls <- c('https://www.hasznaltauto.hu/szemelyauto/ferrari/458/ferrari_458_italia_automata_afa-s_2019-ig_garancialis-10402024',
             'https://www.hasznaltauto.hu/szemelyauto/ford/s-max/ford_s-max_2_0_tdci_titanium_magyar_7_fos_teli_csomag_csak_ford_szervizben_szervizelt_-_digitalis_szervizk-15104139')

list_of_df <- lapply(my_urls, get_car_info)
final_df <- rbindlist(list_of_df, fill = T)

