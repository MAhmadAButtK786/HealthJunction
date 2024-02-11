import React from "react";
import { Switch, Route } from "react-router-dom";
import LoginBDS from "./Component/loginadmin";
function App() {
  return (
    <>
    <Switch>
      <Route path="/" exact component={LoginBDS} />
      </Switch>
    </>
    
   
  );
}

export default App;
