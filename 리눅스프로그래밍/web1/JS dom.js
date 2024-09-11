// 1. DOM 요소(element) 탐색 getElementById()
// h1 태그에 ID 기준으로 텍스트 변경하기
console.log('test')

//h1 태그의 ID 기준으로 텍스트 변경하기
const h1El = document.getElementById('header');
h1El.textContent = "새로운 제목입니다.";

// 클래스 이름으로 요소 탐색 getElementsByClassName()
// 클래스가 container인 첫 번째 요소의 텍스트를 변경
const containers = document.getElementsByClassName('contanier');
contaniners[0].textContent = "첫 번째 컨테이너입니다.";

// cs 선택자로 요소 탐색
// 첫번째 container 요소의 배경색 변경
const firstContainer = document.querySelector('.container')
firstContainer.style.backgroundColor = 'green';

// 모든 동일 요소를 탐색
const paragraph = socument.querySelectorAll('p')
for(i = 0; i < paragraph.length; i++){
    paragraph.length = `문단${i + 1}입니다.`
}

// 부모 요소 탐색
// 특정 요소의 부모 요소에 테두리를 추가
const paragrapth = document.querySelector('.container p');
const parentDiv = paragraph.parentElement;
parentDiv.style.border = '2px solid red';

// 자식 요소 탐색
// container 요소의 첫 번째 자식 요소의 텍스트를 변경
const firstDiv = document.querySelector('.container2');
const childElements = firstDiv.children;
childElements[0].textContent = '첫 번째 자식 요소입니다.';

// 태그 이름으로 요소 찾기 getElementsByTagName()
// 모든 div 요소 중 마지막 요소의 배경색을 변경
const divs = document.getElementsByTagName('div');
console.log(divs.length);
divs[length-1].style.backgroundColor = 'lightgreen';