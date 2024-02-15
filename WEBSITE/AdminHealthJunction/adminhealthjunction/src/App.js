import React, { useState } from 'react';
import { Switch, Route } from "react-router-dom";
import Home from "./components/Admin Home/home";
import Contact from "./components/aboutUs/contact";
import LoginAdmin from "./components/loginadmin";
// Blood Banks import
import bloodbank from "./components/bloodbanks/bbHome/bloodbank";
import Donor from "./components/bloodbanks/DonorsList/donor";
import PrivateBB from "./components/bloodbanks/PrivateBB/privateBB";
import PublicBB from "./components/bloodbanks/PublicBB/publicBB";
import Recipients from "./components/bloodbanks/ReciepientList/recipient";
import AddRecipientPage from "./components/bloodbanks/ReciepientList/insertrecipients";
import AddDonorPage from "./components/bloodbanks/DonorsList/insertdonors";
import AddPrivateBB from "./components/bloodbanks/PrivateBB/insertprivateBB";
import AddPublicBB from "./components/bloodbanks/PublicBB/insertpublicBB";
// Lab Imports
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
import PrivateRoute from "./components/PrivateRoute";
  function App() {
    const [isAuthenticated, setIsAuthenticated] = useState(false); // Define isAuthenticated state
  return (
    <>
      <Switch>
        <PrivateRoute path="/home" exact component={Home} isAuthenticated={isAuthenticated} />
        <PrivateRoute  path="/contact" exact component={Contact} isAuthenticated={isAuthenticated}/>
        <Route path="/" exact component={LoginAdmin}  />
        {/* Blood Banks Screens */}
        <PrivateRoute  path="/bloodbank" exact component={bloodbank} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/donor" exact component={Donor} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/privateBB" exact component={PrivateBB} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/publicBB" exact component={PublicBB} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/recipients" exact component={Recipients} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/insertsrecipients" exact component={AddRecipientPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/insertsdonor" exact component={AddDonorPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/insertsPrivateBB" exact component={AddPrivateBB} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/insertsPublicBB" exact component={AddPublicBB} isAuthenticated={isAuthenticated} />
        {/* Lab Screens */}
        <PrivateRoute  path="/labhome" exact component={LabsHome} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/alliedlab" exact component={AlliedLab} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/alnoorlab" exact component={AlnoorLab} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/chughtailab" exact component={ChughtaiLab} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/excellab" exact component={ExcelLab} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/idclab" exact component={IDCLab} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/induslab" exact component={IndusLab} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/lahoremdc" exact component={LahoreMDC} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/alliedinsertpage" exact component={AlliedInsertPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/alnoorinsertpage" exact component={AlnoorInsertPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/excelinsertpage" exact component={ExcelInsertPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/chugtaiinsertpage" exact component={ChugtaiInsertPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/idcinsertpage" exact component={IDCInsertPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/indusinsertpage" exact component={IndusInsertPage} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/lmldcinsertpage" exact component={LMLDCInsertPage} isAuthenticated={isAuthenticated}/>
        {/* Charity Screens */}
        <PrivateRoute  path="/homecharity" exact component={Homecharity} isAuthenticated={isAuthenticated} />
        <PrivateRoute  path="/partner" exact component={Partner} isAuthenticated={isAuthenticated}/>
        <PrivateRoute  path="/charityORG" exact component={CharityORG} isAuthenticated={isAuthenticated}/>
        <PrivateRoute path="/charityinsert" exact component={CharityForm} isAuthenticated={isAuthenticated}/>
      </Switch>
    </>
  );
}

export default App;
