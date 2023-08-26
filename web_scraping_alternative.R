library(httr)
library(magrittr)
library(stringr)
library(DataExplorer)
library(rvest)
library(tidyverse)
library(writexl)

house_price <- data.frame()

for (page_num in seq(0,950,50)) { 
  url <- paste0("paging ofset", page_num,"page number")
  
  headers <- c("User-Agent" = "MyScraper/1.0 (contact@email.com)")
  
  Sys.sleep(13)
  
  response <- GET(url, add_headers(headers))
  
  html <- content(response, "text")
  doc <- read_html(html)
  
  results_house_price <- doc %>% 
    html_nodes("#searchResultsTable") %>%
    html_table(fill=TRUE)
  results_housep <- as.data.frame(results_house_price)
  results_district <- bind_rows(results_housep, results_house_price)
  
}

# steps for cleaning data

names(results_house_price) <- results_house_price[1,]
names(results_house_price)

results_house_price <- results_house_price[c(-1),c(-1,-9)]

results_house_price <- results_house_price[-which(
  results_house_price$`Emlak Tipi` %in% 
    c("Siz de ilanınızın yukarıda yer almasını istiyorsanız tıklayın.",
      NA,
      "","Emlak Tipi")),]
glimpse(results_house_price)

results_house_price %<>% 
  mutate(Fiyat = str_remove_all(results_house_price$Fiyat, "TL"))

combined_results <- rbind(....)

#deleting duplicates

data <- unique(combined_results)

write_xlsx(data, "save it to a folder/data.xlsx")


