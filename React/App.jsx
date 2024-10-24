import React from "react";
import Menu from "./Menu";

function App(props){
    return(
        <div>
            <Menu name="아메리카노" price={3000} />
            <Menu name="카페라떼" price={3500} />
        </div>
    )
}

export default App;