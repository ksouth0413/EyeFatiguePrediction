

names(Summary1)
X2.1 <- Summary1[[3]]
X2.2 <- Summary1[[5]]
##########
## 다중선형회귀 적합(1); Y1= f(X,X4.3)
lm1 <- lm(Y1 ~ X+X2.2+X4.3)
lm1
summary(lm1)
attach(factor)
## 다중선형회귀 적합(2); Y2= f(X,X4.3)
lm2 <- lm(Y1 ~X)
lm2
summary(lm2)
names(Summary1)
Summary1
Summary_copy
names(Summary_copy)
X <- Summary_copy[['0']]
X[1:5]
