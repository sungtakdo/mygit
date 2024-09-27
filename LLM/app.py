import streamlit as st
import json
import requests
from langchain_community.vectorstores import FAISS
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain.schema import Document
from langchain.embeddings.sentence_transformer import SentenceTransformerEmbeddings
from langchain_community.chat_models import ChatOllama
from langchain.prompts import ChatPromptTemplate
from langchain.schema.runnable import RunnableMap

sido = "서울"
url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty'
params = {
    'serviceKey': 'BQBdGk7ivmswO2MVuwRXPForbZ/3vUjq1QgzyqK7exzFmS5F54XRmmrvGv6v8TXIcWT8lMVYbtkt+l4YOHeEDg==',  # 올바른 API 키 입력
    'returnType': 'json',
    'numOfRows': '100',
    'pageNo': '1',
    'sidoName': sido,
    'ver': '1.0'
}

response = requests.get(url, params=params)

# 응답 처리
content = response.text  # utf-8 디코딩 없이 간단하게 처리
data = json.loads(content)

# 대기질 데이터 파싱 함수
def parse_air_quality_data(data):
    items = data.get('response', {}).get('body', {}).get('items', [])
    air_quality_info = []
    for item in items:
        info = {
            '측정소명': item.get('stationName'),
            '날짜': item.get('dataTime'),
            'pm10농도': item.get('pm10Value'),
            'pm25농도': item.get('pm25Value'),
            'so2농도': item.get('so2Value'),
            'co농도': item.get('coValue'),
            'o3농도': item.get('o3Value'),
            'no2농도': item.get('no2Value'),
            '통합대기환경수치': item.get('khaiValue'),
            '통합대기환경지수': item.get('khaiGrade'),
            'pm10등급': item.get('pm10Grade'),
            'pm25등급': item.get('pm25Grade')
        }
        air_quality_info.append(info)
    return air_quality_info


# 대기질 데이터 분석 및 출력
air_quality_info = parse_air_quality_data(data)
print(air_quality_info)

# FAISS 처리
from langchain_community.vectorstores import FAISS
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain.schema import Document

# 벡터 형태로 문서 변환
documents = [Document(page_content=", ".join(
    [f"{key}: {str(info[key])}" for key in ['측정소명', '날짜', 'pm10농도', 'pm25농도', '통합대기환경수치']]
)) for info in air_quality_info]
print(documents)


def main():
    st.title("대기질 정보 제공 챗봇")

    text_var = st.text_input("조사할 지역을 적어주세요")
    clicked_button = st.button("제출")
    if clicked_button:
        result = seoul_pm_query(text_var)
        air_quality_info = parse_air_quality_data(result)
        st.write(f"{air_quality_info}")
if __name__ == "__main__":
    main()