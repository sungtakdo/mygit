import React, { useState } from 'react';
import './TextLab.css'; // 스타일링을 위한 CSS 파일 추가

function TextLab() {
    const [name, setName] = useState('');
    const [gender, setGender] = useState('');
    const [age, setAge] = useState('');
    const [favoriteFruit, setFavoriteFruit] = useState('');
    const [submittedData, setSubmittedData] = useState(null);

    const handleSubmit = (e) => {
        alert(`이름: ${name}\n성별: ${gender}\n나이: ${age}\n좋아하는 과일: ${favoriteFruit}`);
        e.preventDefault();
        setSubmittedData({ name, gender, age, favoriteFruit });
    };

    return (
        <div className="container">
            <h3>사용자 정보 입력</h3>
            <form onSubmit={handleSubmit} className="form">
                <div className="form-group">
                    <label>이름:</label>
                    <input 
                        type="text" 
                        value={name} 
                        onChange={(e) => setName(e.target.value)} 
                        placeholder="이름을 입력하세요"
                    />
                </div>
                <div className="form-group">
                    <label>성별:</label>
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
                <div className="form-group">
                    <label>나이:</label>
                    <input 
                        type="number" 
                        value={age} 
                        onChange={(e) => setAge(e.target.value)} 
                        placeholder="나이를 입력하세요"
                    />
                </div>
                <div className="form-group">
                    <label>좋아하는 과일:</label>
                    <select 
                        value={favoriteFruit} 
                        onChange={(e) => setFavoriteFruit(e.target.value)}
                    >
                        <option value="">선택하세요</option>
                        <option value="사과">사과</option>
                        <option value="바나나">바나나</option>
                        <option value="포도">포도</option>
                        <option value="체리">체리</option>
                        <option value="망고">망고</option>
                    </select>
                </div>
                <button type="submit" className="submit-btn">제출</button>
            </form>

            {submittedData && (
                <div className="result">
                    <h4>입력한 사용자 정보</h4>
                    <p>이름: {submittedData.name}</p>
                    <p>성별: {submittedData.gender}</p>
                    <p>나이: {submittedData.age}</p>
                    <p>좋아하는 과일: {submittedData.favoriteFruit}</p>
                </div>
            )}
        </div>
    );
}

export default TextLab;
