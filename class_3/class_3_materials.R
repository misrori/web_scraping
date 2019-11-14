# GET & POST
# https://www.youtube.com/watch?v=UObINRj2EGY
#more of the http methods: https://www.youtube.com/watch?v=iYM2zFP3Zn0

library(httr)
library(jsonlite)
library(rvest)
library(tidyverse)
library(data.table)

# preactice and check if you can find the data source. The data is comming with json
# look for data in forbes rich list and biggest companies
# nasdaq
# https://www.usnews.com/best-colleges/rankings/national-universities
# look the json ranking in coinmarketcap
# bud.hu where the flights are going? 


# GET request
my_ans <- GET('https://www.economist.com/international/2019/11/12/banned-in-warfare-is-tear-gas-too-readily-used-to-control-crowds')
content(my_ans, 'text') # the text content is the answer what you get with the request. It can be json, html, xml etc.
my_page <- read_html(content(my_ans, 'text'))
# you can write out and check what is the page looks like. 
write_html(my_page, 't.html')


# use verbose(info=T) to get more information of your request
my_ans <- GET('https://www.economist.com/international/2019/11/12/banned-in-warfare-is-tear-gas-too-readily-used-to-control-crowds', verbose(info=T))



# process the Nasdaq data 

nasdaq_url <- 'https://www.nasdaq.com/api/v1/screener?page=3&pageSize=20'
my_ans <- GET(nasdaq_url)
# with more info
my_ans <- GET(nasdaq_url, verbose(info = T))
str(my_ans)

my_ans$content

my_resp_text <- content(my_ans, 'text')
# it is a json -> we are reading with fromjson. If it is an html -> use read_html
my_ans_data <- fromJSON(my_resp_text)
# the data object will be return as a df. Some of the column will be also df

# or you can just directly reading with fromjson
my_ans_data <- fromJSON(nasdaq_url)
my_ans_data$data$dividendData # you can see my_ans_data$data is a nested datafram(it has columns whist is dataframe itself.)

# use flatten=T parameter and the dataframe will not be nested. But if the column type is a list, it will remain a list. 
my_ans_data <- fromJSON(nasdaq_url, flatten = T)
# we can see that 2 column is list priceChartSevenDay and articles
my_ans_data$data$articles
# it is null it does not have values so delete
my_ans_data$data$articles <- NULL
 

#my_ans_data$data$priceChartSevenDay it is also a dataframe with seven observation for every ticker. we just want the price change. 
# we asign back the result into the original value

my_ans_data$data$priceChartSevenDay<-
  unlist(
    lapply(my_ans_data$data$priceChartSevenDay, function(x) {
      p<-x$price
      if(length(p)==0) { # or you can check with nrow(x)
        return(0)
      }else{
        price_change <- ((tail(p,1)/head(p,1))-1)*100
        return(price_change)
      }
    }
))

# now it is a df which has just vector columns
my_ans_data$data

#ok now we can put everything into a functin

get_one_page_of_nasdaq <- function(my_page_id) {
  print(my_page_id)
  t <- fromJSON(paste0('https://www.nasdaq.com/api/v1/screener?page=',my_page_id,'&pageSize=50'), flatten = T)
  t$data
  # delete articels
  t$data$articles <- NULL
  
  t$data$priceChartSevenDay
  
  t$data$priceChartSevenDay <- 
    unlist(
      lapply(t$data$priceChartSevenDay, function(x){
        if (nrow(x)==0) {
          return(0)
          
        }else{
          first <- x$price[1] # head(x$price, 1)
          last <- x$price[7] # tail(x$price, 1)
          price_change <- ((last/first)-1)*100
          return(price_change)
        }
        
      })
    )
  # t$data$priceChartSevenDay
  # str(t$data$priceChartSevenDay[[1]])
  return( t$data)
  
}

list_of_df <- lapply(1:5, get_one_page_of_nasdaq)

my_final_res <- rbindlist(list_of_df)

#
# check what happen if we write bigger pagesize. Is there a limit?
# TASK: write a function which does not have any intup variable and it will return with the  number of companies in Nasdaq (my_ans_data$count)
# find out the seq to download all the data. How much page have to be downloaded? 
# download all af the data save it with saverds, and with write.csv what is the difference in size


# if you do not want df-s of your json, you can use  simplifyDataFrame = F  it will return as a list
my_ans_data <- fromJSON(nasdaq_url, simplifyDataFrame = F)
# it is a list
my_ans_data$data[[1]]$dividendData$dividend



# POST demo
# eu fundings demo
# open the site: https://www.palyazat.gov.hu/tamogatott_projektkereso
# click to next page, find the data source 

my_b <- list("filter" = toJSON( list("where"=list("fejlesztesi_program_nev"="Széchenyi 2020"),"skip"="0","limit"=200000,"order"="konstrukcio_kod, palyazo_neve ASC" ),auto_unbox = T) )
t<- POST('https://pghrest.fair.gov.hu/api/tamogatott_proj_kereso/find2',  body = my_b, encode = 'json',  verbose(info=T))
my_data<- fromJSON(content(t, 'text'))
nrow(my_data)




# forbes list
# it return a nice datafram
bill <- fromJSON('https://www.forbes.com/ajax/list/data?year=2018&uri=billionaires&type=person')

# check what happen if you just use read_html
t <- read_html('https://www.forbes.com/billionaires/list/;')
write_html(t, 't.html')
# there is no data inside.


# try to copy any get or post request as cURL (chrome F12, network, load the page, right click any element than copy as cURL) paste it https://curl.trillworks.com/ and run the R commands. 
# also put the cURL command into terminal.
# https://curl.trillworks.com/


