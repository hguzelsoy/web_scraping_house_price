library(rvest)
library(tidyverse)

results <- data.frame()


for (page_num in 1:21) { 
  url <- paste0("website URL", page_num)
  
  page <- read_html(url)
  
  baslik <- page %>% 
    html_nodes("._1TNSG2 span") %>% 
    html_text()
  
  ilan_bilgileri <- page %>% 
    html_nodes("._2UELHn") %>% 
    html_text()
  
  fiyat <- page %>% 
    html_nodes("._2C5UCT > span") %>% 
    html_text()
  
  adres<- page %>% 
    html_nodes("._2wVG12 span") %>% 
    html_text()
  
  page_results <- data.frame(
    baslik, ilan_bilgileri, fiyat, adres
  )

  results <- bind_rows(results, page_results)
  
  Sys.sleep(3)
}

write_xlsx(results, "save it to a folder/name_of_the_district.xlsx")


