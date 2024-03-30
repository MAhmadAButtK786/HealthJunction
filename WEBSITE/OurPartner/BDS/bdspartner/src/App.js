import React from "react";
import { Switch, Route } from "react-router-dom";
import LoginBDS from "./Component/loginadmin";
import BDSHome from "./Component/Home/bdshome";
import AddDonorPage from "./Component/Registration copy/RegisterDonor";
import AddRecipientPage from "./Component/Registration copy/RegisterRecipient";
import Donor from "./Component/DonorsList/donor";
import Recipients from "./Component/ReciepientList/recipient";
import EventUploader from "./Component/events/eventuploaderpage";
import EventCR from "./Component/events/eventCR";
import UpdateEventPage from "./Component/events/update";
import UpdateDonorPage from "./Component/DonorsList/updateDonor";
import UpdateRecipientPage from "./Component/ReciepientList/recipientupdate";
import WelcomeS from "./Component/dashboard/welcomescren";
import TeamManagement from "./Component/teamManagement/teammanagement";
import AddTeamMemberPage from "./Component/teamManagement/teaminsert";
import UpdateTeamMemberPage from "./Component/teamManagement/teamupdate";
function App() {
  return (
    <>
    <Switch>
      <Route path="/" exact component={LoginBDS} />
      <Route path="/home" exact component={BDSHome} />

      <Route path="/welcome" exact component={WelcomeS} />
      <Route path="/donorReg" exact component={AddDonorPage} />
      <Route path="/recipientReg" exact component={AddRecipientPage} />
      <Route path="/donorlistORG" exact component={Donor} />
      <Route path="/recipientlistORG" exact component={Recipients} />
      <Route path="/updaterecipientPage/:id" exact component={UpdateRecipientPage} />
      <Route path="/eventuploader" exact component={EventUploader} />
      <Route path="/eventupdatedelete" exact component={EventCR} />
      <Route path="/updateEventPage/:id" component={UpdateEventPage} />
      <Route path="/updateDonorPage/:id" component={UpdateDonorPage} />
      <Route path="/insertteammember" exact component={AddTeamMemberPage} />
      <Route path="/teammanagement" exact component={TeamManagement} />
      <Route path="/updateteammemberpage/:id" component={UpdateTeamMemberPage} />
      </Switch>
    </>
    
   
  );
}

export default App;
