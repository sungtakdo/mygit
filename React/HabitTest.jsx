import React, { useState } from 'react';


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
        display: "flex",
        flexDirection: "column",
        alignItems: "flex-start",
        marginBottom: "10px",
    },
    inputGroup: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        marginBottom: "10px",
    },
    label: {
        marginRight: "10px",
        width: "80px",
    },
    input: {
        padding: "8px",
        borderRadius: "5px",
        border: "1px solid #ccc",
        width: "300px",
    },
    buttonContainer: {
        display: "flex",
        justifyContent: "center",
        width: "100%",
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
        textAlign: "left",
    },
    checkboxGroup: {
        display: "flex",
        flexDirection: "row",
        marginBottom: "10px",
    },
    radioGroup: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        marginBottom: "10px",
    },
    successMessage: {
        color: "green",
        marginTop: "10px",
    },
};

function HabitTest() {
    
    const [name, setName] = useState("");
    const [contact, setContact] = useState("");
    const [email, setEmail] = useState("");
    const [gender, setGender] = useState("남");
    const [hobbies, setHobbies] = useState([]);
    const [submitted, setSubmitted] = useState(false);

    // 체크박스 변경 처리 함수
    const handleCheckboxChange = (event) => {
        const { value, checked } = event.target;
        if (checked) {
            setHobbies([...hobbies, value]);
        } else {
            setHobbies(hobbies.filter((hobby) => hobby !== value));
        }
    };

    const handleSubmit = () => {
        setSubmitted(true);
    };

    return (
        <div style={styles.container}>
            <h2>사용자 정보 입력</h2>
            <div style={styles.form}>
                <div style={styles.inputGroup}>
                    <label style={styles.label}>이름</label>
                    <input
                        type='text'
                        value={name}
                        placeholder='이름'
                        onChange={(e) => setName(e.target.value)}
                        style={styles.input}
                    />
                </div>
                <div style={styles.inputGroup}>
                    <label style={styles.label}>연락처</label>
                    <input
                        type='text'
                        value={contact}
                        placeholder='연락처'
                        onChange={(e) => setContact(e.target.value)}
                        style={styles.input}
                    />
                </div>
                <div style={styles.inputGroup}>
                    <label style={styles.label}>email</label>
                    <input
                        type='text'
                        value={email}
                        placeholder='email'
                        onChange={(e) => setEmail(e.target.value)}
                        style={styles.input}
                    />
                </div>
                <div style={styles.radioGroup}>
                    <label style={styles.label}>성별</label>
                    <label>
                        <input
                            type='radio'
                            value='남'
                            checked={gender === '남'}
                            onChange={(e) => setGender(e.target.value)}
                        />
                        남
                    </label>
                    <label style={{ marginLeft: "10px" }}>
                        <input
                            type='radio'
                            value='여'
                            checked={gender === '여'}
                            onChange={(e) => setGender(e.target.value)}
                        />
                        여
                    </label>
                </div>
                <div style={styles.checkboxGroup}>
                    <label style={styles.label}>취미</label>
                    <label>
                        <input
                            type='checkbox'
                            value='등산'
                            onChange={handleCheckboxChange}
                        />
                        등산
                    </label>
                    <label style={{ marginLeft: "10px" }}>
                        <input
                            type='checkbox'
                            value='컴퓨터게임'
                            onChange={handleCheckboxChange}
                        />
                        컴퓨터게임
                    </label>
                    <label style={{ marginLeft: "10px" }}>
                        <input
                            type='checkbox'
                            value='노래부르기'
                            onChange={handleCheckboxChange}
                        />
                        노래부르기
                    </label>
                    <label style={{ marginLeft: "10px" }}>
                        <input
                            type='checkbox'
                            value='당구'
                            onChange={handleCheckboxChange}
                        />
                        당구
                    </label>
                </div>
                <div style={styles.buttonContainer}>
                    <button onClick={handleSubmit} style={styles.button}>제출</button>
                </div>
            </div>
            {submitted && (
                <div style={styles.output}>
                    <h3>사용자 정보</h3>
                    <p>이름: {name}</p>
                    <p>연락처: {contact}</p>
                    <p>Email: {email}</p>
                    <p>성별: {gender}</p>
                    <p>취미: {hobbies.join(", ")}</p>
                </div>
            )}
        </div>
    );
}

export default HabitTest;
