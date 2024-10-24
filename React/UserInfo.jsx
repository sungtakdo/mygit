import React, { useState } from 'react';

function UserInfo() {
    const [name, setName] = useState('');
    const [phone, setPhone] = useState('');
    const [email, setEmail] = useState('');
    const [gender, setGender] = useState('남성');
    const [hobbies, setHobbies] = useState([]);
    const [submitted, setSubmitted] = useState(false);

    const handleSubmit = (e) => {
        e.preventDefault();
        setSubmitted(true);
    };

    const handleHobbyChange = (hobby) => {
        if (hobbies.includes(hobby)) {
            setHobbies(hobbies.filter(h => h !== hobby));
        } else {
            setHobbies([...hobbies, hobby]);
        }
    };

    return (
        <div style={styles.container}>
            <h2>사용자 정보 입력</h2>
            <form onSubmit={handleSubmit} style={styles.form}>
                <div>
                    <label>이름</label>
                    <input 
                        type="text" 
                        value={name} 
                        onChange={(e) => setName(e.target.value)} 
                        style={styles.input}
                    />
                </div>
                <div>
                    <label>연락처</label>
                    <input 
                        type="text" 
                        value={phone} 
                        onChange={(e) => setPhone(e.target.value)} 
                        style={styles.input}
                    />
                </div>
                <div>
                    <label>email</label>
                    <input 
                        type="email" 
                        value={email} 
                        onChange={(e) => setEmail(e.target.value)} 
                        style={styles.input}
                    />
                </div>
                <div>
                    <label>성별</label>
                    <label>
                        <input 
                            type="radio" 
                            value="남성" 
                            checked={gender === '남성'}
                            onChange={(e) => setGender(e.target.value)}
                        />
                        남성
                    </label>
                    <label>
                        <input 
                            type="radio" 
                            value="여성" 
                            checked={gender === '여성'}
                            onChange={(e) => setGender(e.target.value)}
                        />
                        여성
                    </label>
                </div>
                <div>
                    <label>취미</label>
                    <label>
                        <input 
                            type="checkbox" 
                            value="등산" 
                            checked={hobbies.includes('등산')}
                            onChange={() => handleHobbyChange('등산')}
                        />
                        등산
                    </label>
                    <label>
                        <input 
                            type="checkbox" 
                            value="컴퓨터게임" 
                            checked={hobbies.includes('컴퓨터게임')}
                            onChange={() => handleHobbyChange('컴퓨터게임')}
                        />
                        컴퓨터게임
                    </label>
                    <label>
                        <input 
                            type="checkbox" 
                            value="노래부르기" 
                            checked={hobbies.includes('노래부르기')}
                            onChange={() => handleHobbyChange('노래부르기')}
                        />
                        노래부르기
                    </label>
                    <label>
                        <input 
                            type="checkbox" 
                            value="당구" 
                            checked={hobbies.includes('당구')}
                            onChange={() => handleHobbyChange('당구')}
                        />
                        당구
                    </label>
                </div>
                <button type="submit" style={styles.button}>제출</button>
            </form>

            {submitted && (
                <div style={styles.output}>
                    <h3><strong>사용자 정보</strong></h3>
                    <p><strong>이름: </strong>{name}</p>
                    <p><strong>연락처: </strong>{phone}</p>
                    <p><strong>Email: </strong>{email}</p>
                    <p><strong>성별: </strong>{gender}</p>
                    <p><strong>취미: </strong>{hobbies.join(', ')}</p>
                </div>
            )}
        </div>
    );
}

export default UserInfo;

const styles = {
    container: {
        padding: '20px',
        maxWidth: '600px',
        margin: '0 auto',
        backgroundColor: '#f9f9f9',
        borderRadius: '8px',
        boxShadow: '0 0 10px rgba(0, 0, 0, 0.1)'
    },
    form: {
        display: 'flex',
        flexDirection: 'column',
    },
    input: {
        padding: '8px',
        marginBottom: '10px',
        borderRadius: '4px',
        border: '1px solid #ccc',
        width: '100%',
    },
    button: {
        padding: '10px',
        backgroundColor: '#4CAF50',
        color: 'white',
        border: 'none',
        borderRadius: '4px',
        cursor: 'pointer',
        marginTop: '10px',
    },
    output: {
        marginTop: '20px',
        padding: '10px',
        backgroundColor: '#e6f7ff',
        borderRadius: '4px',
    },
};
