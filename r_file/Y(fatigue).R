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
plot(SumOfGrade~SubjectiveGrade) # 2���� ���� ���� ���⼺�� ��� �ɷ� ����.
plot(SubjectiveGrade~SumOfGrade)



# �� �Ƿε� ��ǥ�� ���� ���⼺�� ����ϴٴ� ���� Ȯ���Ͽ�������,
# ������ ���·� �� ��ǥ�� ���踦 ��Ÿ������ ��.
fit <- lm(SumOfGrade~SubjectiveGrade)
fit
plot(SumOfGrade~SubjectiveGrade)
abline(fit$coefficient[1],fit$coefficient[2], col=2)
summary(fit)
anova(fit)
plot(SumOfGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
points(SumOfGrade[1:2],fit$residuals[1:2], pch=19) # outlier
plot(SubjectiveGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
points(SubjectiveGrade[1:2],fit$residuals[1:2], pch=19) # outlier



# ������ Ȯ���ϸ�,
# 1) ��� ���°� ������ �������� ����ȸ�Ͱ� �ʿ����.
#    ����, ��� ���·� ���̴� �͵� ������ Ȯ���ϰ� ��� ��Ÿ���ٰ� �� �� ���� �Ӵ���
#    ��Ȯ�� ȸ�ͽ��� ã�� ���� �ƴ� outlier�� influential observation�� ã�� �����ϴ� ���� ����������
#    �̵� ���� �������־���.
# 2) ���ȸ���� �ƴ����� ��л꼺���� �� �� �ִ�.
# 3) outlier�� 2�� ���� �ִ� ������ Ȯ�ε�. �̴� ������ ���������� ���Ҵ� �����Ϳ� ������ ���̴�.




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
plot(SumOfGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
plot(SubjectiveGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)





################################################
# �ɽ��ؼ� �غ� ����ȸ��
# ����ȸ��

y <- SumOfGrade
x <- SubjectiveGrade
x2 <- x*x
fit1 <- lm(y~x+x2)
summary(fit1)
plot(SumOfGrade, fit1$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
plot(SubjectiveGrade, fit1$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)

x3 <- x^3
fit2 <- lm(y~x+x2+x3)
summary(fit2)
plot(SumOfGrade, fit2$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
plot(SubjectiveGrade, fit2$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)

par(mfrow=c(1,3))
plot(SubjectiveGrade, fit$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
plot(SubjectiveGrade, fit1$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)
plot(SubjectiveGrade, fit2$residuals, ylab="residuals", main='Residual Plot') # ???모�????��?? ??????
abline(0,0)





###########################################################
# Y(���� �Ƿε�)��

Questionary1
Y1 <- Questionary1[,1]
Y2 <- Questionary1[,2]
Y1 # SumOfGrade
Y2 # SubjectiveGrade


par(mfrow=c(1,1))
plot(SumOfGrade~SubjectiveGrade)
# SubjectvieGrade���� ���� SumOfGrade�� ���ݾ� ��ģ��.
# ���� �� ��ǥ �߿� ��� ���� �� ��Ȯ���� Ȯ���� ��ƴ�.
# �׷��⿡ �� ��ǥ�� ���� ����ؼ� �Ƿε��� ���� label�� ����غ���.