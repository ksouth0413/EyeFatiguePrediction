import cv2, dlib
import numpy as np
from imutils import face_utils
from tensorflow.keras.models import load_model
import time
# from keras 대신에 from tensorflow.keras를 하면 오류가 나타나지 않는다.
# 다음고 같은 오류 발생.
#  tf.__internal__.register_clear_session_function(clear_session)
# AttributeError: module 'tensorflow.compat.v2.__internal__' has no attribute 'register_clear_session_function'



IMG_SIZE = (34, 26)

# 경로 설정에 주의!
# 참고로 'shape_predictor_68_face_landmarks.dat'이어야한다.
# 뒤에 .dz 등이 붙으면 안된다.
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('/home/pi/BlinkDetector/eye_blink_detector/shape_predictor_68_face_landmarks.dat')
model = load_model('/home/pi/BlinkDetector/eye_blink_detector/models/2018_12_17_22_58_35.h5')
model.summary()



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



# main
# 이미 있는 동영상에 대해 수행.
# cap = cv2.VideoCapture('/Users/namhunkim/Downloads/작업중/code/Practice2(usingKeras)/videos/test1.mov')
# 확실히 동영상은 훨씬 더 정확도가 높다.


# 0으로 두면, 실시간 영상에 대한 체크가 가능하다.
cap = cv2.VideoCapture(-1 )
# 라즈베리파이에서는 0 대신 -1을 사용한다.

# 눈 깜빡임이 졸음으로 판단되는 시점의 클락 시그널.
clock = 0 # 0 := 졸고있지 않음.

# 완전 졸음 상태가 아닌 눈을 서서히 껌뻑이는 반 졸림 상태를 알려주기 위한 리스트 제작.
sleepCountList = []

# 시작 시각 측정(프로그램이 작동되는 시점 혹은 아래 while loop가 돌아가는 시점으로 볼 수 있음.).
starting_time = time.time() # point

# 졸음 변수
x = 0
# 0 := 깨어있음.
# 1 := 졸고 있음. 이 떄, 모터의 가속이 안됨.
# 2 := 자고 있음. 이 떄, 모터의 가속이 안되고 부져가 울림.

# 기기 오작동 변수
# 기기가 오작동을 일으켜서 졸거나 자고 있다고 판단되면, 큰 문제가 생길 수 있기에
# 기기가 정상 작동 될 때만 모터와 부져가 작동되도록 한다.
y = 0
# 0 := 기기 정상 작동
# 1 := 기기 작동 이상(ex. Not-detected)



# 눈 인식이 안되도 반응하는 부분. 물론 눈 인식이 되어도 이 안에서 계속 돈다.
# 카메라가 켜짐을 의미.
while cap.isOpened():



  ret, img_ori = cap.read()

  if not ret:
    break

  img_ori = cv2.resize(img_ori, dsize=(0, 0), fx=0.5, fy=0.5)

  img = img_ori.copy()
  gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

  faces = detector(gray)

  # 눈 인식되었을 때, 반응하는 부분.
  for face in faces:


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

    # 오른쪽 눈
    left_eye = float(state_l[-3:])
    # print('left eye: ', left_eye)
    right_eye = float(state_r[-3:])
    # print('right eye: ', right_eye)

    # 초기화를 위해 5초동안 있다가 데이터 측정.
    if time.time() - starting_time >= 5:

      # 눈 깜빡임 정의.
      # 오른쪽과 왼쪽 값이 모두 0에서 0.1 사이였을 때, 눈을 (거의) 감고 있다고 판단.
      if left_eye <= 0.1 and right_eye <= 0.1:

        # 눈 깜빡임이 감지되어 졸임상태 판별 시작 문구
        if clock == 1:
          cv2.putText(img, 'Now recording eye blinking time!', (200, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

        # 초기에는 졸음상태가 아님.
        if clock == 0:
          cv2.putText(img, 'Now recording eye blinking time!', (200, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

          # 졸림 인지 시작 시각 저장.
          sleeping_time = time.time()  # point
          # 졸림 상태인 시간
          blink_time = 0  # duration
          clock = 1  # 졸음상태로 전환.
          # 졸음 리스트 초기화
          sleepCountList = []

        # 리스트에 깜빡임 상태 값 넣기
        # 1 := 감음.
        # 0 := 뜸
        sleepCountList.append(1)
        print("blink")

        # 졸림 상태인 시간 정의
        blink_time = (time.time() - sleeping_time)

      # 눈 깜빡임이 없을 때.
      else:
        sleepCountList.append(0)
        print("non-blink")

      # 졸임 상태로 전환됨.
      if clock == 1:
        blink = 0.0
        non_blink = 0.0

        # 리스트에 저장된 값을 통해 총 깜빡임 횟수와 Non-깜빡임 횟수 count.
        for i in range(len(sleepCountList)):
          if sleepCountList[i] == 1:
            blink += 1
          else:
            non_blink += 1

        # 최소 5초이상 데이터가 쌓여야 판단 가능.
        # 최대 20초를 초과하면 반졸림 상태가 아닌 졸음(sleep)으로 판단.
        # 5초 이상 동안 측정된 눈깜빡임 데이터를 리스트에 저장하여 90% 이상이 눈을 감는다고 판단되면, 졸림이라고 정의.
        # 직접 실험에 의한 휴리스틱 알고리즘.

        # 1. 졸음(반졸림) 상태 정의.
        # 5초 동안 눈을 (거의)감고 있으면, 졸고 있다고 경고.
        if blink_time >= 5 and blink_time <= 20:
          if blink >= (blink + non_blink) * 0.9:
            print("=======================================")
            print("You are sleepy")
            cv2.putText(img, 'Warning!', (450, 70), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            # 모터 제어를 위한 졸림 상태 저장.(1 : 졸림)
            x = 1
          else:
            # 모터 제어를 위한 졸림 상태 저장.(0 : 깨어있음)
            clock = 0
            x = 0

        # 2. 잠 상태 정의.
        # 20초 넘게 눈을 (거의)감고 있으면, 졸고 있다고 경고.
        elif blink_time > 20:
          if blink >= (blink + non_blink) * 0.9:
            print("=======================================")
            print("You are sleeping")
            cv2.putText(img, 'Warning!', (450, 70), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
            # 모터 제어를 위한 졸림 상태 저장.(2 : 잠)
            x = 2
          else:
            # 모터 제어를 위한 졸림 상태 저장.(0 : 깨어있음)
            clock = 0

  # for문 바깥의 while문을 계속 돈다.
  # 초기화를 위해 5초동안 있다가 데이터 측정.
  if time.time() - starting_time > 60:
    cv2.putText(img, 'Not-Detected!', (450, 60), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 0, 0), 2)
    # 기기 오작동 상태 저장.
    y = 1

  elif time.time() - starting_time >= 5:

    # 눈 깜빡임 정의.
    # 오른쪽과 왼쪽 값이 모두 0에서 0.1 사이였을 때, 눈을 (거의) 감고 있다고 판단.
    if left_eye <= 0.1 and right_eye <= 0.1:

      if clock == 1:
        cv2.putText(img, 'Now recording eye blinking time!', (200, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

      # 초기에는 졸음상태가 아님.
      if clock == 0:
        cv2.putText(img, 'Now recording eye blinking time!', (200, 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

        # 졸림 인지 시작 시각 저장.
        sleeping_time = time.time()  # point
        # 졸림 상태인 시간
        blink_time = 0  # duration
        clock = 1  # 졸음상태로 전환.
        # 졸음 리스트 초기화
        sleepCountList = []

      # 리스트에 깜빡임 상태 값 넣기
      # 1 := 감음.
      # 0 := 뜸
      sleepCountList.append(1)
      print("blink")

      # 졸림 상태인 시간 정의
      blink_time = (time.time() - sleeping_time)

      # 눈 깜빡임이 없을 때.
    else:
      sleepCountList.append(0)
      print("non-blink")

    # 졸임 상태로 전환됨.
    if clock == 1:
      blink = 0.0
      non_blink = 0.0

      for i in range(len(sleepCountList)):
        if sleepCountList[i] == 1:
          blink += 1
        else:
          non_blink += 1

      # 최소 5초이상 데이터가 쌓여야 판단 가능.
      # 최대 20초를 초과하면 반졸림 상태가 아닌 졸음(sleep)으로 판단.
      # 5초 이상 동안 측정된 눈깜빡임 데이터를 리스트에 저장하여 90% 이상이 눈을 감는다고 판단되면, 졸림이라고 정의.
      # 직접 실험에 의한 휴리스틱 알고리즘.

      # 1. 졸음(반졸림) 상태 정의.
      # 5초 동안 눈을 (거의)감고 있으면, 졸고 있다고 경고.
      if blink_time >= 5 and blink_time <= 20:
        if blink >= (blink + non_blink) * 0.9:
          print("=======================================")
          print("You are sleepy")
          cv2.putText(img, 'Warning!', (450, 70), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
          x = 1
        else:
          clock = 0
          x = 0

      # 2. 잠 상태 정의.
      # 20초 넘게 눈을 (거의)감고 있으면, 졸고 있다고 경고.
      elif blink_time > 20:
        if blink >= (blink + non_blink) * 0.9:
          print("=======================================")
          print("You are sleeping")
          cv2.putText(img, 'Warning!', (450, 70), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
          x = 2
        else:
          clock = 0
          x = 0

  else:
    print("Loading...")










  cv2.imshow('result', img)
  if cv2.waitKey(1) == ord('q'):
    break

# 검토할 점
# 아마 알고리즘 상, 두 눈을 토대로 확인하는 것이므로 한 눈을 감으면 눈을 감지할 수 없는 것 같다.
# 안경을 끼면, 더 정확도가 낮은가? 눈이 깊이 들어가 이쓰면 정확도가 더 낮은가?
# 노트북의 사양(카메라 혹은 메모리 혹은 CPU, GPU)에 따라 차이가 많은 것 같다.
# 마스크를 쓰면 처리를 하기가 어렵다. 특히, 사람이 3명 이상이면 내 경우는 프로그램이 꺼진다.