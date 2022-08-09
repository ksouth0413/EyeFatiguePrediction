##################################################################
# 눈깜빡임 관련 변수들 데이터를 얻는 파일.
##################################################################







######################################################
# 필요한 라이브러리와 파일 등을 불러오기
import datetime
import cv2, dlib
import numpy as np
from imutils import face_utils
import time
from keras.models import load_model
import pickle
import gzip



IMG_SIZE = (34, 26)

# 경로 설정에 주의!
# 참고로 'shape_predictor_68_face_landmarks.dat'이어야한다.
# 뒤에 .dz 등이 붙으면 안된다. 즉, 압축을 풀어주어야 한다는 뜻이다.
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('/Users/namhunkim/Downloads/shape_predictor_68_face_landmarks.dat')
model = load_model('/Users/namhunkim/Downloads/2018_12_17_22_58_35.h5')
model.summary()







######################################################
# 필요한 함수 선언

# 눈 이미지를 잘라서 자른 이미지 데이터와 좌표값을 반환
def crop_eye(img, eye_points):
  x1, y1 = np.amin(eye_points, axis=0)
  x2, y2 = np.amax(eye_points, axis=0)
  cx, cy = (x1 + x2) / 2, (y1 + y2) / 2

  w = (x2 - x1) * 1.2
  h = w * IMG_SIZE[1] / IMG_SIZE[0]

  margin_x, margin_y = w / 2, h / 2

  min_x, min_y = int(cx - margin_x), int(cy - margin_y)
  max_x, max_y = int(cx + margin_x), int(cy + margin_y)

  eye_rect = np.rint([min_x, min_y, max_x, max_y]).astype(np.int)

  eye_img = gray[eye_rect[1]:eye_rect[3], eye_rect[0]:eye_rect[2]]

  return eye_img, eye_rect











######################################################
# main



######################################################
# 변수 선언

# 이미 있는 동영상에 대해 수행.
# cap = cv2.VideoCapture('/Users/namhunkim/Downloads/작업중/code/Practice2(usingKeras)/videos/test1.mov')
# 확실히 동영상은 훨씬 더 정확도가 높다.


# 0으로 두면, 실시간 영상에 대한 체크가 가능하다.
cap = cv2.VideoCapture(0)
# 라즈베리파이에서는 0 대신 -1을 사용한다.








######################################################
# 눈 깜빡임 지표들

# 깜빡임 수와 관련

# 1. 눈깜빡임 비율(Blink Frequency)
N = 0.0 # 전체 측정된 횟수

BF_LR_List = list(np.zeros(11)) # 왼쪽과 오른쪽 눈 모두 어떤 bound값 이하로 값이 떨어졌을 때
BF_L_List = list(np.zeros(11)) # 오른쪽 눈이 어떤 bound값 이하로 값이 떨어졌을 때
BF_R_List = list(np.zeros(11)) # 왼쪽 눈이 어떤 bound값 이하로 값이 떨어졌을 때

# 2. 양안 수치 차이(Difference of Both eyes)
DB = 0.0 # 왼쪽 눈과 오른쪽 눈의 차이
DB_abs = 0.0 # 왼쪽 눈과 오른쪽 눈의 차이의 절댓값

# 3. 지정된 시간의 깜빡임 값들의 흐름(raw-data1); 양쪽 눈 기준
RD_Dict1 = {0:[], 0.1:[], 0.2:[], 0.3:[], 0.4:[], 0.5:[], 0.6:[], 0.7:[], 0.8:[], 0.9:[], 1.0:[]}



# 깜빡일 때까지 걸린 시간과 관련
# 4. 감을때까지 걸린 시간(Open To Close Time)
clock = list(np.ones(11)) # 1 : 눈을 뜬 상태, 0 : 눈을 감은 상태
Open_Time = list(np.zeros(11)) # 눈을 감고 다시 뜬 순간의 시점(시간)
Blink_Time = list(np.zeros(11)) # 눈을 감은 시점(시간)

OCT = list(np.zeros(11))

# 5. 감을때까지 걸린 시간의 흐름(raw-data2)
RD_Dict2 = {0:[], 0.1:[], 0.2:[], 0.3:[], 0.4:[], 0.5:[], 0.6:[], 0.7:[], 0.8:[], 0.9:[], 1.0:[]}







# 실험이 진행되는 시간 설정.
Experiment_Time = int(input("데이터를 측정할 시간을 설정하십쇼. 단위(분): "))
# 시작 시각 측정(프로그램이 작동되는 시점 혹은 아래 while loop가 돌아가는 시점으로 볼 수 있음.).
starting_time = time.time() # point
clock2 = 0 # 처음 starting_time을 측정하기 위함.
measuring_time = 0.0 # 시작 뒤에 5초가 지나면 데이터 기록을 시작하는 시점.



######################################################
# 첫번째 반복문
# 카메라가 켜짐을 의미.
while cap.isOpened():

  ret, img_ori = cap.read()

  if not ret:
    break

  img_ori = cv2.resize(img_ori, dsize=(0, 0), fx=0.5, fy=0.5)

  img = img_ori.copy()
  gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

  faces = detector(gray)







  ######################################################
  # 두번째 반복문

  # 첫번째 while안의 반복문으로
  for face in faces: # 눈이 인식되어야 돌아간다. 눈이 인식이 안되면 faces=NULL인 것 같다.





    ######################################################
    # NEW
    # 눈이 잘 인식되는지 5초정도 확인하는 시간을 준다. 이 5초 동안은 값이 측정되지 않는다.
    if time.time() - starting_time < 5:
      print("Loading")

    elif time.time() - starting_time >= 5:
      N += 1


      # 시작시간인 ST를 정의
      # 정확히 5라는 차이가 나지 않음으로 다음과 같이 차이가 1이하이면 그 시간을 시작시간으로 한다.
      if ( (time.time() - starting_time >= 5) & (clock2==0) ):
        measuring_time = time.time() # 데이터를 측정하기 시작한 시점
        ST = datetime.datetime.today()
        clock2=1
        print("Okay, the test is started!!!")

        for i in range(11):
          # 눈 깜빡임 시간 변수들을 정의하기 위한 다른 변수들.
          # 초기값을 현재시간으로 지정해준다.
          Open_Time[i] = time.time()
          Blink_Time[i] = time.time()

      # 5초가 지나서 프로그램이 기록을 시작함을 알려준다. 이제 다른 작업을 해도 된다.
      cv2.putText(img, 'Now recording eye blinking!', (200, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

    ######################################################


    # 눈으로부터 데이터를 얻어 수치화하는 부분.
    shapes = predictor(gray, face)
    shapes = face_utils.shape_to_np(shapes)

    eye_img_l, eye_rect_l = crop_eye(gray, eye_points=shapes[36:42])
    eye_img_r, eye_rect_r = crop_eye(gray, eye_points=shapes[42:48])

    eye_img_l = cv2.resize(eye_img_l, dsize=IMG_SIZE)
    eye_img_r = cv2.resize(eye_img_r, dsize=IMG_SIZE)
    eye_img_r = cv2.flip(eye_img_r, flipCode=1)

    cv2.imshow('l', eye_img_l)
    cv2.imshow('r', eye_img_r)

    eye_input_l = eye_img_l.copy().reshape((1, IMG_SIZE[1], IMG_SIZE[0], 1)).astype(np.float32) / 255.
    eye_input_r = eye_img_r.copy().reshape((1, IMG_SIZE[1], IMG_SIZE[0], 1)).astype(np.float32) / 255.

    pred_l = model.predict(eye_input_l)
    pred_r = model.predict(eye_input_r)

    # visualize
    state_l = 'O %.1f' if pred_l > 0.1 else '- %.1f'
    state_r = 'O %.1f' if pred_r > 0.1 else '- %.1f'

    state_l = state_l % pred_l
    state_r = state_r % pred_r

    cv2.rectangle(img, pt1=tuple(eye_rect_l[0:2]), pt2=tuple(eye_rect_l[2:4]), color=(255,255,255), thickness=2)
    cv2.rectangle(img, pt1=tuple(eye_rect_r[0:2]), pt2=tuple(eye_rect_r[2:4]), color=(255,255,255), thickness=2)

    cv2.putText(img, state_l[-3:], tuple(eye_rect_l[0:2]), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255,255,255), 2)
    cv2.putText(img, state_r[-3:], tuple(eye_rect_r[0:2]), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255,255,255), 2)







    ######################################################
    # 필요한 주요 변수값 2개.

    # 오른쪽 눈
    left_eye = float(state_l[-3:]) # 사진 상으로 봤을 때(실제와 좌우 대칭임)의 왼쪽 눈
    # print('left eye: ', left_eye)

    # 왼쪽 눈
    right_eye = float(state_r[-3:])
    # print('right eye: ', right_eye)



    # 눈이 잘 인식되는지 5초정도 확인하는 시간. 이 때는 값이 측정되지 않는다.
    if ( time.time() - starting_time ) >= 5:




      ######################################################
      # NEW

      # 눈 깜빡임 횟수 변수들
      # 1. BF(Blink Frequency)
      for i in range(11):
        BF_LR_List[i] += float( (left_eye <= i/10) & (right_eye <= i/10) )
        BF_L_List[i] += float(left_eye <= (i/10))
        BF_R_List[i] += float(right_eye <= (i/10))

      # 2. 양안 수치 차이(Difference of Both eyes)
      DB += (left_eye - right_eye)
      DB_abs += abs(left_eye - right_eye)

      # 3. RD1(raw-data1)
      if ( (time.time() - measuring_time) >= 1 ) : # 데이터가 정확히 1초 차이나도록 할 수 없음으로 다음과 같이 범위로 둔다.
        for i in range(11):
          RD_Dict1[i / 10].append(float((left_eye <= i / 10) & (right_eye <= i / 10)))
        measuring_time = time.time()  # 1초 마다 데이터가 수집되도록 1초 간격으로 그 때의 데이터를 집어넣는다.







      # 눈 깜빡임 시간 변수들
      # 4. OCT(Open To Close Time)
      for i in range(11):

        if (left_eye > i/10) & (clock[i] == 0):  # 눈을 뜰 때의 시간을 측정; A
          # 눈을 감고 있다가 맨 처음으로 떳을 때를 측정
          # clock에서 1(눈뜸), 2(눈감음)
          Open_Time[i] = time.time()
          clock[i] = 1  # 눈을 뜬 상태


        if left_eye <= i/10:  # 눈을 감을 때의 시간을 측정; B
          # 눈을 뜨고 있다가 맨 처음으로 감았을 때를 측정
          Blink_Time[i] = time.time()
          clock[i] = 0  # 눈을 감은 상태



          OCT[i] += (Blink_Time[i] - Open_Time[i]) # 무조건 양수로 측정된다.
          # 왜냐하면 처음 clock[i]값은 1임으로 A를 돌 수 없고, B부터 돌아가게 된다.
          # 그리고 B가 돌아가면 clock[i]값은 0으로 눈이 뜰 때 까지 계속 A는 안돌아간다.
          # 이후에 눈을 뜨게 되면, A가 돌아가게 되어서 눈이 감을 때부터 뜬 시간이 측정된다.
          # 그리고 이제 또 clock[i]이 1로 바뀌기에 A는 돌 수 없고, 눈이 감길 때 clock[i]가 0으로 바뀌면서
          # 다시 반복이다.

          # 5. RD2(raw-data2)
          RD_Dict2[i/10].append( float(Blink_Time[i] - Open_Time[i]) )


      ######################################################





  ######################################################
  # 이전의 첫번째 반복문(while)의 안, 두번째 반복문(for)의 밖

  # for문에서는 그냥 처리를 하는 것이고,
  # 인식의 여부는 while문과 관련이 있는 것 같다.
  # 즉, 인식이 안되면 for문을 돌지 않는건 사실이나 faces값이 NULL임으로
  # 인식이 되어 for문이 돌아도 faces 처리 이후에 while을 돈다.
  # 즉, while문의 경우에는 인식의 여부와 무관하게 모두 거치고 간다.


  # if (time.time() - starting_time) >= 5:
  #   for i in range(11):
  #     RD_Dict1[i/10].append(0.5)


  cv2.imshow('result', img)
  if cv2.waitKey(1) == ord('q'):
    break



  ######################################################
  # 실험시간이 끝나면, 데이터 측정을 끝내고, 데이터 저장을 단계로 넘어간다.
  if (time.time() - starting_time) >= Experiment_Time*60 + 5:
    FT = datetime.datetime.today()
    break




######################################################
# 첫번째 반복문인 while의 바깥부분, main의 안쪽부분.
# 데이터의 저장을 한다.
data = {'ST':ST, 'FT':FT, 'N':N, 'BF_LR_List':BF_LR_List, 'BF_L_List':BF_L_List, 'BF_R_List':BF_R_List,
        'DB':DB, 'DB_abs':DB_abs, 'RD_Dict1':RD_Dict1, 'OCT':OCT, 'RD_Dict2':RD_Dict2 }
with gzip.open('/Users/namhunkim/Downloads/data/data-1.txt', 'wb') as f:
    pickle.dump(data, f)






#####################################################
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
#
# #2
# 왼쪽과 오른쪽의 깜빡임 수치(0~1)의 차이(DB), 실제 오른쪽 - 실제 왼쪽 : DB
# 왼쪽과 오른쪽의 깜빡임 수치(0~1)의 차이(DB_abs)의 절댓값 : DB_abs
#
# # 3
# 1초당 측정된 깜빡임 값들(0:감음, 1:감지않음, 0.5:측정안됨)의 흐름 : RD_Dict1
#
# # 4
# 눈을 뜨고 다시 감을 때까지 걸린 시간 : OCT
#
# # 5
# 감을때까지 걸린 시간의 흐름(raw-data2) : RD_Dict2
#

