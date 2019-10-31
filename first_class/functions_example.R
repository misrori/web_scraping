# write a function which return random n rows of mtcars maximum n maximum can be 32
sample_mtcars <- function(n) {
  if (n>nrow(mtcars)) {
    return(paste0('The maximum number is: ',nrow(mtcars)   ))
  }
  selected_rows <- sample(c(1:nrow(mtcars)), n)
  return(mtcars[selected_rows,])
  #round(runif(1)*32)
  #nrow(mtcars)
}
sample_mtcars(30)



