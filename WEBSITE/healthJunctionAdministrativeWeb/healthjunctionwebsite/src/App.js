import React from 'react';


import {Switch,Route} from 'react-router-dom'
import Contact from './Component/aboutUs/contact';
import Home from './Component/homepage/home';
import Accordion from './Component/bloodbanks/FAQ/faq';
import Login from './Component/login';
import Register from './Component/register';
import bloodbank from './Component/bloodbanks/bbHome/bloodbank';
import Homecharity from './Component/charity/CharityHome/homecharity';
import LabsHome from './Component/lab/LabHome/LabHome';
import HealthPointHome from './Component/healthPoints/healthPointsHome/healthPointHome';
import Guidlines from './Component/healthPoints/our Guidlines/guidlines';
import Partner from './Component/charity/our Partner/partner';
import ForgetPassword from './Component/forgetPassword';
function App() {
  return (
      
        <Switch>
          <Route path="/home" exact component={Home} />
          <Route path ="/healthPointHome" exact component={HealthPointHome}/>
          <Route path ="/guidlines" exact component={Guidlines}/>
          <Route path="/bloodbank" exact component ={bloodbank}/>
          <Route path="/faq" exact component={Accordion}/>
          <Route path="/homecharity" exact component={Homecharity}/>
          <Route path="/partner" exact component={Partner}/>
          <Route path="/LabHome" exact component={LabsHome}/>
          <Route path="/contact" exact component={Contact} />
          <Route path="/" exact component={Login}/>
          <Route path="/register" exact component={Register}/>
          <Route path="/forgetPassword" exact component={ForgetPassword}/>
        </Switch>
     
    
  );
}

export default App;
