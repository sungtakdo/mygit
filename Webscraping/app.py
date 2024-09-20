from flask import Flask, render_template
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import time

app = Flask(__name__)

# 크롤링 함수 정의
def get_team_data(url):
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")  # 화면 없이 실행
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
    driver.get(url)
    time.sleep(3)  # 페이지 로딩 대기
    
    teams = []
    try:
        table = driver.find_element(By.CSS_SELECTOR, 'table[summary="팀 순위"]')
        rows = table.find_elements(By.TAG_NAME, 'tr')[1:]  # 헤더 제외

        for row in rows:
            columns = row.find_elements(By.TAG_NAME, 'td')
            if len(columns) > 0:
                rank = columns[0].text.strip()
                team_name = columns[1].text.strip()
                games_played = columns[2].text.strip()
                points = columns[3].text.strip()

                teams.append({
                    'rank': rank,
                    'team_name': team_name,
                    'games_played': games_played,
                    'points': points,
                })
    
    except Exception as e:
        print(f"Error: {e}")
    
    finally:
        driver.quit()  # 드라이버 종료

    return teams

# 개별 리그 크롤링 엔드포인트
@app.route('/premier')
def premier_league():
    url = 'https://sports.news.naver.com/wfootball/record/index'
    teams = get_team_data(url)
    return render_template('premier.html', teams=teams)

@app.route('/la')
def la_liga():
    url = 'https://sports.news.naver.com/wfootball/record/index?category=primera&tab=team'
    teams = get_team_data(url)
    return render_template('la.html', teams=teams)

@app.route('/bundes')
def bundesliga():
    url = 'https://sports.news.naver.com/wfootball/record/index?category=bundesliga&tab=team'
    teams = get_team_data(url)
    return render_template('bundes.html', teams=teams)

@app.route('/seria')
def seria_a():
    url = 'https://sports.news.naver.com/wfootball/record/index?category=seria&tab=team'
    teams = get_team_data(url)
    return render_template('seria.html', teams=teams)

@app.route('/league1')
def ligue_1():
    url = 'https://sports.news.naver.com/wfootball/record/index?category=ligue1&tab=team'
    teams = get_team_data(url)
    return render_template('league1.html', teams=teams)

# 모든 리그 데이터를 한 페이지에서 보여주는 엔드포인트
@app.route('/')
def index():
    premier_url = 'https://sports.news.naver.com/wfootball/record/index'
    la_url = 'https://sports.news.naver.com/wfootball/record/index?category=primera&tab=team'
    bundes_url = 'https://sports.news.naver.com/wfootball/record/index?category=bundesliga&tab=team'
    seria_url = 'https://sports.news.naver.com/wfootball/record/index?category=seria&tab=team'
    ligue_url = 'https://sports.news.naver.com/wfootball/record/index?category=ligue1&tab=team'

    teams1 = get_team_data(premier_url)
    teams2 = get_team_data(la_url)
    teams3 = get_team_data(bundes_url)
    teams4 = get_team_data(seria_url)
    teams5 = get_team_data(ligue_url)

    return render_template('index.html', 
                        teams1=teams1, 
                        teams2=teams2, 
                        teams3=teams3, 
                        teams4=teams4, 
                        teams5=teams5)

if __name__ == '__main__':
    app.run(debug=True)
