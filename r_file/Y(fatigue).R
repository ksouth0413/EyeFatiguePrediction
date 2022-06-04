################################################
# Data-Importing
Questionary
names(Questionary)
detach(Questionary)
attach(Questionary)


# Main-Data
SumOfGrade <- Questionary['SumOfGrade']
SumOfGrade <- SumOfGrade[['SumOfGrade']]
length(SumOfGrade)
SumOfGrade <- SumOfGrade[!is.na(SumOfGrade)]
SumOfGrade
length(SumOfGrade)

SubjectiveGrade <- Questionary['SubjectiveGrade']
SubjectiveGrade <- SubjectiveGrade[['SubjectiveGrade']]
length(SubjectiveGrade)
SubjectiveGrade <- SubjectiveGrade[!is.na(SubjectiveGrade)]
SubjectiveGrade
length(SubjectiveGrade)





################################################
# Data-Processing
Questionary1 <- data.frame(SumOfGrade, SubjectiveGrade)
Questionary1
cor(SumOfGrade, SubjectiveGrade)
par(mfrow=c(1,1))
plot(SumOfGrade~SubjectiveGrade) # 2개의 점이 조금 경향성을 벗어난 걸로 보임.
plot(SubjectiveGrade~SumOfGrade)



# 두 피로도 지표가 서로 경향성이 비슷하다는 것을 확인하였음으로,
# 직선의 형태로 두 지표의 관계를 나타내고자 함.
fit <- lm(SumOfGrade~SubjectiveGrade)
fit
plot(SumOfGrade~SubjectiveGrade)
abline(fit$coefficient[1],fit$coefficient[2], col=2)
summary(fit)
anova(fit)
plot(SumOfGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
points(SumOfGrade[1:2],fit$residuals[1:2], pch=19) # outlier
plot(SubjectiveGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
points(SubjectiveGrade[1:2],fit$residuals[1:2], pch=19) # outlier



# 잔차를 확인하면,
# 1) 곡선의 형태가 보이지 않음으로 다항회귀가 필요없음.
#    물론, 곡선의 형태로 보이는 것도 있지만 확실하게 곡선이 나타난다고 할 수 없을 뿐더러
#    정확한 회귀식을 찾는 것이 아닌 outlier와 influential observation을 찾아 제거하는 것이 목적임으로
#    이들 값을 제거해주었다.
# 2) 나팔모양이 아님으로 등분산성임을 알 수 있다.
# 3) outlier가 2개 정도 있는 것으로 확인됨. 이는 이전에 산점도에서 보았던 데이터와 동일한 점이다.




################################################
# Outlier-Remove
SumOfGrade <- SumOfGrade[3:length(SumOfGrade)]
length(SumOfGrade) # 78-2=76
SubjectiveGrade <- SubjectiveGrade[3:length(SubjectiveGrade)]
Questionary1 <- data.frame(SumOfGrade, SubjectiveGrade)
Questionary1

cor(SumOfGrade, SubjectiveGrade)
plot(SumOfGrade~SubjectiveGrade)
fit <- lm(SumOfGrade~SubjectiveGrade)
fit
abline(fit$coefficient[1],fit$coefficient[2], col=2)
summary(fit)
anova(fit)
plot(SumOfGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
plot(SubjectiveGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)





################################################
# 심심해서 해본 다항회귀
# 다항회귀

y <- SumOfGrade
x <- SubjectiveGrade
x2 <- x*x
fit1 <- lm(y~x+x2)
summary(fit1)
plot(SumOfGrade, fit1$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
plot(SubjectiveGrade, fit1$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)

x3 <- x^3
fit2 <- lm(y~x+x2+x3)
summary(fit2)
plot(SumOfGrade, fit2$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
plot(SubjectiveGrade, fit2$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)

par(mfrow=c(1,3))
plot(SubjectiveGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
plot(SubjectiveGrade, fit1$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)
plot(SubjectiveGrade, fit2$residuals, ylab="residuals", main='Residual Plot') # ???紐⑥????몄?? ??????
abline(0,0)





###########################################################
# Y(눈의 피로도)값

Questionary1
Y1 <- Questionary1[,1]
Y2 <- Questionary1[,2]
Y1 # SumOfGrade
Y2 # SubjectiveGrade


par(mfrow=c(1,1))
plot(SumOfGrade~SubjectiveGrade)
# SubjectvieGrade값에 따른 SumOfGrade가 절반씩 겹친다.
# 따라서 두 지표 중에 어느 것이 더 정확한지 확인은 어렵다.
# 그렇기에 두 지표를 각각 사용해서 피로도에 대한 label로 사용해본다.
