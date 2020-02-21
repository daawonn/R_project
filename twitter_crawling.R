install.packages('twitteR')
install.packages('ROAuth')
install.packages('base64enc')
install.packages('KoNLP')
install.packages('tm')

library(KoNLP)
library(dplyr)
library(stringr)
library(tm)
library(twitteR)
library(ROAuth)
library(base64enc)

consumerKey <-"xSPahWHsJFZEPXOEE6gizhOee"
consumerSecret <-"nPbeSen5opF3UhGeX0S02Tfm3HOY3HtuqyugrblEvlppOidhek"
accessToken <- "1230021665062453248-hbzF1NSIyD5yxGnp4V8rmLHR8PJSu5"
accessTokenSecret <- "xxCXc64w2NTWUtE8L27PcBJNRQWa8Bvi1yn1Ql7Cgau5z"

# setup_twitter_oauth 함수를 사용해서 oauth
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

# 트위터 데이터를 형태별로 분류하고 멘션 부분만 추출 
keyword <- enc2utf8('빅데이터')

bigdata <- searchTwitter(keyword, n=500, lang="ko")
bigdata.df <- twListToDF(bigdata)
bigdata.text <- bigdata.df$text
head(bigdata.text)

# 트위터에서 키워드로 검색, 시작날짜,지역코드, 가져올 개수를 옵션에 적용
h3_twitter <- searchTwitter(keyword, since='2012-10-29', geocode='35.874,128.246,400km', n=100)

# 트위터 데이터를 형태별로 분류하고 멘션 부분만 추출
h3_twitter.df <- twListToDF(h3_twitter)
h3_twitter.text <- h3_twitter.df$text

# 불필요한 문자를 필터링
bigdata.text <- gsub("\n",'',bigdata.text)
bigdata.text <- gsub("\r",'',bigdata.text)
bigdata.text <- gsub("\RT",'',bigdata.text)
bigdata.text <- gsub("\H3",'',bigdata.text)
bigdata.text <- gsub("\http",'',bigdata.text)

head(bigdata.text)

# 문자분리 
h3_twitter_nouns <- Map(extractNoun, h3_twitter.text)

# 쓸모없는 문자들을 제거한다. 특히 영문자의 경우 tm의 stopwords를 활용한다 
h3_twitter_word <- unlist(h3_twitter_nouns, use.name=F)
h3_twitter_word <- h3_twitter_word[-which(h3_twitter_word %in% stopwords('english'))]
h3_twitter_word <- gsub('[[:punct:]]','', h3_twitter_word)
h3_twitter_word <- Filter(function(x){nchar(x)>=2}, h3_twitter_word)
                          
# 단어별 카운트 
bigdata.text_count <- table(bigdata.text)

# 컬러셋팅
h3_twitter_count <- table(h3_twitter_word)

# 폰트셋팅
windowsFonts(malgun = windowsFont('Arial'))

# 워드클라우드 그리기


