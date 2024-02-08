import React from 'react';
import {Switch,Route} from 'react-router-dom'
import Home from './components/Admin Home/home';
import Contact from './components/aboutUs/contact';
import LoginAdmin from './components/loginadmin';
// Blood Banks import
import bloodbank from './components/bloodbanks/bbHome/bloodbank';
import Donor from './components/bloodbanks/DonorsList/donor';
import PrivateBB from './components/bloodbanks/PrivateBB/privateBB';
import PublicBB from './components/bloodbanks/PublicBB/publicBB';
import Recipients from './components/bloodbanks/ReciepientList/recipient';
import AddRecipientPage from './components/bloodbanks/ReciepientList/insertrecipients';
function App() {
  return (
   <>
   <Switch>
   <Route path="/home" exact component={Home} />
   <Route path="/contact" exact component={Contact} />
   <Route path="/" exact component={LoginAdmin} />
   {/* Blood Banks Screens */}
   <Route path="/bloodbank" exact component={bloodbank} />
   <Route path="/donor" exact component={Donor} />
   <Route path="/privateBB" exact component={PrivateBB} />
   <Route path="/publicBB" exact component={PublicBB} />
   <Route path="/recipients" exact component={Recipients} />
   <Route path="/insertsrecipients" exact component={AddRecipientPage} />
   </Switch>
   </>
  );
}

export default App;
