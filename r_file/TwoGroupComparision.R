################################################
#1. Y2�� ������ ��ȭ�Ͽ� �׷��� ������.
# X: 0.0�� �������� �� �������� ��
# Y2: SubjectiveGrade(0~6)


###########################
# two-sample�� ���� mean�� �ٸ��� Ȯ���ϴ� test�̴�.
# �������� ���Ժ������� �����ϰ�, �������� �л��� ���� ��������
# t-test�� ����Ѵ�. ���� ��ǥ���� ��쿡�� Z�� �� �� ������
# ��ǥ���� ��쿡�� T�� ������ ���� �ö󰡼� Z�� T�� ���� ������������
# ���� T��ſ� Z�� �� �ʿ䰡 ����.
# ��, �������� ���� �������� �л��� ���� �������ε�
# �̰��� �ϴ� �ٸ��ٰ� �����ϰ�, ����� ���̰� �ִٰ� ���� ������ ��ü������
# ���캼 ��, �������ֱ�� �Ѵ�.


par(mfrow=c(1,1))
# Ex. (2,2)�� �������� �� ��,
Group1 <- X[Y2<=2] # �ְ��� �Ƿε��� 2����
Group1
Group2 <- X[Y2>2] # �ְ��� �Ƿε��� 2�ʰ�
Group2
# �� ������ �����ͼ��� 30�� �̻������� ǥ������ ������ ���Ժ�����
# �����ٰ� �� �� �ִ�. by CLT. ���� �̸� ������� ���� ���̴�.
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
var.test(Group1, Group2) # pvalue = 9.765e-05; ��л��� �ƴ�.
t.test(Group1,Group2, var.equal=F) # �� ������ ����� �������� �ʴ�.
# ���, var.equal=F�� default���̴�.


# �� ����� ���� ���� ���տ� ���� �����Ѵ�.
# ��, �������� �׷쿡�� ������ ���� 10���̻��̾���Ѵ�.
# �Ʒ��� �� ���պ��� ������ �����ϸ�, p-value�� ����ϵ��� �ߴ�.
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X[Y2<=i] # i����
    Group2 <- X[Y2>j] # j�ʰ�
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2, var.equal=F)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data


# Ȯ�ΰ��, (1,1) / (1,2) / (1,3) / (2,2) / (2,3) / (3,3)�� �������� �������� ???,
# �������� �� �׷찣 ����� �ٸ��ٰ� Ȯ�εǾ���.
# Ư��, p-value�� ���� ���� ������ ������ ������
# (1,3; 0.0005325274) / (2,2; 0.0008027030)
# (2,3; 0.0002978093) / (3,3; 0.0006481771)
# �� �߿����� ��� ���� �����ؼ� ���� (2,2)�� (3,3)�� ������ �׷�
# �ð������� Ȯ���غ���.


# Ex. (2,2)�� �������� �� ��,
Group1 <- X[Y2<=2] # �ְ��� �Ƿε��� 2����
Group1
Group2 <- X[Y2>2] # �ְ��� �Ƿε��� 2�ʰ�
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



# Ex. (3,3)�� �������� �� ��,
Group1 <- X[Y2<=3] # �ְ��� �Ƿε��� 2����
Group1
Group2 <- X[Y2>3] # �ְ��� �Ƿε��� 2�ʰ�
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
#2. Y2�� ������ ��ȭ�Ͽ� �׷��� ������.
# X2: 0.0�� �������� ����� ������ ���� ��ǥ��
# Y2: SubjectiveGrade(0~6)

names(Summary1)
length(X2.1) # L-R
length(X2.2) # abs(L-R)
length(X2.3) # DB
length(X2.4) # DB_abs
legnth(Y2)




# DB_abs > abs(L-R) > L-R > DB ������ �������� ����.
# �������� ���� �ͺ��� Ȯ��.

# 1. DB_abs
# ���� ���տ� ���� �����Ѵ�.
# ��, �������� �׷쿡�� ������ ���� 10���̻��̾���Ѵ�.
# �Ʒ��� �� ���պ��� ������ �����ϸ�, p-value�� ����ϵ��� �ߴ�.
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.4[Y2<=i] # i����
    Group2 <- X2.4[Y2>j] # j�ʰ�
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# ���� ���� pvalue���� (2,2; 0.4340811)���� �Ǻ��Ǿ���.
# �׷��� ����� �ٸ��ٰ� �ϱ⿡�� pvalue���� ���� ũ��.


# 2. abs(L-R)
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.2[Y2<=i] # i����
    Group2 <- X2.2[Y2>j] # j�ʰ�
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# �������� DB_abs���� pvalue���� ���� ���� ������ �׷����� �ұ��ϰ�
# pvalue�� ���� ���� ���� (2,2; 0.07693033)���� ��յ��� ���̰� �ִٰ� ���� ��ƴ�.





# 3. L-R
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.1[Y2<=i] # i����
    Group2 <- X2.1[Y2>j] # j�ʰ�
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# ���������� ū ���̰� ���ٰ� ��������, �ָ��� ���� ����������
# pvalue�� ���� ���� ���� ���� �������� (2,2; 0.5564886)�� ���õǾ���.





# 4. DB
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X2.3[Y2<=i] # i����
    Group2 <- X2.3[Y2>j] # j�ʰ�
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# ���������� ū ���̰� ���ٰ� ���Դ�.
# �̹����� pvalue�� ���� ���� ���� ���� �κ��� (2,2)�� �ƴϾ���.
# (1,1)�̾���. (1,1; 0.8342725)







################################################
# �ð������� ���� pvalue�� Ŭ ���� �׷������� �׷�����.

par(mfrow=c(1,2))

# 1. DB_abs
# Ex. (2,2)�� �������� �� ��,
Group1 <- X2.4[Y2<=2] # �ְ��� �Ƿε��� 2����
Group1
Group2 <- X2.4[Y2>2] # �ְ��� �Ƿε��� 2�ʰ�
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
# Ex. (2,2)�� �������� �� ��,
Group1 <- X2.2[Y2<=2] # �ְ��� �Ƿε��� 2����
Group1
Group2 <- X2.2[Y2>2] # �ְ��� �Ƿε��� 2�ʰ�
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


## �߰��м�
# ���ʰ� �������� �� ������ ���� ��տ� ���̰� �ִ��� Ȯ��
# ¦ �������� ��� ���̿� ���� �߷�

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


# ���� ���ʰ� ������ ���� �����Ӽ��� �ٸ��ٰ� �� �� ����.












################################################
#3. Y2�� ������ ��ȭ�Ͽ� �׷��� ������.
# X3: 0.0�� �������� ���� ���������� �ɸ� ��� �ð�
# Y2: SubjectiveGrade(0~6)

names(Summary2)
length(X3)
legnth(Y2)



# ���� ���տ� ���� �����Ѵ�.
# ��, �������� �׷쿡�� ������ ���� 10���̻��̾���Ѵ�.
# �Ʒ��� �� ���պ��� ������ �����ϸ�, p-value�� ����ϵ��� �ߴ�.
pair <- c()
pvalue <- c()
for (i in 0:5) {
  for (j in i:6) {
    Group1 <- X3[Y2<=i] # i����
    Group2 <- X3[Y2>j] # j�ʰ�
    if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
      pair <- c(pair, paste(i,j))
      pvalue <- c(pvalue, t.test(Group1,Group2)$p.value)
    }
  }
}
data <- data.frame(pair, pvalue)
data
# ���� ���� pvalue���� (2 2 0.1434038)���� �Ǻ��Ǿ���.
# �׷��� ����� �ٸ��ٰ� �ϱ⿡�� pvalue���� ���� ũ��.


################################################
# �ð������� ���� pvalue�� Ŭ ���� �׷������� �׷�����.

# Ex. (2,2)�� �������� �� ��,
Group1 <- X3[Y2<=2] # �ְ��� �Ƿε��� 2����
Group1
Group2 <- X3[Y2>2] # �ְ��� �Ƿε��� 2�ʰ�
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

# �и� �������� ���� ���̰� �ִٰ� ���������� OCT ���� ���̰� �־���Ѵ�.
# ������ 2������ ������ �� ���踦 ���� �� ����.
# ù��°�� ���� ���� �� ������ �ɸ� �ð��̴�.
# �ι�°�� �ڵ�󿡼� OCT�� ������ ��, ���� �����̴�.
# �ڵ�󿡼� ���� �νĵ��� ������ ���� ���Ҵµ� ���Ҵٰ� �ν����� ���ϰ�
# ���� ���� ���ٰ� �ν����� ���Ѵ�.