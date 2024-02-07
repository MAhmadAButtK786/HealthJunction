import React from 'react';
import {Switch,Route} from 'react-router-dom'
import AdminHome from "./components/Admin Home/adminHome";
import Contact from './components/aboutUs/contact';
import LoginPage from './adminLogin';
function App() {
  return (
   <>
   <Switch>
   <Route path="/home" exact component={AdminHome} />
   <Route path="/contact" exact component={Contact} />
   <Route path="/" exact component={LoginPage} />
   </Switch>
   </>
  );
}

export default App;
