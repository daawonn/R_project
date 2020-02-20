## 네이버 금융 크롤링

install.packages('rvest')
install.packages('R6')
install.packages('XML')

# 라이브러리불러오기
library(rvest)
library(R6)
library(XML)

stock_data <- NULL

for (i in 1:10){
  
  page <- 1
  url_base <- 'http://finance.naver.com/item/sise_day.nhn?code=005930&page='
  b <- paste(url_base, i, sep ='') %>%
    read_html()  %>%
    html_nodes('table') %>%
    .[1] %>%
    html_table()
  b2 <- b[[1]]
  b3 <- b2[!is.na(b2[,2]),]
  colnames(b3) <-c('날짜','종가','전일비','시가',	'고가',	'저가',	'거래량')
  
  stock_data <-rbind(stock_data,b3)
  
  cat("\n",i)
}

setwd("./")
write.csv(stock_data, "naver_stock.csv", row.names = F)


