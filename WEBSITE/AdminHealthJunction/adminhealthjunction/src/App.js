import React, { useState, useEffect } from 'react'; 
import { Switch, Route, Redirect } from 'react-router-dom';
// Importing components
import Home from "./components/Admin Home/home";
import Contact from "./components/aboutUs/contact";
import LoginAdmin from "./components/loginadmin";
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
// Labs
import LabsHome from "./components/lab/LabHome/LabHome";
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
        <PrivateRoute path="/home" exact component={Home} isAuthenticated={isAuthenticated}/>
        <PrivateRoute path="/contact" exact component={Contact} isAuthenticated={isAuthenticated}/>
        <Route path="/" exact component={LoginAdmin} />
        
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
        {/* Lab Screens */}
        <Route path="/labhome" exact component={LabsHome} />
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
