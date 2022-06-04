################################################
# Data-Importing & X(���� ������ �� ����)��

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

# ��պ��� ������ �� ū ��Ȳ���� N�� 
# �ſ� ���� ������ ���ļ� ��Ÿ���� ���� Ȯ��.








################################################
# ���������� �Ǵ��ϴ� �������� � bound�� �������� ����.
names(Summary)[-1:-2]

# Y1(������ ���� ���� �Ƿε� ����)
Y1.cor <- c()
for (i in names(Summary)[-1:-2]) {
  X <- Summary[[i]]
  Y1.cor <- c(Y1.cor, cor(X,Y1)) 
}
plot(names(Summary)[-1:-2], abs(Y1.cor))
# Y1�� ������谡 �������� Y1�� ũ�ų� ���� ��,
# �̿� ���� X���� ũ�ų� ���� ����
# ���� �̷��� X�� Y1�� �� �� ��Ÿ�� ���̸�,
# Y1�� Ư������ �������� ���� X���� ������ �� ū ���̸�
# ���� ���̴�.

# �������, 0�� �������� ���� 1�� ����������� ����������
# ��������.


# Y1(�ǽ����� �ְ��� ���� �� �Ƿε� ����)
Y2.cor <- c()
for (i in names(Summary)[-1:-2]) {
  X <- Summary[[i]]
  Y2.cor <- c(Y2.cor, cor(X,Y2)) 
}
plot(names(Summary)[-1:-2], abs(Y2.cor))
# Y2�� ���� ������ ���� ���������̴�.

# ���� �Ϻ��� ���� ���Ҵٰ� �Ǵ��� 0�� ��������
# �������� ���� �� �����͸� ����Ѵ�.








################################################
# Data-Inserting
names(Summary[-1:-2])
X <- Summary[['0']]
X
length(X)
mean(N)
X <- X*mean(N) # ���� �ʹ� �������� �����ϸ��� ���ش�.
X
