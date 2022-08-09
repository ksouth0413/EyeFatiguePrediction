##################################################################
# 저장된 형태의 데이터 중에 한 파일을 꺼내서 그 변수들에 대해 관찰할 수 있는 파일.
##################################################################




import pickle
import gzip
import numpy as np
import matplotlib.pyplot as plt


with gzip.open('/Users/namhunkim/Downloads/data/data1.txt', 'rb') as f:
    data = pickle.load(f)


# print(data.keys())
key = list(data.keys())

ST = data['ST']
FT = data['FT']
N = data['N']
BF_LR_List = np.array(data['BF_LR_List'])
BF_L_List = np.array(data['BF_L_List'])
BF_R_List = np.array(data['BF_R_List'])
DB = np.array(data['DB'])
DB_abs = np.array(data['DB_abs'])
OCT = np.array(data['OCT'])
RD_Dict1 = data['RD_Dict1']
RD_Dict2 = data['RD_Dict2']




#
# f, axes = plt.subplots(3, 4)
# # 격자 크기 설정
# f.set_size_inches((8,6))
# # 격자 여백 설정
# plt.subplots_adjust(wspace = 0.3, hspace = 0.1)
#
# f.suptitle('RD_Dict1; data', fontsize = 15)
#
# for i in range(1,12):
#     axes[(i-1)//4, (i-1-4*((i-1)//4))].plot(np.cumsum(np.array(RD_Dict1[(i-1)/10])))
#     axes[(i-1)//4, (i-1-4*((i-1)//4))].set_title(str((i-1)/10))
#
# plt.show()
#


# 변수 설명

# 데이터 측정 시작시간 : ST
# 데이터 측정 완료시간 : FT
#
# 기기가 눈을 인지한 횟수 : N
#
# # 1
# 왼쪽과 오른쪽 눈의 깜빡임 횟수 : BF_LR_List
# 실제 오른쪽 눈의 깜빡임 횟수 : BF_L_List
# 실제 왼쪽 눈의 깜빡임 횟수 : BF_R_List

# print(N)
# print(BF_LR_List/N)
# print(BF_R_List/N)
# print(BF_L_List/N)

# # #2
# # 왼쪽과 오른쪽의 깜빡임 수치(0~1)의 차이(DB), 실제 오른쪽 - 실제 왼쪽 : DB
# # 왼쪽과 오른쪽의 깜빡임 수치(0~1)의 차이(DB_abs)의 절댓값 : DB_abs
# print(DB)
# print(DB_abs)
# # # 3
# # 1초당 측정된 깜빡임 값들(0:감음, 1:감지않음, 0.5:측정안됨)의 흐름 : RD_Dict1
# #
# print(RD_Dict1)
# # # 4
# # 눈을 뜨고 다시 감을 때까지 걸린 시간 : OCT
print(OCT/BF_LR_List)

# # # 5
# # 감을때까지 걸린 시간의 흐름(raw-data2) : RD_Dict2
# #
# # print(RD_Dict2)


