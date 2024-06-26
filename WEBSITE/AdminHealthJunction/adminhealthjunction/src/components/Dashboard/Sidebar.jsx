import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faChevronDown, faAppleAlt ,faChevronRight, faFlask, faClinicMedical, faUserInjured, faHandsHelping, faCalendar, faDashboard, faHospital, faUserDoctor, faHandHoldingHeart, faCheck, faCheckDouble, faHospitalSymbol } from '@fortawesome/free-solid-svg-icons';
import { Link } from 'react-router-dom';

const Sidebar = () => {
  // State to manage dropdown visibility
  const [dropdowns, setDropdowns] = useState({
    bloodBank: false,
    labManagement: false
  });

  // Function to toggle dropdown visibility
  const toggleDropdown = (id) => {
    setDropdowns(prevState => ({
      ...prevState,
      [id]: !prevState[id]
    }));
  };

  return (
    <aside className="w-64 min-h-screen p-4 text-white bg-gray-800 ">
      <nav >
        <ul className="space-y-2 "> {/* Reduced space-y to decrease gap */}
          {/* Agenda without dropdown */}
          <li>
            <Link to="#" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faDashboard} className="mr-2" />
                <span>Dashboard</span>
              </div>
            </Link>
          </li>
          {/* Hospials */}
          <li>
            <Link to="/hospitalcrud" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faHospital} className="mr-2" />
                <span>Hospital Mangement</span>
              </div>
            </Link>
          </li>
          <li>
            <Link to="/verifiedHospitalsmanagement" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faCheck} className="mr-2" />
                <span>Verified Hospitals</span>
              </div>
            </Link>
          </li>
           {/* Clinics */}
           <li>
            <Link to="/doctorsmanagement" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faUserDoctor} className="mr-2" />
                <span>Doctors Mangement</span>
              </div>
            </Link>
          </li>
          <li>
            <Link to="/verifieddoctorsmanagement" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faCheckDouble} className="mr-2" />
                <span>Verified Doctors</span>
              </div>
            </Link>
          </li>
           
          <li>
            <Link to="/punjabhealthcommissionhospital" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faHospitalSymbol} className="mr-2" />
                <span>PHC Hospitals</span>
              </div>
            </Link>
          </li>
          
          {/* Events without dropdown */}
          <li>
            <Link to="/event" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faCalendar} className="mr-2" />
                <span>Events</span>
              </div>
            </Link>
          </li>
           {/* NGOs */}
           <li>
            <Link to="/charityORG" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faHandHoldingHeart} className="mr-2" />
                <span>Manage Charitable Organizations</span>
              </div>
            </Link>
          </li>
          {/* Donor without dropdown */}
          <li>
            <Link to="/donor" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faHandsHelping} className="mr-2" />
                <span>Donor</span>
              </div>
            </Link>
          </li>
          {/* Recipient without dropdown */}
          <li>
            <Link to="/recipients" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faUserInjured} className="mr-2" />
                <span>Recipient</span>
              </div>
            </Link>
          </li>
          {/* Blood Bank Management with dropdown */}
          <li className="opcion-con-desplegable">
            <div className="flex items-center justify-between p-2 hover:bg-gray-700" onClick={() => toggleDropdown('bloodBank')}>
              <div className="flex items-center">
                <FontAwesomeIcon icon={faClinicMedical} className="mr-2" />
                <span>Blood Bank Management</span>
              </div>
              <FontAwesomeIcon icon={dropdowns.bloodBank ? faChevronDown : faChevronRight} className="text-xs" />
            </div>
            {/* Dropdown content */}
            <ul className={`desplegable ml-4 ${dropdowns.bloodBank ? '' : 'hidden'}`}>
            <li>
                <Link to="/privateBB" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Private BB
                </Link>
              </li>
              <li>
                <Link to="/publicBB" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Public BB
                </Link>
              </li>
            </ul>
          </li>
          {/* Lab Management with dropdown */}
          <li className="opcion-con-desplegable">
            <div className="flex items-center justify-between p-2 hover:bg-gray-700" onClick={() => toggleDropdown('labManagement')}>
              <div className="flex items-center">
                <FontAwesomeIcon icon={faFlask} className="mr-2" />
                <span>Lab Management</span>
              </div>
              <FontAwesomeIcon icon={dropdowns.labManagement ? faChevronDown : faChevronRight} className="text-xs" />
            </div>
            {/* Dropdown content */}
            <ul className={`desplegable ml-4 ${dropdowns.labManagement ? '' : 'hidden'}`}>
            <li>
                <Link to="/alliedlab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Allied 
                </Link>
              </li>
              <li>
                <Link to="/chughtailab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Chughtai 
                </Link>
              </li>
              <li>
                <Link to="/alnoorlab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Alnoor
                </Link>
              </li>
              <li>
                <Link to="/excellab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Excel
                </Link>
              </li>
              <li>
                <Link to="/idclab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  IDC
                </Link>
              </li>
              <li>
                <Link to="/healthzonelab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Health Zone
                </Link>
              </li>
              <li>
                <Link to="/lahoremdc" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  LMDC
                </Link>
              </li>
              <li>
                <Link to="/induslab" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                  Indus 
                </Link>
              </li>
              <li>
                <Link to="/PHCLabs" className="items-center block p-2 hover:bg-gray-700">
                  <FontAwesomeIcon icon={faChevronRight} className="mr-2 text-xs" />
                 PHC Labs
                </Link>
              </li>
            </ul>
          </li>
          <li>
            <Link to="/nutrifit" className="flex items-center justify-between p-2 hover:bg-gray-700">
              <div className="flex items-center">
                <FontAwesomeIcon icon={faAppleAlt} className="mr-2" />
                <span>NutriFit</span>
              </div>
            </Link>
          </li>
        </ul>
      </nav>
    </aside>
  );
};

export default Sidebar;
