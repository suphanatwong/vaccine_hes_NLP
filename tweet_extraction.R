### HW 7 ###

library(rtweet)
library(dplyr)
install.packages("xlsx")

library(xlsx)


Thai = "13.75,100.5, 100mi"

covid <- search_tweets("??????", n=10000, include_rts=T, geocode =Thai)
covid1 <- as.data.frame(covid)

covid1 <- covid[,c(3:17)]
write.csv(covid1, "D:/MSinHI/HINF/Spring 2021/HINF-5531 Data Analysis in Health Care/HW/covid.csv")

write_as_csv2 <- function(x, file_name,
                          prepend_ids = TRUE,
                          na = "",
                          fileEncoding = "UTF-8", append=FALSE) {
  ## to minimize rounding
  op <- options()
  on.exit(options(op))
  options(scipen = 14, digits = 22)
  
  ## validate inputs
  stopifnot(is.data.frame(x), is.character(file_name), length(file_name) == 1L)
  if (!grepl("\\.csv$", file_name)) {
    file_name <- paste0(file_name, ".csv")
  }
  ## flatten data
  x <- flatten(x)
  if (prepend_ids) {
    x <- prepend_ids(x)
  }
  utils::write.table(x, file_name, row.names = FALSE, na = na,
                     fileEncoding = fileEncoding, append=append, sep=",", dec=".", qmethod="double")
  
  # or
  # readr::write_csv(x, file_name, append =  append)
}
environment(write_as_csv2) <- asNamespace("rtweet")

write_as_csv2(covid, "D:/real_gold.csv", append =  TRUE)

write.xlsx(covid, "D:/real_gold.xlsx", sheetName = "Sheet1", 
           col.names = TRUE, row.names = TRUE, append = FALSE)
