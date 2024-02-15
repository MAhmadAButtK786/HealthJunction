import React from "react";
import { Switch, Route } from "react-router-dom";
import LoginBDS from "./Component/loginadmin";
import BDSHome from "./Component/Home/bdshome";
import AddDonorPage from "./Component/Registration copy/RegisterDonor";
import AddRecipientPage from "./Component/Registration copy/RegisterRecipient";
import Donor from "./Component/DonorsList/donor";
import Recipients from "./Component/ReciepientList/recipient";
import UpdateRecipient from "./Component/ReciepientList/updaterecipient";
function App() {
  return (
    <>
    <Switch>
      <Route path="/" exact component={LoginBDS} />
      <Route path="/home" exact component={BDSHome} />
      <Route path="/donorReg" exact component={AddDonorPage} />
      <Route path="/recipientReg" exact component={AddRecipientPage} />
      <Route path="/donorlistORG" exact component={Donor} />
      <Route path="/recipientlistORG" exact component={Recipients} />
      <Route path="/updaterecipient" component={UpdateRecipient} />
      </Switch>
    </>
    
   
  );
}

export default App;
