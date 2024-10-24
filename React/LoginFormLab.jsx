import React, { useState } from 'react';

function LoginFormLab() {
    const [username, setUsername] = useState("");
    const [email, setEmail] = useState("");
    const [submitted, setSubmitted] = useState(false);

    const handleSubmit = () => {
        setSubmitted(true); // 버튼 클릭 시 제출 상태로 변경
    };

    return (
        <div style={styles.container}>
            {/* 로그인 */}
            <h2>로그인</h2>
            <div style={styles.form}>
                <label style={styles.label}>아이디: </label>
                <input 
                    type='text' 
                    value={username}  
                    onChange={(e) => setUsername(e.target.value)} 
                    style={styles.input} 
                    placeholder='아이디 입력'
                />
            </div>

            <div style={styles.form}>
                <label style={styles.label}>이메일:</label>
                <input 
                    type='text' 
                    value={email}  
                    onChange={(e) => setEmail(e.target.value)} 
                    style={styles.input} 
                    placeholder="이메일 입력" 
                />
            </div>

            <button style={styles.button} onClick={handleSubmit}>로그인</button>
            {/* 로그인 클릭하면 사용자가 입력한 정보를 출력 */}
            {submitted && (
                <div style={styles.output}>
                    <p><strong>아이디: </strong>{username}</p>
                    <p><strong>이메일: </strong>{email}</p>
                </div>
            )}
        </div>
    );
}

const styles = {
    container: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    height: "100vh",
    fontFamily: "Arial, sans-serif",
    },
    form: {
    marginBottom: "10px",
    },
    label: {
    marginRight: "10px",
    },
    input: {
    padding: "8px",
    borderRadius: "5px",
    border: "1px solid #ccc",
    width: "200px",
    },
    button: {
    padding: "10px 20px",
    backgroundColor: "#007bff",
    color: "white",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
    marginTop: "10px",
    },
    output: {
    marginTop: "20px",
    textAlign: "center",
    },
    };

export default LoginFormLab;
