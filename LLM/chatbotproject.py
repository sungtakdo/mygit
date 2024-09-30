import streamlit as st
import requests
import json

# API URL 설정
base_url = 'https://api.odcloud.kr/api/15071029/v1/uddi:7c6a4eaa-179a-469e-bb19-cd39e221190c'
service_key = 'BQBdGk7ivmswO2MVuwRXPForbZ%2F3vUjq1QgzyqK7exzFmS5F54XRmmrvGv6v8TXIcWT8lMVYbtkt%2Bl4YOHeEDg%3D%3D'

all_data = []  # 모든 데이터를 저장할 리스트

# 페이지를 반복하여 호출
page = 1
while True:
    url = f"{base_url}?page={page}&perPage=73&serviceKey={service_key}"
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        all_data.extend(data['data'])  # 데이터를 리스트에 추가
        if len(data['data']) < 73:  # 데이터가 더 이상 없으면 종료
            break
        page += 1  # 다음 페이지로 이동
    else:
        st.error(f"API 호출 실패: {response.status_code}")
        break

# 시_도 이름 정규화 함수 (API에 있는 시_도 기반)
def normalize_city_name(city_name):
    city_name = city_name.replace(" ", "")  # 공백 제거
    if "서울" in city_name:
        return "서울"
    elif "부산" in city_name:
        return "부산"
    elif "대구" in city_name:
        return "대구"
    elif "인천" in city_name:
        return "인천"
    elif "광주" in city_name:
        return "광주"
    elif "대전" in city_name:
        return "대전"
    elif "울산" in city_name:
        return "울산"
    elif "세종" in city_name:
        return "세종"
    elif "경기" in city_name:
        return "경기도"
    elif "강원" in city_name:
        return "강원도"
    elif "충북" in city_name:
        return "충청북도"
    elif "충남" in city_name:
        return "충청남도"
    elif "전북" in city_name:
        return "전라북도"
    elif "전남" in city_name:
        return "전라남도"
    elif "경북" in city_name:
        return "경상북도"
    elif "경남" in city_name:
        return "경상남도"
    elif "제주" in city_name:
        return "제주도"
    else:
        return city_name

# Streamlit 인터페이스
st.title('장애인 전용 체육시설 찾기')
user_input = st.text_input("찾으시려는 지역을 이야기 해주세요.(ex 서울시 성동구) :")

if user_input:
    def chatbot(user_input):
        results = {}
        user_input = user_input.replace(" ", "")  # 공백 제거

        # 사용자 입력을 시_도와 소재지로 나누기
        normalized_input = normalize_city_name(user_input)

        # '시_도'와 '소재지'를 기준으로 검색
        for item in all_data:
            si_do = (item.get('시_도') or "").replace(" ", "")  # 시_도 값에서 공백 제거
            so_jae_ji = (item.get('소재지') or "").replace(" ", "")  # 소재지 값에서 공백 제거

            # 시_도 정규화 및 비교
            normalized_si_do = normalize_city_name(si_do)

            # 사용자 입력과 시설 정보 비교
            if normalized_input in normalized_si_do or normalized_input in so_jae_ji:  # 시_도 또는 소재지가 포함될 때
                if normalized_si_do not in results:
                    results[normalized_si_do] = []  # 새로운 지역에 대해 결과 리스트 생성
                results[normalized_si_do].append(f"시설명: {item['시설명']}, 주소: {normalized_si_do} {so_jae_ji}, 전화번호: {item['전화번호']}, 홈페이지: {item.get('홈페이지', '없음')}")

        # 결과를 출력할 문자열 생성
        if results:
            final_output = []
            for city, facilities in results.items():
                final_output.append(f"### {city} 지역 체육시설 목록")
                for idx, facility in enumerate(facilities, 1):
                    final_output.append(f"{idx}. {facility}")
            return "\n".join(final_output)
        else:
            return "찾으시는 지역에는 체육 시설이 없습니다. 다른 곳에서 찾으시겠습니까?"

    response = chatbot(user_input)
    st.write("봇:\n", response)
