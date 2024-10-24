import React, { useState } from 'react';

function User() {  // 컴포넌트 이름 대문자로 수정
    const [username, setUsername] = useState('');
    const [tel, setTel] = useState('');
    const [email, setEmail] = useState('');
    const [submitted, setSubmitted] = useState(false);

    const handleLogin = () => {
        setSubmitted(true);
    };

    return (
        <div style={styles.container}>
            <label style={styles.label}>이름</label>
            <input 
                type='text' 
                value={username} 
                onChange={(e) => setUsername(e.target.value)}
                style={styles.input}
            />  

            <label style={styles.label}>연락처</label>
            <input 
                type='text' 
                value={tel} 
                onChange={(e) => setTel(e.target.value)}
                style={styles.input}
            />

            <label style={styles.label}>email</label>
            <input 
                type='text' 
                value={email} 
                onChange={(e) => setEmail(e.target.value)}
                style={styles.input}
            /> 

            <button style={styles.button} onClick={handleLogin}>제출</button>
            
            {submitted && (
                <div style={styles.output}>
                    <p>이름: {username}</p>
                    <p>연락처: {tel}</p>
                    <p>이메일: {email}</p>
                </div>
            )}
        </div>
    );
}

export default User;  // 컴포넌트 이름 수정

const styles = {
    container: {
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        height: "100vh",
        fontFamily: "Arial, sans-serif",
    },
    label: {
        marginRight: "10px",
        display: "block",
        marginTop: "10px",
    },
    input: {
        padding: "8px",
        borderRadius: "5px",
        border: "1px solid #ccc",
        width: "200px",
        marginBottom: "10px",
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
