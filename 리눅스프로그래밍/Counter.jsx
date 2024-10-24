import React, { useState } from "react";  // useState 추가

function CounterFunction() {
    const [count, setCount] = useState(0);

    return (
        <div>
            <h2>함수 컴포넌트</h2>
            <p>현재 카운트: {count}</p>
            <button onClick={
                () => setCount(count + 1)
            }>카운트 증가</button>
        </div>
    );
}

export default CounterFunction;
