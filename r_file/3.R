# 눈의 깜빡임수로 피로도를 선형회귀할 수 있을까?
Y2도 해보기..
par(mfrow=c(1,1))
cor(X,Y1)
plot(X,Y1)
fit <- lm(Y1~X)
fit


abline(fit$coefficient[1],fit$coefficient[2], col=2)
summary(fit)
anova(fit)
plot(Y, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
plot(X, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)