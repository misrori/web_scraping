# task get all the jobs in glassdor

library(jsonlite)
my_st <- 'it'
my_st <- gsub(' ', '+',my_st, fixed = T)

fromJSON(paste0('https://www.glassdoor.com/searchsuggest/typeahead?source=Salary&version=New&input=',my_st,'&rf=full'))


my_st <- 'Data A'
my_st <- gsub(' ', '+',my_st, fixed = T)

fromJSON(paste0('https://www.glassdoor.com/searchsuggest/typeahead?source=Salary&version=New&input=',my_st,'&rf=full'))

# create 3 letter combos
my_all_combo <- NULL
for (my_first in letters) {
  for (my_second in letters) {
    for (my_third in letters) {
      t_letters <- paste0(my_first, my_second, my_third, collapse = '')
      my_all_combo<- c(my_all_combo, t_letters)
    }
  }
}
          

library(rvest)
t <- read_html('https://www.glassdoor.com/Salary/Lockheed-Martin-Salaries-E404.htm')
write_html(t, 't.html')





t <- read_html('https://www.glassdoor.com/Salaries/budapest-salary-SRCH_IL.0,8_IM1115.htm')

t %>% html_nodes('.padBotSm a') %>% html_attr('href')

t <- read_html('https://www.glassdoor.com/Salaries/budapest-salary-SRCH_IL.0,8_IM1115_IP2.htm')

my_links<- paste0('https://www.glassdoor.com', t %>% html_nodes('.padBotSm a') %>% html_attr('href'))

ge <- read_html(my_links[1])

write_html(ge, 't.html')

get_json_values <- function(my_page , my_look_for, ful_name) {
  #my_look_for <- 'initialState'
  #ful_name <- 'window.__initialState__ = '
  script_list <- 
    my_page %>%
    html_nodes("script")
  
  for (i in script_list) {
    my_t <- i %>% 
      html_text()
    my_t_h <- substring(my_t, 1,100)
    #print(my_t)
    if(grepl(my_look_for, my_t_h)){
      return(fromJSON(gsub('\\</b>', '',gsub('\\<b>', '', gsub('}};', '}}', substring(my_t, nchar(ful_name)+1), fixed = T), fixed = T), fixed = T)))
    }
  }
}

init_json <- get_json_values(ge, '__initialState__', 'window.__initialState__ =')
data_json <- get_json_values(ge, 'APOLLO_STATE', 'window.__APOLLO_STATE__=')



#https://texttospeech.io/

my_text <- 'Hello Dear friends this is a test.'

my_link <- URLencode(paste0('https://code.responsivevoice.org/getvoice.php?t=',my_text, '&tl=hu&sv=g1&vn=&pitch=0.5&rate=0.5&vol=1' ))

download.file(my_link, 'first.mp3')


library(rvest)
my_value <- "H"
t <- read_html(paste0('http://eoddata.com/stocklist/NYSE/',my_value,'.htm'))
t %>% html_table( fill = T)


write_html(t, 't.html')









