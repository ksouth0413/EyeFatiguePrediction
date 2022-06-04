################################################
# Data-Importing & X3(눈을 감을때까지 걸린 시간)




################################################
# 눈깜빡임을 판단하는 기준으로 어떤 bound를 설정할지 결정.
# 이전 양안의 데이터로부터 얻은 결론을 바탕으로 0을 기준으로 선택함.

Summary2 # List not Dataframe
names(Summary2)

Summary2
X3 <- Summary2[[2]]
N
length(N)
length(X3)


# Y1(설문을 통한 눈의 피로도 점수)
Y1.cor <- cor(X3,Y1)
Y1.cor

# Y2(피실험자 주관에 의한 눈 피로도 점수)
Y2.cor <- cor(X3,Y2)
Y2.cor


