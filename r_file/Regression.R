###########################################################
# Data Importing

data1 <- read.table('/Users/namhunkim/Downloads/factor.csv')
names(data1)
# 되도록이면, R코드가 아닌 IDE에서 제공하는 기능으로 불러와라.
factor
names(factor)
detach(factor)
attach(factor)
data <- list('Y1'=Y1,
             'Y2'=Y2,
             'X'=X,
             'X4.3'=X4.3)
data
names(data)
write.csv(data, '/Users/namhunkim/Downloads/factor.csv', row.names=F)
#








###########################################################
## 회귀문제. Y2,Y1 = f(X,X4.3)


##########
## Scatterplot Matrix 산점도 행렬
data <- data.frame(data)
pairs(data)
## 상관계수(선형 방향과 강도 파악)를 통해 확인해보면,
cor(data)





##########
## 다중선형회귀 적합(1); Y1= f(X,X4.3)
lm1 <- lm(Y1 ~ X + X4.3)
lm1
summary(lm1)

## 다중선형회귀 적합(2); Y2= f(X,X4.3)
lm2 <- lm(Y2 ~ X + X4.3)
lm2
summary(lm2)





##########
# Data-Processing

## 새로운 y-value를 Dummy형태로 제작.
# 1) 2이하, 2초과를 기준으로 0,1부여
Y2.1 <- ifelse (Y2>2 , 1, 0)
Y2.1
length(Y2.1)
plot(Y2.1)

# 2) 3이하, 3초과를 기준으로 0,1부여
Y2.2 <- ifelse (Y2>3 , 1, 0)
Y2.2
length(Y2.2)
plot(Y2.2)

##########
## 다중선형회귀 적합(3); Y2.1= f(X,X4.3)
lm2.1 <- lm(Y2.1 ~ X + X4.3)
lm2.1
summary(lm2.1)

## 다중선형회귀 적합(4); Y2.2= f(X,X4.3)
lm2.2 <- lm(Y2.2 ~ X + X4.3)
lm2.2
summary(lm2.2)

## 로지스틱회귀 적합(5); Y2.1= g(X,X4.3)
lm2.3 <- glm(Y2.2 ~ X + X4.3, family=binomial)
summary(lm2.3)
lm2.3 <- glm(Y2.1 ~ X + X4.3, family=binomial)
summary(lm2.3)
#







##########
# Data-Processing(2)

## 어떻게든 유의미한 회귀계수를 만들기 위해
## 피로도점수가 가운데인 것은 제거한다.
range(Y1) # 10이하 20초과로 나눠보자.
range(Y2) # 2이하 4이상으로 나눠보자.

# 1) Y1 분류
Y1.r <- c()
Y1.r
X1.r <- c()
X1.r
X4.3.r <- c()
X4.3.r
for (i in 1:length(Y1)) {
  if ( (Y1[i]<=10)|(Y1[i]>23) ) {
    Y1.r <- c(Y1.r, Y1[i])
    X1.r <- c(X1.r, X[i])
    X4.3.r <- c(X4.3.r, X4.3[i])
  }
}
Y1.r
length(Y1.r)
X1.r
length(X1.r)
X4.3.r
length(X4.3.r)
plot(X1.r,Y1.r)
plot(X4.3.r,Y1.r)

## 다중선형회귀 적합(6); Y1.r= f(X1.r,X4.3.r)
lm1.r <- lm(Y1.r ~ X1.r + X4.3.r)
lm1.r
summary(lm1.r)

## 로지스틱회귀 적합(7); Y1.r0= g(X1.r,X4.3.r)
Y1.r0 <- ifelse (Y1.r>16 , 1, 0)
Y1.r0
length(Y1.r0)
lm1.r0 <- glm(Y1.r0 ~ X1.r + X4.3.r, family=binomial)
summary(lm1.r0)








## 어떻게든 유의미한 회귀계수를 만들기 위해
## 피로도점수가 가운데인 것은 제거한다.
range(Y1) # 10이하 20초과로 나눠보자.
range(Y2) # 2이하 4이상으로 나눠보자.

# 2) Y2 분류
Y2.r <- c()
Y2.r
X2.r <- c()
X2.r
X4.3.r <- c()
X4.3.r
for (i in 1:length(Y2)) {
  if ( (Y2[i]<=1)|(Y2[i]>4) ) {
    Y2.r <- c(Y2.r, Y2[i])
    X2.r <- c(X2.r, X[i])
    X4.3.r <- c(X4.3.r, X4.3[i])
  }
}
Y2.r
length(Y2.r)
X2.r
length(X2.r)
X4.3.r
length(X4.3.r)
plot(X2.r,Y2.r)
plot(X4.3.r,Y2.r)

## 다중선형회귀 적합(8); Y2.r= f(X2.r,X4.3.r)
lm2.r <- lm(Y2.r ~ X2.r + X4.3.r)
lm2.r
summary(lm2.r)

## 로지스틱회귀 적합(9); Y1.r0= g(X1.r,X4.3.r)
Y2.r0 <- ifelse (Y2.r>3 , 1, 0)
Y2.r0
length(Y2.r0)
lm2.r0 <- glm(Y2.r0 ~ X2.r + X4.3.r, family=binomial)
summary(lm2.r0)







########## Residual Plot
# 1st regression(Reg)
par(mfrow=c(1,3))
plot(lm1$fitted, lm1$residuals, xlab="y-hat", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X, lm1$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X4.3, lm1$residuals, xlab="X4.3", ylab="residual", main="Residual Plot")
abline(0,0)
# 정보없음.

# 2nd Reg
plot(lm2$fitted, lm2$residuals, xlab="y-hat", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X, lm2$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X4.3, lm2$residuals, xlab="X4.3", ylab="residual", main="Residual Plot")
abline(0,0)
# 정보없음.

# 3th Reg
plot(lm2.1$fitted, lm2.1$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X, lm2.1$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X4.3, lm2.1$residuals, xlab="NumerOfSalesmen", ylab="residual", main="Residual Plot")
abline(0,0)
# ?

# 4th Reg
plot(lm2.2$fitted, lm2.2$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X, lm2.2$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X4.3, lm2.2$residuals, xlab="NumerOfSalesmen", ylab="residual", main="Residual Plot")
abline(0,0)
# ?

# 5th Reg
plot(lm2.3$fitted, lm2.3$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X, lm2.3$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X4.3, lm2.3$residuals, xlab="NumerOfSalesmen", ylab="residual", main="Residual Plot")
abline(0,0)
# ?

# 6th Reg
plot(lm1.r$fitted, lm1.r$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X1.r, lm1.r$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
# 정보없음.

# 7th Reg
plot(lm1.r0$fitted, lm1.r0$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X1.r, lm1.r0$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
# ?

# 8th Reg
plot(lm2.r$fitted, lm2.r$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X2.r, lm2.r$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
# ?

# 9th Reg
plot(lm2.r0$fitted, lm2.r0$residuals, xlab="fitted value", ylab="residual", main="Residual Plot")
abline(0,0)
plot(X2.r, lm2.r0$residuals, xlab="X", ylab="residual", main="Residual Plot")
abline(0,0)
# ?









## 번외

# 1. 양끝값의 데이터는 극단적이라 오차가 있다고 생각해
# 반대로 양끝이 아닌 가운데의 값을 이용해보자.
Yx <- c()
Yx
Xx<- c()
Xx
Xx1 <- c()
Xx1
for (i in 1:length(Y2)) {
  if ( (Y2[i]>1)&(Y2[i]<5) ) { # 1과 5사이의 값
    Yx <- c(Yx, Y2[i])
    Xx<- c(Xx, X[i])
    Xx1 <- c(Xx1, X4.3[i])
  }
}
Yx
length(Yx)
Xx
length(Xx)
Xx1
length(Xx1)
plot(Xx,Yx)
plot(Xx1,Yx)

## 다중회귀적합
lmk <- lm(Yx ~ Xx+ Xx1)
lmk
summary(lmk) # 역시 가운데 값들은 오류가 많다.

## 로지스틱회귀 적합
Yx0 <- ifelse (Yx>3 , 1, 0)
Yx0
length(Yx0)
lmk0 <- glm(Yx0 ~ Xx+ Xx1, family=binomial)
summary(lmk0) # 로지스틱회귀도 마찬가지



# 2. 이전의 깜빡임지표를 선택할시에 피로도그룹을 2를 기준으로
# 나누었고 이 때 선택된 깜빡임지표는 깜빡임수였다.
# 따라서 2를 기준으로 0과 1로 피로도그룹데이터를 전처리하고
# 깜빡임수(X)로만 단순선형회귀를 진행한다.
Yg <- ifelse (Y2>2 , 1, 0)
Yg
lmg <- lm(Yg ~ X)
summary(lmg) 
lmg1 <- glm(Yg ~ X, family=binomial)
summary(lmg1)
plot(X,Yg)   
