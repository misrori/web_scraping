# lapply demo 
my_list <- c(1:10)

my_demo_fun <- function(x) {
  return(x^2)
}
lapply(my_list, my_demo_fun)
sapply(my_list, my_demo_fun)


unlist(lapply(my_list, my_demo_fun))



my_res<- 
lapply(letters, function(my_input){
  
  return(toupper(my_input))
} )

unlist(my_res)





unlist(
lapply(letters, function(x){
  
  return(paste0('the input letter is: ', toupper(x)))
})
)



# with multiple arguments
# https://stackoverflow.com/questions/14427253/passing-several-arguments-to-fun-of-lapply-and-others-apply
my_list <- c(1:10)

my_demo_fun <- function(x,y) {
  return((x+y)^2)
}

unlist(lapply(my_list, my_demo_fun, y=2))
