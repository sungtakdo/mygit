import React from "react";

function Menu(props) {
    return (
        <div style={{
            border: "1px solid gray",
            borderRadius: "15px", 
            textAlign:"center",
            margin:"10px"
        }}>
            <h1>{props.name}</h1>
            <h4>{props.price}원</h4>
        </div>
    );
}

export default Menu;
