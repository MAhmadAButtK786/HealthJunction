import React from 'react';
import {Switch,Route} from 'react-router-dom'
import Home from './components/Admin Home/home';
import Contact from './components/aboutUs/contact';
import LoginAdmin from './components/loginadmin';
function App() {
  return (
   <>
   <Switch>
   <Route path="/home" exact component={Home} />
   <Route path="/contact" exact component={Contact} />
   <Route path="/" exact component={LoginAdmin} />
   </Switch>
   </>
  );
}

export default App;
