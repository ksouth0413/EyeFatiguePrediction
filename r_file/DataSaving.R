# 1. X
# install.packages("writexl")
# install.packages("openxlsx")
library(writexl)
library(openxlsx)

data <- createWorkbook("data")
data
addWorksheet(data, 'Fatigue')
addWorksheet(data, 'SurveyFatigue')
addWorksheet(data, 'BlinkCount')
addWorksheet(data, 'RightminusLeftCount')
addWorksheet(data, 'RightminusLeftMeasureDiff')
addWorksheet(data, 'OpenEyeTime')
data
writeDataTable(data, 'Fatigue', data.frame(Y2))
writeDataTable(data, 'SurveyFatigue', data.frame(Y1))
writeDataTable(data, 'BlinkCount', data.frame(X))
writeDataTable(data, 'RightminusLeftCount', data.frame(X2.4))
writeDataTable(data, 'RightminusLeftMeasureDiff', data.frame(X2.2))
writeDataTable(data, 'OpenEyeTime', data.frame(X3))
saveWorkbook(data, file='/Users/namhunkim/Downloads/data.xlsx')
