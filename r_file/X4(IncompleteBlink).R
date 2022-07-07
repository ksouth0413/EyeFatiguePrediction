###############################################################
# Data Preprocessing

Summary # header =T
N <- Summary[['N']]
length(N) # 76
names(Summary)

X4.list <- list('0','0','0','0','0','0','0','0','0')
X4.list
names(X4.list)
names(X4.list) <- 1:9
X4.list
for (i in 1:9) {
  names(X4.list)[i] <- paste('0.',i,sep='')
  X4.list[[i]] <- Summary[[i+3]] - Summary[[i+2]]
}
names(X4.list)
X4.list
# Each list value has just 1 standard.
# Ex. '0.4' means smaller than 0.4 and larger than 0.3.
# Due to Summary is defined less than 0.x.



###############################################################
# Two Group Comparision


###############################################################
# 1. Choose the standard which determines 'incomplete-blink'
# by comparing coef with Y2.
length(X4.list[[1]])
length(Y2)
cor.value <- c()
id <- c()
for (i in 1:length(X4.list)) {
  for (j in 1:length(X4.list)) {
    if (i<=j) {
      temp1 <- c(rep(0,length(N)))
      for (k in i:j) {
        temp1 <- c(temp1 + X4.list[[k]])
      }
      cor.value <- c(cor.value, cor(temp1, Y2))
      id <- c(id, paste(i,j))
    }
  }
}

length(cor.value)
plot(abs(cor.value))
idx <- order(abs(cor.value), decreasing=T)[1:5]
idx
points(idx, abs(cor.value)[idx], pch=19, col=2)
cor.value[idx]
id[idx]
title("correlation value")
# 피로도(Y2)와 가장 상관관계가 큰 것은 
# 다음 5개이나, "3 3"의 경우에 너무 동떨어져 있어 앞선
# 4개를 이용하여 p-value 비교를 하고자 한다.
cor.value[idx]
id[idx]
# "1 3" means 0<x<=3
# "2 2" means 1<x<=2
idx <- idx[1:4]
idx
id[idx]

# Data Preprocessing
X4 <- list()
length(idx)
X4 <- list(0,0,0,0)
names(X4) <- 1:4
X4
for (i in 1:4) {
  names(X4)[i] <- paste('X4.',i,sep='')
  tmp <- as.integer(as.vector(unlist(strsplit(id[idx[i]], split=' '))))
  for (k in tmp[1]:tmp[2]) {
    X4[[i]] <- X4[[i]] + X4.list[[k]]
  }
}
X4

detach(X4)
attach(X4)
X4.1 
X4.2
X4.3
X4.4


###############################################################
# 2. (Continued) by using p-value comparison

pair <- list(NA,NA,NA,NA)
names(pair) <- names(X4)
pvalue <- list(NA,NA,NA,NA)
names(pvalue) <- names(X4)

for (i in 0:5) {
  for (j in i:6) {
    for (k in 1:length(X4))
    { X <- get(paste('X4.',k,sep=''))
      Group1 <- X[Y2<=i] # i이하
      Group2 <- X[Y2>j] # j초과
      if ( (length(Group1) > 10) & (length(Group2) > 10) ) {
        pair[[k]] <- c(pair[[k]], paste(i,j))
        pvalue[[k]] <- c(pvalue[[k]], t.test(Group1,Group2)$p.value)
      }
    }
  }
}
pair
pvalue

for (i in 1:length(pvalue)) {
  idx1 <- which.min(pvalue[[i]])
  print(pvalue[[i]][idx1])
  print(pair[[i]][idx1])
}

### Conclusion ###
# 0.1<x<=0.2 rate with Y2 is divided by <=3, 3<
# has p-value '0.01762008'. <- So, choose this measurement as a
# factor for using estimation of eye-fatigue.


###############################################################
# 3. Drawing & Identifying by using graph!

par(mfrow=c(1,1))
# Ex. (3,3)을 기준으로 할 때,
Group1 <- X4.3[Y2<=3] # 주관적 피로도가 3이하
Group1
Group2 <- X4.3[Y2>3] # 주관적 피로도가 3초과
Group2
# 각 집단의 데이터수가 30개 이상임으로 표본들의 집단이 정규분포를
# 따른다고 할 수 있다. by CLT. 물론 이를 사용하진 않을 것이다.
length(Group1) # 58
length(Group2) # 18
length(Group1) + length(Group2)

plot(density(Group1), main='')
par(new=TRUE)
plot(density(Group2), main='')
abline(v=mean(Group1), col=2)
abline(v=mean(Group2), col=4)
title(main='Two Group Comparison')

var(Group1)
var(Group2) 
var.test(Group1, Group2) # pvalue = 0.01225; 등분산이라 볼 수 없다.
# 사실, var.equal=F가 default값이다. 이전의 검정결과가 등분산이 아닐 때이다.
t.test(Group1,Group2, var.equal=F) # 두 집단의 평균이 동일하지 않다.
# 이전과 동일한 p-value값.
