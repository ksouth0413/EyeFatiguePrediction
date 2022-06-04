################################################
# Data-Importing & X2(왼쪽과 오른쪽의 수치 차이값)




################################################
# 눈깜빡임을 판단하는 기준으로 어떤 bound를 설정할지 결정.
# 이전 양안의 데이터로부터 얻은 결론을 바탕으로 0을 기준으로 선택함.

Summary1 # List not Dataframe
names(Summary1)

Summary1
X2.1 <- Summary1[[2]] * mean(N) # 오른쪽과 왼쪽 깜빡임 수의 차이
X2.2 <- Summary1[[3]] * mean(N) # X2.1의 절댓값
X2.3 <- Summary1[[4]] * mean(N) # 오른쪽과 왼쪽의 깜빡임 수치의 합
X2.4 <- Summary1[[5]] * mean(N) # 오른쪽과 오니쪽의 깜빡임 수치 절댓값의 합

N
length(N)
length(X2.1)
length(X2.2)
length(X2.3)
length(X2.4)




# Y1(설문을 통한 눈의 피로도 점수)
Y1.cor <- c()
for (i in 2:5) {
  X2 <- Summary1[[i]]
  Y1.cor <- c(Y1.cor, cor(X2,Y1)) 
}
Y1.cor
plot(abs(Y1.cor))
# DB_abs > abs(L-R) > L-R > DB 순으로 연관성이 높다.


# Y2(피실험자 주관에 의한 눈 피로도 점수)
Y2.cor <- c()
for (i in 2:5) {
  X2 <- Summary1[[i]]
  Y2.cor <- c(Y2.cor, cor(X2,Y1)) 
}
Y2.cor
plot(abs(Y2.cor))
# 위와 마찬가지.
# DB_abs > abs(L-R) > L-R > DB 순으로 연관성이 높다.


