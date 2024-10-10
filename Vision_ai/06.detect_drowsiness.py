from imutils import face_utils
from datetime import datetime
import numpy as np
import argparse
import imutils
import time
import dlib
import cv2
import os
from PIL import Image, ImageFont, ImageDraw
import pygame
import threading
import time
#from class_naver_sms_service import naver_sms_sender

#=================================================================
#눈동자 가로,세로 비율의 Moving Average 처리
#=================================================================
def calculate_average(value):
	global g_window_Size
	global g_data

	g_data.append(value)
	if len(g_data) > g_window_Size:
		g_data = g_data[-g_window_Size:]
	
	if len(g_data) < g_window_Size:
		return 0.0
	return float(sum(g_data) / g_window_Size)

#=================================================================
# 눈동자 가로, 세로euclidean거리 구하기
#=================================================================
def euclidean_dist(ptA, ptB):
	return np.linalg.norm(ptA - ptB)

#눈의 가로, 세로 종횡비 구하기 
def eye_aspect_ratio(eye):
	#눈의 세로 
	a = euclidean_dist(eye[1], eye[5])
	b = euclidean_dist(eye[2], eye[4])
	#눈의 가로 
	c = euclidean_dist(eye[0], eye[3])
	ear = (a + b) / (1.5 * c)
	return ear

#=================================================================
#졸음 감지 시 알림 처리 sms send, wave play,  
#=================================================================
def alarm_notification(filename, to_number):

	'''
	print("Send SMS")
	sms_sender=naver_sms_sender()
	sms_sender.send_sms(to_number)
	'''
	print("Play wave")
	pygame.init()
	pygame.mixer.init()
	pygame.mixer.music.load(filename)
	pygame.mixer.music.play()

	while pygame.mixer.music.get_busy():
		continue 
	
	pygame.quit()

#=================================================================
#Alarm 처리 Thread 
#마지막 알람 발생 후 30초 후 알람 발생 
#=================================================================
def start_Alarm():
	global g_pre_alarm_time
	cur_time = time.time()
	
	if (cur_time - g_pre_alarm_time) > 30:
		filename = 'test.wav'
		to_number = '01042270078'
		thread = threading.Thread(target=alarm_notification, args=(filename,to_number,))
		thread.start()
		g_pre_alarm_time = cur_time
	else:
		print("Alarm is not progress time: {0}s.".format(int(cur_time - g_pre_alarm_time)))


#=================================================================
#초기값 설정
#=================================================================
g_pre_alarm_time = 0
g_window_Size = 30
g_data =[]
g_blinkCounter = 0

#실행 경로 설정 
this_program_directory = os.path.dirname(os.path.abspath(__file__))
os.chdir(this_program_directory)

#한글 폰트 설정 
fontpath = "C:\Windows\Fonts\gulim.ttc"
font = ImageFont.truetype(fontpath, 36)

#=================================================================
#얼굴 감지, 눈동자 감지 처리 
#=================================================================
#face detecor pre trained NN 
detector = dlib.get_frontal_face_detector()

#dlib's facial landmark NN 초기화
predictor = dlib.shape_predictor('shape_predictor_68_face_landmarks.dat')

# 오른쪽, 왼쪽 눈 좌표 인덱스 
(lStart, lEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rStart, rEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]

cap = cv2.VideoCapture(0)

if not cap.isOpened():
	print("Error: 비디오 파일을 열 수 없습니다.")
	exit()
time.sleep(2.0)

while True:
	#웹캠 영상 읽기
	ret, frame = cap.read()
	if not ret:
		print("비디오가 끝났거나 에러가 발생했습니다.")
		break

	frame = imutils.resize(frame, width=720)
	frame = cv2.flip(frame, 1)

	#입력영상 graysale 처리 
	gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

	# 얼굴 Detection 
	rects = detector(gray)	
   
	for rect in rects:
		x, y = rect.left(), rect.top()
		w, h = rect.right() - x, rect.bottom() - y
		
		#print( w, h)
		#얼굴 크기가 110이상일때만 눈동자 Detection
		#if (w > 110 ):
		#얼굴 영역 bounding box 그리기
		cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)

		#눈동자 Detection(68 landmarks)
		shape = predictor(gray, rect)
		shape = face_utils.shape_to_np(shape)
		
		#왼쪽 및 오른쪽 눈 좌표를 추출한 다음 좌표를 사용하여 양쪽 눈의 눈 종횡비를 계산
		leftEye = shape[lStart:lEnd]
		rightEye = shape[rStart:rEnd]
		leftEAR = eye_aspect_ratio(leftEye)
		rightEAR = eye_aspect_ratio(rightEye)
		
		#print( ear_avg )
		# 양쪽 눈동자 외각선 찾기
		leftEyeHull = cv2.convexHull(leftEye)
		rightEyeHull = cv2.convexHull(rightEye)

		#양쪽 눈동자 녹색 외각선 그리기
		#cv2.drawContours(frame, [leftEyeHull], 0, (0, 255, 0), 1)
		#cv2.drawContours(frame, [rightEyeHull], 0, (0, 255, 0), 1)
		#양쪽 눈동자 녹색 점 그리기
		cv2.circle(frame, tuple(rightEye[[0,0][0]]), 2, (0,255,0), -1)
		cv2.circle(frame, tuple(rightEye[[1,0][0]]), 2, (0,255,0), -1)
		cv2.circle(frame, tuple(rightEye[[2,0][0]]), 2, (0,0,0), -1)
		cv2.circle(frame, tuple(rightEye[[3,0][0]]), 2, (0,0,0), -1)
		cv2.circle(frame, tuple(rightEye[[4,0][0]]), 2, (0,0,0), -1)
		cv2.circle(frame, tuple(rightEye[[5,0][0]]), 2, (0,0,0), -1)   
		
		cv2.circle(frame, tuple(leftEye[[0,0][0]]), 2, (0,255,0), -1)
		cv2.circle(frame, tuple(leftEye[[1,0][0]]), 2, (0,255,0), -1)
		cv2.circle(frame, tuple(leftEye[[2,0][0]]), 2, (0,0,0), -1)
		cv2.circle(frame, tuple(leftEye[[3,0][0]]), 2, (0,0,0), -1)
		cv2.circle(frame, tuple(leftEye[[4,0][0]]), 2, (0,0,0), -1)
		cv2.circle(frame, tuple(leftEye[[5,0][0]]), 2, (0,0,0), -1)

		#print( leftEAR, rightEAR )
		#양쪽 눈의 종횡비 평균
		ear = (leftEAR + rightEAR) / 2.0
		#양쪽 눈의 종횡비율의 Moving Average 처리(오탐 방지)
		ear_avg= calculate_average(ear)

		# 눈 가로 세로 비율이 0.3 미만이면 깜빡임으로 판단. 
		if ear_avg < 0.22:
			# 깜박임 회수 + 1
			g_blinkCounter += 1

			# 깜박임 회수가 50회(약 5초) 이상이면 눈감음으로 판단. 
			if g_blinkCounter >= 40:				
				img_pillow = Image.fromarray(frame)
				draw = ImageDraw.Draw(img_pillow, 'RGBA')
				draw.text((5, 10), "졸음이 감지 되었습니다", (0,0,255), font=font)
				frame = np.array( img_pillow )

				#양쪽 눈동자 빨간 점 그리기
				cv2.circle(frame, tuple(rightEye[[3,0][0]]), 2, (0,0,255), -1)
				cv2.circle(frame, tuple(leftEye[[0,0][0]]), 2, (0,0,255), -1)
				start_Alarm()
		else:
			g_blinkCounter = 0
				
	
	cv2.imshow("Frame", frame)
	key = cv2.waitKey(1) & 0xFF
	if key == ord("q"):
		break

cap.release()
cv2.destroyAllWindows()