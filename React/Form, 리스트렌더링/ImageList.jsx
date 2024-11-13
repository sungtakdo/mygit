import React from 'react';
import './ImageList.css'; // 추가된 CSS 파일 import

function ImageList() {
  return (
    <div className="image-list">
      <img src='./images/1.jpg' alt='image1' />
      <img src='./images/2.png' alt='image2' />
      <img src='./images/3.jpg' alt='image3' />
      <img src='./images/4.jpg' alt='image4' />
    </div>
  );
}

export default ImageList;
