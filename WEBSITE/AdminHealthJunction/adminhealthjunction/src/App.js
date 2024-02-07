import React from 'react';
import {Switch,Route} from 'react-router-dom'
import AdminHome from "./components/Admin Home/adminHome";
import Contact from './aboutUs/contact';
function App() {
  return (
   <>
   <Switch>
   <Route path="/" exact component={AdminHome} />
   <Route path="/contact" exact component={Contact} />
   </Switch>
   </>
  );
}

export default App;
