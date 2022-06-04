################################################
# Data-Processing

y <- seq(0,6)
y
x <- list('0'=c(),'1'=c(),'2'=c(), '3'=c(),'4'=c(), '5'=c(), '6'=c())
x
length(X)
length(Questionary1$SubjectiveGrade)
Questionary1$SubjectiveGrade
Summary[,1]
for (i in y) {
  for (j in 1:length(X)) {
    if (i==as.character(Questionary1$SubjectiveGrade[j])) {
      x[[i+1]] <- c(x[[i+1]], X[j])
    }
  }
}
x


Mean <- c()
for (i in x) {
  Mean <- c(Mean, mean(i))
}
Mean
par(mfrow=c(1,1))
# ???? ?Ƿ??Ҽ??? ?????Ӽ??? ?????ϴ? ?????? ?ִ?.




################################################
# Plot
# pch: dot-kind, lwd: dot-size
plot(Mean, pch=19, lwd=5) # just dot.

par(mfrow=c(2,2))
barplot(Mean, main='Mean', ylab='BlinkCount', xlab='FatigueScore')
stripchart(X~Y2, main='individual value', vertical=T, ylab='BlinkCount', xlab='FatigueScore')
library(gplots)
plotmeans(X ~ Y2, main='95% interval', ylab='BlinkCount', xlab='FatigueScore')           # 95% confidence intervals
boxplot(X ~ Y2, main='boxplot',ylab='BlinkCount', xlab='FatigueScore')
################################################
# One-way Anova
X.aov <- aov(X ~ Y2)   # ANOVA
X.aov
summary(X.aov)


# Manually executing Anova.
k <- length(x) # the number of populations
k
PA <- c()
for (i in 1:length(x)) {
  PA <- c(PA, length(x[[i]]))
}
PA
DF <- c(k-1, sum(PA)-k, sum(PA)-1) # Degree of Freedom
DF
X
TotalMean <- mean(X)
SS <- c() # Sum of Squares
MS <- c() # Mean Square
F.value <- c()

# Treatment Sum of Squares; SSTR
z <- c()
for(i in 1:k) {
  for(j in 1:length(x[[i]])) {
    z <- c(z, (Mean[i] - TotalMean)**2)
  }
}
SS <- c(SS, sum(z))
SS

# Error Sum of Squares
z <- c()
for(i in 1:k) {
  for(j in 1:length(x[[i]])) {
    z <- c(z, (x[[i]][j] - Mean[[i]])**2)
  }
}
SS <- c(SS, sum(z))
SS

# Total Sum of Squares
z <- c()
for(i in 1:k) {
  for(j in 1:length(x[[i]])) {
    z <- c(z, (x[[i]][j] - TotalMean)**2)
  }
}
SS <- c(SS, sum(z))
SS

# Mean Square
for(i in 1:2) {
  MS <- c(MS, SS[i]/DF[i])
}

# F-statistic
F.value <- c(MS[1] / MS[2])
F.value

# Hypothesis-Test

# critical-value
a <- 0.05 # confidence-level
F.criticalValue <- qf(1-a, DF[1], DF[2])
F.criticalValue
ifelse(
  F.value > F.criticalValue,
  print('H0 reject!'),
  print('H0 do not reject.')
)

# p-value
p.value <- 1 - pf(F.value, DF[1], DF[2])
p.value
ifelse(
  p.value < a,
  print('H0 reject!'),
  print('H0 do not reject.')
)

# Drawing F-Dist Graph
plot(density(rf(1000,df1=DF[1],df2=DF[2])), main='F-Dist', xlim=c(0,8))
abline(v=F.value, col='red')
abline(v=F.criticalValue, col='blue')






################################################
# Multiple-Comparision

# Tukey1. Manually-Coding
## samll & semi-medium confidence interval
a = 0.95 # confidence level
## nmeans:  # the number of populations
## df: # df of SSE

MSE = MS[2]
MSE

pair <- c()
interval <- c()
differ.pair <- c()
y
for (i in y) {
  for (j in y) {
    if (i<j) {
      pair <- c(pair, paste(i,j))
      x1 <- c(Mean[i+1]-Mean[j+1] - qtukey(a, nmeans=length(x), df=DF[2]) / sqrt(2) *
               sqrt( MSE * ( 1/length(x[[i+1]]) + 1/length(x[[j+1]]))))
      x2 <- c(Mean[i+1]-Mean[j+1] + qtukey(a, nmeans=length(x), df=DF[2]) / sqrt(2) *
               sqrt( MSE * ( 1/length(x[[i+1]]) + 1/length(x[[j+1]]))))
      interval <- c(interval, paste(x1,x2))
      if (x1*x2 > 0) {
        differ.pair <- c(differ.pair, paste(i,j))
      }
    }
  }
}
pair
interval
data <- data.frame(pair, interval)
data
differ.pair

# ??????��?? ?׷? 0,4?? ???? ???տ? ???̰? ?ִٰ? ???Դ?.
# ?׷??? ?? ?׷???�� ???? ???ؼ? ?񱳸? ?ϸ? ???տ? ???̰? ?ִٰ?
# ???��µ? ?̰? ?߷? ?ű??? ��?̴?.
