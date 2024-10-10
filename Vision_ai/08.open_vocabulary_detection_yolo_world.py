# YOLOv8 라이브러리 및 torch 임포트
from ultralytics import YOLOWorld
import torch
import cv2
import time  # FPS 계산을 위한 모듈

# GPU가 사용 가능한지 확인 (GPU가 없으면 CPU 사용)
device = 'cuda' if torch.cuda.is_available() else 'cpu'
print(f'Using device: {device}')

# YOLOv8 모델 불러오기, 선택한 장치로 로드
model = YOLOWorld('yolov8x-worldv2.pt')
model.to(device)  # 모델을 선택한 장치로 이동
model.set_classes(["person", "cup", "head"])

# 웹캠 비디오 캡처 시작 (기본 카메라)
#cap = cv2.VideoCapture(0)
cap = cv2.VideoCapture("eyes.jpg")
if not cap.isOpened():
    print("웹캠을 열 수 없습니다.")
    exit()

# FPS 계산을 위한 이전 시간 초기화
prev_time = 0

# 실시간 웹캠 객체 탐지
while True:
    # 웹캠 프레임 읽기
    ret, frame = cap.read()
    if not ret:
        print("프레임을 읽을 수 없습니다. 종료합니다.")
        break

    # FPS 계산
    current_time = time.time()  # 현재 시간
    fps = 1 / (current_time - prev_time) if prev_time != 0 else 0  # FPS 계산
    prev_time = current_time  # 이전 시간 업데이트

    # YOLOv8 모델을 사용하여 프레임에서 객체 탐지 (지정한 device 사용)
    results = model.predict(frame, device=device)

    # 결과를 시각화하여 프레임에 그리기
    annotated_frame = results[0].plot()

    # FPS를 프레임에 추가
    cv2.putText(annotated_frame, f"FPS: {fps:.2f}", (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)

    # 화면에 출력
    cv2.imshow("Real Time Open-Vocabulary Object Detection(YOLO-World)", annotated_frame)

    # 'q' 키를 누르면 종료
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# 모든 리소스 해제
cap.release()
cv2.destroyAllWindows()
