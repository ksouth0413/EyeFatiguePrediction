# install.packages('moments')
library(moments)

# Y1, Y2
par(mfrow=c(2,2))
plot(density(Y1))
abline(v=mean(Y1))
qqnorm(Y1)
shapiro.test(Y1) # p-value = 0.0005617

plot(density(Y2))
abline(v=mean(Y2))
qqnorm(Y2)
shapiro.test(Y2) # p-value = 0.001394


# X, X2.2 & X2.4, X3

# 1. X
par(mfrow=c(1,2))
plot(density(X))
abline(v=mean(X))
mean(X)
median(X)
sd(X)
max(X)
min(X)
skewness(X)
kurtosis(X)
qqnorm(X)
shapiro.test(X) # p-value = 6.152e-07
# 정규분포는 아니다. 카이제곱 분포나 F분포일 수도 있을 것 같다.
# 12장의 GoodnessOfFit Test를 해보면 된다.


par(mfrow=c(2,2))
X0 <- X[Y2<=2]
length(X0)
mean(X0)
median(X0)
sd(X0)
max(X0)
min(X0)
skewness(X0)
kurtosis(X0)
plot(density(X0), main='X[Y2<=2]')
abline(v=mean(X0))
qqnorm(X0)
shapiro.test(X0) # 0.0008386

X0 <- X[Y2>2]
length(X0)
mean(X0)
median(X0)
sd(X0)
max(X0)
min(X0)
skewness(X0)
kurtosis(X0)
plot(density(X0), main='X[Y2>2]')
abline(v=mean(X0))
qqnorm(X0)
shapiro.test(X0) # 0.002185
# 두 집단 중 3이상인 집단이 정규분포가 아니라는 결론이 나왔지만,
# 표본의 수가 많은 대표본임으로 표본평균과 평균에 관한 식은 정규분포를 따른다고 볼 수 있다.




# 2. X2
# X2.4
par(mfrow=c(2,3))
plot(density(X2.4))
abline(v=mean(X2.4))
qqnorm(X2.4)
shapiro.test(X2.4) # p-value = 3.357e-05
# X2.2
par(mfrow=c(1,2))
plot(density(X2.2))
abline(v=mean(X2.2))
qqnorm(X2.2)
shapiro.test(X2.2) # p-value = 2.683e-11
# X2.1
par(mfrow=c(1,2))
plot(density(X2.1))
abline(v=mean(X2.1))
qqnorm(X2.1)
shapiro.test(X2.1) # p-value = 2.537e-06
# X2.3
par(mfrow=c(1,2))
plot(density(X2.3))
abline(v=mean(X2.3))
qqnorm(X2.3)
shapiro.test(X2.3) # p-value = 1.414e-06




# 3. X3
par(mfrow=c(1,2))
plot(density(X3))
abline(v=mean(X3))
qqnorm(X3)
shapiro.test(X3) # p-value < 2.2e-16



A <- rep('low', length(X[Y2<=2]))
B <- rep('high', length(X[Y2>2]))
C <- c(A,B)
D <- c(X[Y2<=2], X[Y2>2])
Mean = c(mean(X[Y2>2]), mean(X[Y2<=2]))
Mean
par(mfrow=c(2,2))
barplot(Mean, main='Mean', ylab='BlinkCount', xlab='Fatigue; Low vs High')
stripchart(D~C, main='individual value', vertical=T, ylab='BlinkCount', xlab='FatigueScore')
library(gplots)
plotmeans(D~C, main='95% interval', ylab='BlinkCount', xlab='FatigueScore')           # 95% confidence intervals
boxplot(D ~ C, main='boxplot',ylab='BlinkCount', xlab='FatigueScore')

