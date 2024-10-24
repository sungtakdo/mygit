import React, { useState } from 'react'

function UserProfile() {
    const[name, setName] = useState('홍길동')
    const[age, setAge] = useState(26)
  return (
    <div style={styles.container}>
      <h1>사용자 프로필</h1>
      <p style={styles.info}>이름: {name}</p>
      <p style={styles.info}>나이: {age}세</p>
      <button style={styles.box}onClick={()=> setName("김철수")}>이름변경</button>
      <button style={styles.box}onClick={()=> setAge(27)}>나이변경</button>
    </div>
  )
}

const styles = {
    container: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    fontFamily: "Arial, sans-serif",
    },
    info: {
    fontSize: "18px",
    margin: "5px 0", // 이름과 나이 사이의 간격 조정
    },
    button: {
    padding: "10px 20px",
    margin: "0 10px", // 버튼 간의 좌우 여백 설정
    backgroundColor: "#e8e9ea",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
    fontSize: "16px",
    },
    };

export default UserProfile
