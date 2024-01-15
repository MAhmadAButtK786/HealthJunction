import React from 'react';


import {Switch,Route} from 'react-router-dom'
import Contact from './Component/contact';
import Home from './Component/home';

import Login from './Component/login';
import Register from './Component/register';
function App() {
  return (
      
        <Switch>
          <Route path="/" exact component={Home} />
         
          <Route path="/contact" component={Contact} />
          <Route path="/login" component={Login}/>
          <Route path="/register" component={Register}/>
        </Switch>
     
    
  );
}

export default App;
