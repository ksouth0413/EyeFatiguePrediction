################################################
# Data-Importing & X(눈의 깜빡임 총 갯수)값

Summary <- Summary_copy
Summary # List not Dataframe
names(Summary)
N <- as.integer(Summary[['N']])
N
length(N)
par(mfrow=c(1,1))
plot(N)
mean(N)
sd(N)
plot(density(N))
abline(v=mean(N))
abline(v=mean(N)-sd(N))
abline(v=mean(N)+sd(N))

# 평균보다 편차가 더 큰 상황으로 N이 
# 매우 넓은 범위에 걸쳐서 나타나는 것을 확인.








################################################
# 눈깜빡임을 판단하는 기준으로 어떤 bound를 설정할지 결정.
names(Summary)[-1:-2]

# Y1(설문을 통한 눈의 피로도 점수)
Y1.cor <- c()
for (i in names(Summary)[-1:-2]) {
  X <- Summary[[i]]
  Y1.cor <- c(Y1.cor, cor(X,Y1)) 
}
plot(names(Summary)[-1:-2], abs(Y1.cor))
# Y1과 상관관계가 높을수록 Y1이 크거나 작을 때,
# 이에 따른 X값도 크거나 작을 것임
# 따라서 이러한 X가 Y1을 더 잘 나타낼 것이며,
# Y1의 특정값을 기준으로 나눈 X값의 분포도 더 큰 차이를
# 보일 것이다.

# 관찰결과, 0을 기준으로 점점 1로 가까워질수록 상관계수값이
# 떨어진다.


# Y1(피실험자 주관에 의한 눈 피로도 점수)
Y2.cor <- c()
for (i in names(Summary)[-1:-2]) {
  X <- Summary[[i]]
  Y2.cor <- c(Y2.cor, cor(X,Y2)) 
}
plot(names(Summary)[-1:-2], abs(Y2.cor))
# Y2에 대한 상관계수 또한 마찬가지이다.

# 따라서 완벽히 눈을 감았다고 판단한 0을 기준으로
# 눈깜빡임 수를 젠 데이터를 사용한다.








################################################
# Data-Inserting
names(Summary[-1:-2])
X <- Summary[['0']]
X
length(X)
mean(N)
X <- X*mean(N) # 값이 너무 작음으로 스케일링을 해준다.
X

