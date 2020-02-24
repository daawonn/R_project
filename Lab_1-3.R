#####################################################
#데이터 탐색을 통한 변수 선택 후 분석에서 제외할 변수 제거
#####################################################
rm(list=ls())
data_cust <- read.csv("data_cust_1-1.csv", header=TRUE)

#drop OCCP_GRP_2 & MATE_OCCP_GRP_2 variable
data_cust <- subset(data_cust, select=-c(OCCP_GRP_2, MATE_OCCP_GRP_2))
data_cust <- subset(data_cust, select=-c(MAX_PAYM_YM, MAX_PRM))
data_cust <- subset(data_cust, select=-CUST_RGST)
data_cust <- subset(data_cust, select=-c(CHLD_CNT, LTBN_CHLD_AGE))
data_cust <- subset(data_cust, select=-JPBASE_HSHD_INCM)

#데이터 임시 저장
write.csv(data_cust, "data_cust_1-3.csv", row.names = FALSE)

# 이후 진행상황
# 변수선택을 어떻게 할 것인지에 대한 회의도 있어야 한다. (PCA, SVMRFE등등 사용)
# PCA : 주성분 분석
# 적은 데이터를 효율적으로 분석하기 위해 TEST, TRAIN 데이터의 비율을 조정해야한다
# K폴드 교차검증
# https://datascienceschool.net/view-notebook/266d699d748847b3a3aa7b9805b846ae/
# 적합한 알고리즘 찾기

# 1. 가설 설정
# 2. 분석 항목 정의
# 3. 데이터 선정
# 4. 데이터 변환, 추출, 통합
# 5. 데이터 결측치, 이상치 처리, 시각화
# 6. 기초 통계분석 : 유의변수 선정, 파생변수 선정, 연관성분석, 가설 수립 및 검증
# 7. 분석 데이터 수정, 계층화
# 8. 모델링 방법 선정, 모델 생성
# 9. 모델 개선, 평가, 검증
# 10. 모델 활용 및 적용방안 수립, 모니터링, 알고리즘 설명서