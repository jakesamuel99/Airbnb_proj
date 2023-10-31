library(data.table)
library(dplyr)
library(tidyverse)
library(readxl)
lisitngs <- read_excel("newair1.xlsx")
parsed_amenities<-listings$amenities%>% 
  sub("^\\{(.*)\\}$", "\\1\n", x =  .)%>%lapply(function(x) names(read_csv(x)))
df1 <-
  unique(unlist(parsed_amenities)) %>% 
  .[!grepl("translation missing", .)] %>% 
  setNames(., .) %>% 
  lapply(function(x) vapply(parsed_amenities, "%in%",1, x = x)) %>% 
  as_data_frame()
df1