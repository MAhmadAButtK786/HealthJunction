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
// Lab Imports
import LabsHome from './components/lab/LabHome/LabHome';
import AlliedLab from './components/lab/privateLabs/LabsScreens/Allied Lab/alliedLab';
import AlnoorLab from './components/lab/privateLabs/LabsScreens/AlnoorLab/alnoorLab';
import ChughtaiLab from './components/lab/privateLabs/LabsScreens/ChughtaiLab/chughtaiLab';
import ExcelLab from './components/lab/privateLabs/LabsScreens/Excel Lab/excellab';
import IDCLab from './components/lab/privateLabs/LabsScreens/IDC/idc';
import IndusLab from './components/lab/privateLabs/LabsScreens/Indus Lab/indusLab';
import LahoreMDC from './components/lab/privateLabs/LabsScreens/LahoreMDC/LahoreMDC';
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
   {/* Lab Screens */}
   <Route path="/labhome" exact component={LabsHome} />
   <Route path="/alliedlab" exact component={AlliedLab} />
   <Route path="/alnoorlab" exact component={AlnoorLab} />
   <Route path="/chughtailab" exact component={ChughtaiLab} />
   <Route path="/excellab" exact component={ExcelLab} />
   <Route path="/idclab" exact component={IDCLab} />
   <Route path="/induslab" exact component={IndusLab} />
   <Route path="/lahoremdc" exact component={LahoreMDC} />
   </Switch>
   </>
  );
}

export default App;
