document.addEventListener("DOMContentLoaded", function(){
    //1. <p> 요소 생성
    var pEle = document.createElement("p");
    //2. <p> 요소에 텍스트 내용 추가
    pEle.textContent = "Hello, React!!!";
    //3. id가 "pop"인 div 요소 가져오기
    var divId = document.getElementById("pop")
    //4. div 요소에  p 요소를 붙이기
    divId.appendChild(pEle);
    
    // <h1><p>Welcome, React World!!!</p></h1>
    //1. 새로운 요소 생성
    var pEle = document.createElement("p");
    //2. 생성 요소에 텍스트 추가
    pEle.textContent = "Welcome, React World!!!";
    //3. 상위 요소 가져오기
    var divId = document.getElementById("hpop");
    //4. 상위 요소에 하위 요소 붙이기
    divId.appendChild(pEle);

})