##################################################################
# 눈깜빡임 관련해서 .txt로 압축된 파일(pickle&gzip)로부터 필요한 변수를 한 csv파일로 정리 및 저장하는 파일.
##################################################################




import pickle
import gzip
import numpy as np
import matplotlib.pyplot as plt
import csv



#
# ##################################################################
# # 1. 양안의 눈깜빡임수를 저장.
#
#
# with open('/Users/namhunkim/Downloads/Summary.csv', 'w', newline='\n') as g:
#     G = csv.writer(g)
#     G.writerow(['index','N','0','0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0'])
#
# for i in range(6,81+1):
#
#     with gzip.open('/Users/namhunkim/Downloads/data/data'+str(i)+'.txt', 'rb') as f:
#         data = pickle.load(f)
#
#     # print(data.keys())
#     key = list(data.keys())
#
#     ST = data['ST']
#     FT = data['FT']
#     N = data['N']
#     BF_LR_List = np.array(data['BF_LR_List'])
#     BF_L_List = np.array(data['BF_L_List'])
#     BF_R_List = np.array(data['BF_R_List'])
#     DB = np.array(data['DB'])
#     DB_abs = np.array(data['DB_abs'])
#     OCT = np.array(data['OCT'])
#     RD_Dict1 = data['RD_Dict1']
#     RD_Dict2 = data['RD_Dict2']
#
#     # 변수 설명
#
#     # 기기가 눈을 인지한 횟수 : N
#
#     # 왼쪽과 오른쪽 눈의 깜빡임 횟수 : BF_LR_List
#     # 실제 오른쪽 눈의 깜빡임 횟수 : BF_L_List
#     # 실제 왼쪽 눈의 깜빡임 횟수 : BF_R_List
#
#     BF_LR_List = BF_LR_List / N
#
#     data_list = []
#     data_list.extend([i,N])
#     data_list.extend(list(BF_LR_List))
#
#     # 데이터 확인용 data10.txt로부터 얻어진 자료를 출력.
#     # if i == 10:
#     #     print(data_list)
#     if i < 10:
#         print(OCT)
#
#     with open('/Users/namhunkim/Downloads/Summary.csv', 'a', newline='\n') as g:
#         G = csv.writer(g)
#         G.writerow(data_list)









# ##################################################################
# # 2. 왼쪽과 오른쪽 눈의 깜빡임 관련 지표 차이를 저장.
#
#
#
#
#
# with open('/Users/namhunkim/Downloads/Summary1.csv', 'w', newline='\n') as g:
#     G = csv.writer(g)
#     G.writerow(['index','L-R','abs(L-R)','DB', 'DB_abs'])
#
# for i in range(6,81+1):
#
#     with gzip.open('/Users/namhunkim/Downloads/data/data'+str(i)+'.txt', 'rb') as f:
#         data = pickle.load(f)
#
#     # print(data.keys())
#     key = list(data.keys())
#
#     ST = data['ST']
#     FT = data['FT']
#     N = data['N']
#     BF_LR_List = np.array(data['BF_LR_List'])
#     BF_L_List = np.array(data['BF_L_List'])
#     BF_R_List = np.array(data['BF_R_List'])
#     DB = np.array(data['DB'])
#     DB_abs = np.array(data['DB_abs'])
#     OCT = np.array(data['OCT'])
#     RD_Dict1 = data['RD_Dict1']
#     RD_Dict2 = data['RD_Dict2']
#
#     # 변수 설명
#
#     # 기기가 눈을 인지한 횟수 : N
#
#     # 왼쪽과 오른쪽 눈의 깜빡임 횟수 : BF_LR_List
#     # 실제 오른쪽 눈의 깜빡임 횟수 : BF_L_List
#     # 실제 왼쪽 눈의 깜빡임 횟수 : BF_R_List
#
#     LR = (BF_L_List[0] - BF_R_List[0]) / N
#     LR_abs = abs(BF_L_List[0] - BF_R_List[0]) / N
#     DB = DB / N
#     DB_abs = DB_abs / N
#
#
#     data_list = [i,LR,LR_abs,DB,DB_abs]
#
#
#     if i < 10:
#         print(data_list)
#
#
#     with open('/Users/namhunkim/Downloads/Summary1.csv', 'a', newline='\n') as g:
#         G = csv.writer(g)
#         G.writerow(data_list)




















##################################################################
# 3. 왼쪽과 오른쪽 눈의 깜빡임 관련 지표 차이를 저장.





with open('/Users/namhunkim/Downloads/Summary2.csv', 'w', newline='\n') as g:
    G = csv.writer(g)
    G.writerow(['index','OCT'])

for i in range(6,81+1):

    with gzip.open('/Users/namhunkim/Downloads/data/data'+str(i)+'.txt', 'rb') as f:
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

    # 변수 설명

    # 기기가 눈을 인지한 횟수 : N

    # 왼쪽과 오른쪽 눈의 깜빡임 횟수 : BF_LR_List
    # 실제 오른쪽 눈의 깜빡임 횟수 : BF_L_List
    # 실제 왼쪽 눈의 깜빡임 횟수 : BF_R_List

    OCT = OCT / BF_LR_List
    print(OCT)

    data_list = [i,OCT[0]]


    if i < 10:
        print(data_list)


    with open('/Users/namhunkim/Downloads/Summary2.csv', 'a', newline='\n') as g:
        G = csv.writer(g)
        G.writerow(data_list)

