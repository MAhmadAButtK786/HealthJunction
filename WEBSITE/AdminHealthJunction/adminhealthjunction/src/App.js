/* eslint-disable no-unused-vars */
import React, { useState, useEffect } from 'react'; 
import { Switch, Route, Redirect } from 'react-router-dom';
// Importing components
import LoginAdmin from "./components/loginadmin";
import EventCR from './components/events/eventCR';
import EventUploader from './components/events/eventuploaderpage';
import UpdateEventPage from './components/events/update';
import Dashboard from './components/Dashboard/Dashboard';
// Blood Banks
import bloodbank from "./components/bloodbanks/bbHome/bloodbank";
import Donor from "./components/bloodbanks/DonorsList/donor";
import PrivateBB from "./components/bloodbanks/PrivateBB/privateBB";
import PublicBB from "./components/bloodbanks/PublicBB/publicBB";
import Recipients from "./components/bloodbanks/ReciepientList/recipient";
import AddRecipientPage from "./components/bloodbanks/ReciepientList/insertrecipients";
import AddDonorPage from "./components/bloodbanks/DonorsList/insertdonors";
import AddPrivateBB from "./components/bloodbanks/PrivateBB/insertprivateBB";
import AddPublicBB from "./components/bloodbanks/PublicBB/insertpublicBB";
import UpdateDonorPage from './components/bloodbanks/DonorsList/updateDonor';
import UpdateRecipientPage from './components/bloodbanks/ReciepientList/updaterecipient';
import UpdatePrivateBBLPage from './components/bloodbanks/PrivateBB/updateprivatebb';
import UpdatePublicBBLPage from './components/bloodbanks/PublicBB/updatepublicBB';
// Labs
import AlliedLab from "./components/lab/privateLabs/LabsScreens/Allied Lab/alliedLab";
import AlnoorLab from "./components/lab/privateLabs/LabsScreens/AlnoorLab/alnoorLab";
import ChughtaiLab from "./components/lab/privateLabs/LabsScreens/ChughtaiLab/chughtaiLab";
import ExcelLab from "./components/lab/privateLabs/LabsScreens/Excel Lab/excellab";
import IDCLab from "./components/lab/privateLabs/LabsScreens/IDC/idc";
import IndusLab from "./components/lab/privateLabs/LabsScreens/Indus Lab/indusLab";
import LahoreMDC from "./components/lab/privateLabs/LabsScreens/LahoreMDC/LahoreMDC";
import AlliedInsertPage from "./components/lab/privateLabs/LabsScreens/Allied Lab/insertalliedlab";
import AlnoorInsertPage from "./components/lab/privateLabs/LabsScreens/AlnoorLab/insertalnoorLab";
import ChugtaiInsertPage from "./components/lab/privateLabs/LabsScreens/ChughtaiLab/ChugtaiLabinsert";
import ExcelInsertPage from "./components/lab/privateLabs/LabsScreens/Excel Lab/excelinsert";
import IDCInsertPage from "./components/lab/privateLabs/LabsScreens/IDC/idcinsert";
import IndusInsertPage from "./components/lab/privateLabs/LabsScreens/Indus Lab/indusinsert";
import LMLDCInsertPage from "./components/lab/privateLabs/LabsScreens/LahoreMDC/lahoremdcinsert";
import UpdateAlliedLabPage from './components/lab/privateLabs/LabsScreens/Allied Lab/updatealliedlab';
import UpdateAlnoorLabPage from './components/lab/privateLabs/LabsScreens/AlnoorLab/updatealnoor';
import UpdateChughtaiLabPage from './components/lab/privateLabs/LabsScreens/ChughtaiLab/updatechughtailab';
import UpdateExcelLabPage from './components/lab/privateLabs/LabsScreens/Excel Lab/updateexcel';
import UpdateIDCLabPage from './components/lab/privateLabs/LabsScreens/IDC/update idc';
import UpdateIndusLabPage from './components/lab/privateLabs/LabsScreens/Indus Lab/updateindus';
import UpdateLahoreMDCDPage from './components/lab/privateLabs/LabsScreens/LahoreMDC/updateLahoreMDC';
// Charity Links
import Homecharity from "./components/charity/CharityHome/homecharity";
import CharityORG from "./components/charity/Charitable ORG Data/charityORG";
import Partner from "./components/charity/our Partner/partner";
import CharityForm from "./components/charity/Charitable ORG Data/charityinsertForm";
// Import Firebase auth module
import { auth } from './firebase';

// Initialize Firebase

// PrivateRoute Component
const PrivateRoute = ({ component: Component, isAuthenticated, ...rest }) => {
  return (
    <Route
      {...rest}
      render={props =>
        isAuthenticated ? (
          <Component {...props} />
        ) : (
          <Redirect to="/login" />
        )
      }
    />
  );
};

// App Component
const App = () => {
  // State to manage authentication status
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    // Check authentication status on component mount
    auth.onAuthStateChanged(user => {
      if (user) {
        setIsAuthenticated(true);
      } else {
        setIsAuthenticated(false);
      }
    });
  }, []);

  return (
    <>
      {/* Switch to render only one route at a time */}
      <Switch>
        {/* Routes */}
        <Route path="/home" exact component={Dashboard} />
        <Route path="/" exact component={LoginAdmin} />
        {/* Event Update Page */}
        <Route path="/event" exact component={EventCR} />
        <Route path="/eventuploader" exact component={EventUploader} />
        <Route path="/updateEventPage/:id" exact component={UpdateEventPage}/>
        {/* Blood Banks Screens */}
        <Route path="/bloodbank" exact component={bloodbank} />
        <Route path="/donor" exact component={Donor} />
        <Route path="/privateBB" exact component={PrivateBB} />
        <Route path="/publicBB" exact component={PublicBB} />
        <Route path="/recipients" exact component={Recipients} />
        <Route path="/insertsrecipients" exact component={AddRecipientPage}/>
        <Route path="/insertsdonor" exact component={AddDonorPage} />
        <Route path="/insertsPrivateBB" exact component={AddPrivateBB} />
        <Route path="/insertsPublicBB" exact component={AddPublicBB}/>
        <Route path="/updateDonorPage/:id" exact component={UpdateDonorPage}/>
        <Route path="/updateRecipientPage/:id" exact component={UpdateRecipientPage}/>
        <Route path="/updatePrivateBBPage/:id" exact component={UpdatePrivateBBLPage}/>
        <Route path="/updatePublicBBPage/:id" exact component={UpdatePublicBBLPage}/>
        {/* Lab Screens */}
       
        <Route path="/alliedlab" exact component={AlliedLab} />
        <Route path="/alnoorlab" exact component={AlnoorLab} />
        <Route path="/chughtailab" exact component={ChughtaiLab}/>
        <Route path="/excellab" exact component={ExcelLab}/>
        <Route path="/idclab" exact component={IDCLab}/>
        <Route path="/induslab" exact component={IndusLab}/>
        <Route path="/lahoremdc" exact component={LahoreMDC}/>
        <Route path="/alliedinsertpage" exact component={AlliedInsertPage}/>
        <Route path="/alnoorinsertpage" exact component={AlnoorInsertPage}/>
        <Route path="/excelinsertpage" exact component={ExcelInsertPage}/>
        <Route path="/chugtaiinsertpage" exact component={ChugtaiInsertPage}/>
        <Route path="/idcinsertpage" exact component={IDCInsertPage}/>
        <Route path="/indusinsertpage" exact component={IndusInsertPage}/>
        <Route path="/lmldcinsertpage" exact component={LMLDCInsertPage}/>
        <Route path="/updateAlliedPage/:id" exact component={UpdateAlliedLabPage}/>
        <Route path="/updateAlnoorPage/:id" exact component={UpdateAlnoorLabPage}/>
        <Route path="/updateChughtaiPage/:id" exact component={UpdateChughtaiLabPage}/>
        <Route path="/updateExcelPage/:id" exact component={UpdateExcelLabPage}/>
        <Route path="/updateIDCPage/:id" exact component={UpdateIDCLabPage}/>
        <Route path="/updateIndusPage/:id" exact component={UpdateIndusLabPage}/>
        <Route path="/updateLMDCPage/:id" exact component={UpdateLahoreMDCDPage}/>
        {/* Charity Screens */}
        <Route path="/homecharity" exact component={Homecharity} />
        <Route path="/partner" exact component={Partner} />
        <Route path="/charityORG" exact component={CharityORG} />
        <Route path="/charityinsert" exact component={CharityForm}/>
      </Switch>
    </>
  );
}

export default App;
