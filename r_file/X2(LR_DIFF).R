################################################
# Data-Importing & X2(���ʰ� �������� ��ġ ���̰�)




################################################
# ���������� �Ǵ��ϴ� �������� � bound�� �������� ����.
# ���� ����� �����ͷκ��� ���� ����� �������� 0�� �������� ������.

Summary1 # List not Dataframe
names(Summary1)

Summary1
X2.1 <- Summary1[[2]] * mean(N) # �����ʰ� ���� ������ ���� ����
X2.2 <- Summary1[[3]] * mean(N) # X2.1�� ����
X2.3 <- Summary1[[4]] * mean(N) # �����ʰ� ������ ������ ��ġ�� ��
X2.4 <- Summary1[[5]] * mean(N) # �����ʰ� �������� ������ ��ġ ������ ��

N
length(N)
length(X2.1)
length(X2.2)
length(X2.3)
length(X2.4)




# Y1(������ ���� ���� �Ƿε� ����)
Y1.cor <- c()
for (i in 2:5) {
  X2 <- Summary1[[i]]
  Y1.cor <- c(Y1.cor, cor(X2,Y1)) 
}
Y1.cor
plot(abs(Y1.cor))
# DB_abs > abs(L-R) > L-R > DB ������ �������� ����.


# Y2(�ǽ����� �ְ��� ���� �� �Ƿε� ����)
Y2.cor <- c()
for (i in 2:5) {
  X2 <- Summary1[[i]]
  Y2.cor <- c(Y2.cor, cor(X2,Y1)) 
}
Y2.cor
plot(abs(Y2.cor))
# ���� ��������.
# DB_abs > abs(L-R) > L-R > DB ������ �������� ����.

