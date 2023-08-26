library(rvest)
library(tidyverse)

results_dikili<- data.frame()


for (page_num in 1:21) { 
  url <- paste0("https://www.emlakjet.com/satilik-konut/izmir-dikili/emlakcidan/", page_num)
  
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

  results_dikili <- bind_rows(results_dikili, page_results)
  
  Sys.sleep(3)
}

write_xlsx(results_dikili, "/Users/halitguzelsoy/Desktop/Web Scrapping R/emlakjet_izmir_dikili.xlsx")


