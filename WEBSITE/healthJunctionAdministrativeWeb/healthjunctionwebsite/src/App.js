import React from 'react';


import {Switch,Route} from 'react-router-dom'
import Contact from './Component/aboutUs/contact';
import Home from './Component/homepage/home';
import Accordion from './Component/bloodbanks/FAQ/faq';
import Login from './Component/login';
import Register from './Component/register';
import bloodbank from './Component/bloodbanks/bbHome/bloodbank';
import Homecharity from './Component/charity/CharityHome/homecharity';
function App() {
  return (
      
        <Switch>
          <Route path="/" exact component={Home} />
          <Route path="/bloodbank" component ={bloodbank}/>
          <Route path="/faq" component={Accordion}/>
          <Route path="/homecharity" component={Homecharity}/>
          <Route path="/contact" component={Contact} />
          <Route path="/login" component={Login}/>
          <Route path="/register" component={Register}/>
        </Switch>
     
    
  );
}

export default App;
