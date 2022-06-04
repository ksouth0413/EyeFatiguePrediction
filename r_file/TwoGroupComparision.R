################################################
#1. Y2의 기준을 변화하여 그룹을 나눈다.
# X: 0.0을 기준으로 한 눈깜빡임 수
# Y2: SubjectiveGrade(0~6)


###########################
# two-sample에 대한 mean이 다른지 확인하는 test이다.
# 모집단은 정규분포임을 가정하고, 모집단의 분산을 알지 못함으로
# t-test를 사용한다. 물론 대표본일 경우에는 Z를 쓸 수 있지만
# 대표본의 경우에는 T의 자유도 값이 올라가서 Z와 T의 값이 유사해짐으로
# 굳이 T대신에 Z를 쓸 필요가 없다.
# 단, 주의해줄 것은 모집단의 분산이 서로 같은지인데
# 이것은 일단 다르다고 가정하고, 평균의 차이가 있다고 나온 값들을 구체적으로
# 살펴볼 때, 고려해주기로 한다.


par(mfrow=c(1,1))
# Ex. (2,2)을 기준으로 할 때,
Group1 <- X[Y2<=2] # 주관적 피로도가 2이하
Group1
Group2 <- X[Y2>2] # 주관적 피로도가 2초과
Group2
# 각 집단의 데이터수가 30개 이상임으로 표본들의 집단이 정규분포를
# 따른다고 할 수 있다. by CLT. 물론 이를 사용하진 않을 것이다.
length(Group1) # 42
length(Group2) # 34
length(Group1) + length(Group2)

title(main='Two Group Comparison')
plot(density(Group1), xlim=c(-500,2000), ylim=c(0,0.003), main='')
par(new=TRUE)
plot(density(Group2), xlim=c(-500,2000), ylim=c(0,0.003), main='')
abline(v=mean(Group1), col=2)
abline(v=mean(Group2), col=4)

var(Group1)
var(Group2) 
var.test(Group1, Group2) # pvalue = 9.765e-05; 등분산이 아님.
t.test(Group1,Group2, var.equal=F) # 두 집단의 평균이 동일하지 않다.
# 사실, var.equal=F가 default값이다.


# 위 방법을 토대로 여러 조합에 대해 수행한다.
# 단, 나뉘어진 그룹에서 데이터 수가 10개이상이어야한다.
# 아래는 각 조합별로 조건을 만족하면, p-value를 출력하도록 했다.
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X[Y2<=i] # i이하
    Group2 <- X[Y2>j] # j초과
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2, var.equal=F)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data


# 확인결과, (1,1) / (1,2) / (1,3) / (2,2) / (2,3) / (3,3)을 기준으로 나누었을 ???,
# 나뉘어진 두 그룹간 평균이 다르다고 확인되었다.
# 특히, p-value가 낮게 나온 값들은 다음과 같은데
# (1,3; 0.0005325274) / (2,2; 0.0008027030)
# (2,3; 0.0002978093) / (3,3; 0.0006481771)
# 그 중에서도 모든 값을 포함해서 나눈 (2,2)와 (3,3)의 분포를 그려
# 시각적으로 확인해보자.


# Ex. (2,2)을 기준으로 할 때,
Group1 <- X[Y2<=2] # 주관적 피로도가 2이하
Group1
Group2 <- X[Y2>2] # 주관적 피로도가 2초과
Group2
length(Group1)
length(Group2)
max(Group1)
min(Group1)
betw <- sqrt(min(var(Group1),var(Group2)))
plot(density(Group1), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.005), main="NumerOfBlink Between TiredEyes&Not")
par(new=TRUE)
plot(density(Group2), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.005), main="")
abline(v=mean(Group1), col=3)
abline(v=mean(Group2), col=2)
var(Group1)
var(Group2)
var.test(Group1, Group2) # pvalue : 9.765e-05 -> not equal variance
t.test(Group1,Group2, var.equal=F) # pvalue : 0.0008027 -> not same mean



# Ex. (3,3)을 기준으로 할 때,
Group1 <- X[Y2<=3] # 주관적 피로도가 2이하
Group1
Group2 <- X[Y2>3] # 주관적 피로도가 2초과
Group2
length(Group1)
length(Group2)
max(Group1)
min(Group1)
betw <- sqrt(min(var(Group1),var(Group2)))
plot(density(Group1), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.005), main="NumerOfBlink Between TiredEyes&Not")
par(new=TRUE)
plot(density(Group2), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.005), main="")
abline(v=mean(Group1), col=3)
abline(v=mean(Group2), col=2)
var(Group1)
var(Group2)
var.test(Group1, Group2) # 0.001849
t.test(Group1,Group2, var.equal=F) # 0.0006482





















################################################
#2. Y2의 기준을 변화하여 그룹을 나눈다.
# X2: 0.0을 기준으로 양안의 깜빡임 차이 지표들
# Y2: SubjectiveGrade(0~6)

names(Summary1)
length(X2.1) # L-R
length(X2.2) # abs(L-R)
length(X2.3) # DB
length(X2.4) # DB_abs
legnth(Y2)




# DB_abs > abs(L-R) > L-R > DB 순으로 연관성이 높다.
# 연관성이 높은 것부터 확인.

# 1. DB_abs
# 여러 조합에 대해 수행한다.
# 단, 나뉘어진 그룹에서 데이터 수가 10개이상이어야한다.
# 아래는 각 조합별로 조건을 만족하면, p-value를 출력하도록 했다.
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.4[Y2<=i] # i이하
    Group2 <- X2.4[Y2>j] # j초과
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# 가장 작은 pvalue값이 (2,2; 0.4340811)으로 판별되었다.
# 그러나 평균이 다르다고 하기에는 pvalue값이 매주 크다.


# 2. abs(L-R)
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.2[Y2<=i] # i이하
    Group2 <- X2.2[Y2>j] # j초과
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# 이전값인 DB_abs보다 pvalue값이 작은 곳이 있으나 그럼에도 불구하고
# pvalue가 가장 작은 값이 (2,2; 0.07693033)으로 평균들의 차이가 있다고 보기 어렵다.





# 3. L-R
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.1[Y2<=i] # i이하
    Group2 <- X2.1[Y2>j] # j초과
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# 마찬가지로 큰 차이가 없다고 나왔으나, 주목할 점은 이전과같이
# pvalue가 가장 작은 값을 가진 구간으로 (2,2; 0.5564886)이 선택되었다.





# 4. DB
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.3[Y2<=i] # i이하
    Group2 <- X2.3[Y2>j] # j초과
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# 마찬가지로 큰 차이가 없다고 나왔다.
# 이번에는 pvalue가 가장 작은 값이 나온 부분이 (2,2)가 아니었다.
# (1,1)이었다. (1,1; 0.8342725)







################################################
# 시각적으로 가장 pvalue가 클 때의 그래프들을 그려보자.

par(mfrow=c(1,2))

# 1. DB_abs
# Ex. (2,2)을 기준으로 할 때,
Group1 <- X2.4[Y2<=2] # 주관적 피로도가 2이하
Group1
Group2 <- X2.4[Y2>2] # 주관적 피로도가 2초과
Group2
length(Group1)
length(Group2)
max(Group1)
min(Group1)
betw <- sqrt(min(var(Group1),var(Group2)))
plot(density(Group1), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.003), main="DB_abs")
par(new=TRUE)
plot(density(Group2), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.003), main="")
abline(v=mean(Group1), col=3)
abline(v=mean(Group2), col=2)
var(Group1)
var(Group2)
var.test(Group1, Group2) # 0.5609
t.test(Group1,Group2, var.equal = T) # 0.4292 -> same mean 


# 2. abs(L-R)
# Ex. (2,2)을 기준으로 할 때,
Group1 <- X2.2[Y2<=2] # 주관적 피로도가 2이하
Group1
Group2 <- X2.2[Y2>2] # 주관적 피로도가 2초과
Group2
length(Group1)
length(Group2)
max(Group1)
min(Group1)
betw <- sqrt(min(var(Group1),var(Group2)))
plot(density(Group1), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.008), main="abs(L-R)")
par(new=TRUE)
plot(density(Group2), xlim=c(min(min(Group1,Group2))-betw,max(max(Group1),max(Group2))+betw), ylim=c(0,0.008), main="")
abline(v=mean(Group1), col=3)
abline(v=mean(Group2), col=2)
var(Group1)
var(Group2)
var.test(Group1, Group2) # 7.358e-05
t.test(Group1,Group2, var.equal = F) # 0.07693 -> same mean 










################################################


## 추가분석
# 왼쪽과 오른쪽의 눈 깜빡임 수의 평균에 차이가 있는지 확인
# 짝 모집단의 평균 차이에 대한 추론

t.value <- mean(X2.1)/sqrt(sd(X2.1)^2/length(X2.1))
t.value

DF <- (length(X2.1)-1)
a <- 0.05 # confidence-level
T.criticalValue <- qt(a/2, DF)
T.criticalValue
p.value <- pt(t.value, DF)
p.value

par(mfrow=c(1,1))
# Drawing t-Dist Graph
plot(density(rt(1000,df=DF)), main='Paired Two Sample Test',xlab='t-Dist; T(75;0.05)', xlim=c(-4,4))
abline(v=t.value, col='red')
abline(v=T.criticalValue, col='blue')


# 따라서 왼쪽과 오른쪽 눈의 깜빡임수가 다르다고 볼 수 없다.












################################################
#3. Y2의 기준을 변화하여 그룹을 나눈다.
# X3: 0.0을 기준으로 눈을 감을때까지 걸린 평균 시간
# Y2: SubjectiveGrade(0~6)

names(Summary2)
length(X3)
legnth(Y2)



# 여러 조합에 대해 수행한다.
# 단, 나뉘어진 그룹에서 데이터 수가 10개이상이어야한다.
# 아래는 각 조합별로 조건을 만족하면, p-value를 출력하도록 했다.
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X3[Y2<=i] # i이하
    Group2 <- X3[Y2>j] # j초과
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# 가장 작은 pvalue값이 (2 2 0.1434038)으로 판별되었다.
# 그러나 평균이 다르다고 하기에는 pvalue값이 매주 크다.


################################################
# 시각적으로 가장 pvalue가 클 때의 그래프들을 그려보자.

# Ex. (2,2)을 기준으로 할 때,
Group1 <- X3[Y2<=2] # 주관적 피로도가 2이하
Group1
Group2 <- X3[Y2>2] # 주관적 피로도가 2초과
Group2
length(Group1)
length(Group2)
max(Group1)
min(Group1)
betw <- sqrt(min(var(Group1),var(Group2)))
plot(density(Group1), xlim=c(0,50), ylim=c(0,0.15), main="OCT")
par(new=TRUE)
plot(density(Group2), xlim=c(0,50), ylim=c(0,0.15), main="")
abline(v=mean(Group1), col=3)
abline(v=mean(Group2), col=2)
var(Group1)
var(Group2)
var.test(Group1, Group2) # 2.2e-16
t.test(Group1,Group2, var.equal = F) # 0.1434 -> not same mean 

# 분명 눈깜빡임 수가 차이가 있다고 나왔음으로 OCT 또한 차이가 있어야한다.
# 하지만 2가지의 요인이 이 관계를 막는 것 같다.
# 첫번째는 눈을 감고 뜰 때까지 걸린 시간이다.
# 두번째는 코드상에서 OCT를 측정할 때, 생긴 오류이다.
# 코드상에서 눈이 인식되지 않으면 눈을 감았는데 감았다고 인식하지 못하고
# 눈을 떠도 떴다고 인식하지 못한다.
