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
import BasicdF from './Component/healthPoints/healthpRegistration/Basic Form Data/basicdF';
import HPRegistrationForm from './Component/healthPoints/healthpRegistration/CheckBox Part/hfcheckbox';
import PrivateBB from './Component/bloodbanks/PrivateBB/privateBB';
import PublicBB from './Component/bloodbanks/PublicBB/publicBB';
import Recipients from './Component/bloodbanks/ReciepientList/recipient';
import Donor from './Component/bloodbanks/DonorsList/donor';
import CharityORG from './Component/charity/Charitable ORG Data/charityORG';
import AlliedLab from './Component/lab/privateLabs/LabsScreens/Allied Lab/alliedLab';
import ChughtaiLab from './Component/lab/privateLabs/LabsScreens/ChughtaiLab/chughtaiLab';
import ExcelLab from './Component/lab/privateLabs/LabsScreens/Excel Lab/excellab';
import IDCLab from './Component/lab/privateLabs/LabsScreens/IDC/idc';
import IndusLab from './Component/lab/privateLabs/LabsScreens/Indus Lab/indusLab';
import LahoreMDC from './Component/lab/privateLabs/LabsScreens/LahoreMDC/LahoreMDC';
import AlnoorLab from './Component/lab/privateLabs/LabsScreens/AlnoorLab/alnoorLab';
import AddDonorPage from './Component/bloodbanks/Registration/RegisterDonor';
import AddRecipientPage from './Component/bloodbanks/Registration/RegisterRecipient';
import Excelsheet from './Component/healthPoints/healthpRegistration/ExcelSheetPart/excelsheet';
import Eventmain from './Component/events/eventmain';
import HealthZone from './Component/lab/privateLabs/LabsScreens/HealthZone/healthzone';
function App() {
  return (
      
        <Switch>
          <Route path="/home" exact component={Home} />
          <Route path ="/eventpage" exact component={Eventmain}/>
          {/* Health Points */}
          <Route path ="/healthPointHome" exact component={HealthPointHome}/>
          <Route path ="/basicdF" exact component={BasicdF}/>
          <Route path="/hfcheckbox" exact component ={HPRegistrationForm}/>
          <Route path ="/hospitalformexcelsheet" exact component={Excelsheet}/>
          <Route path ="/guidlines" exact component={Guidlines}/>
    
              {/* Blood Banks Modules Screens */}
          {/* Blood Banks Home*/}
          <Route path="/bloodbank" exact component ={bloodbank}/>
          {/* Blood Banks FAQ */}
          <Route path="/faq" exact component={Accordion}/>
          {/* Private Blood Banks */}
          <Route path="/privateBB" exact component={PrivateBB}/>
          {/* Public Blood */}
          <Route path="/publicBB" exact component={PublicBB}/>
          {/* Recipient List */}
          <Route path="/recipient" exact component={Recipients}/>
          {/* Donors Lists */}
          <Route path="/donors" exact component={Donor}/>
          {/* Register Donoe */}
          <Route path="/donorsRegistration" exact component={AddDonorPage}/>
          {/* Register Recipient */}
          <Route path="/recipientsRegistration" exact component={AddRecipientPage}/>

                {/* Charity Module Screens  */}
          {/* Charity Home */}
          <Route path="/homecharity" exact component={Homecharity}/>
          {/* Partner Screen */}
          <Route path="/partner" exact component={Partner}/>
          {/* Charitable org Information */}
          <Route path="/charityORG" exact component={CharityORG}/>


                {/* Lab Module Screens */}
          {/* Lab Home Screen */}
          <Route path="/LabHome" exact component={LabsHome}/>
          {/* Labs Data */}
          {/* Allied Lab */}
          <Route path="/AlliedLab" exact component={AlliedLab}/>
            {/* Alnoor Lab */}
            <Route path="/AlnoorLab" exact component={AlnoorLab}/>
          {/* ChughtaiLab */}
          <Route path="/ChugtaiLab" exact component={ChughtaiLab}/> 
          {/* ExcelLab */}
          <Route path="/ExcelLab" exact component={ExcelLab}/>
          {/* IDC  */}
          <Route path="/IDCLab" exact component={IDCLab}/>
          {/* Indus Lab */}
          <Route path="/IndusLab" exact component={IndusLab}/>
          {/* LMDC */}
          <Route path="/LahoreMDC" exact component={LahoreMDC}/>
          {/* Health Zone */}
          <Route path="/HealthZone" exact component={HealthZone}/>
          <Route path="/contact" exact component={Contact} />
          <Route path="/" exact component={Login}/>
          <Route path="/register" exact component={Register}/>
          <Route path="/forgetPassword" exact component={ForgetPassword}/>
        </Switch>
     
    
  );
}

export default App;
