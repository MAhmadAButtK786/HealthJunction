import React, { useState } from 'react';
import { Link, useHistory } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSignOutAlt, faBars, faTimes, faFlask, faTint, faHandsHelping, faHospital } from '@fortawesome/free-solid-svg-icons';
import { auth } from '../firebase'; // Import your Firebase authentication instance

const Navbar = () => {
  const [showMenu, setShowMenu] = useState(false);
  const [showHealthPointsMenu, setShowHealthPointsMenu] = useState(false);
  const [showBloodMenu, setShowBloodMenu] = useState(false);
  const [showLabMenu, setShowLabMenu] = useState(false);
  const [showCharitableMenu, setShowCharitableMenu] = useState(false);
  const history = useHistory();

  const toggleMenu = () => {
    setShowMenu(!showMenu);
    setShowHealthPointsMenu(false);
    setShowBloodMenu(false);
    setShowLabMenu(false);
    setShowCharitableMenu(false);
  };

  const toggleHealthPointsMenu = () => {
    setShowHealthPointsMenu(!showHealthPointsMenu);
    setShowBloodMenu(false);
    setShowLabMenu(false);
    setShowCharitableMenu(false);
  };

  const toggleBloodMenu = () => {
    setShowBloodMenu(!showBloodMenu);
    setShowHealthPointsMenu(false);
    setShowLabMenu(false);
    setShowCharitableMenu(false);
  };

  const toggleLabMenu = () => {
    setShowLabMenu(!showLabMenu);
    setShowHealthPointsMenu(false);
    setShowBloodMenu(false);
    setShowCharitableMenu(false);
  };

  const toggleCharitableMenu = () => {
    setShowCharitableMenu(!showCharitableMenu);
    setShowHealthPointsMenu(false);
    setShowBloodMenu(false);
    setShowLabMenu(false);
  };

  const handleLogout = async () => {
    try {
      // Sign out the user from Firebase
      await auth.signOut();
      console.log('User logged out');
      
      // Redirect to the login page after logout
      history.push('/');
    } catch (error) {
      console.error('Error logging out:', error.message);
    }
  };

  return (
    <header className="text-white bg-gray-800">
      <div className="container flex items-center justify-between py-4 mx-auto">
        <div className="flex items-center text-2xl font-semibold">
          <img
            src="images/hjlogo.png"
            className="w-12 h-12 mr-2 rounded-full"
            alt="logo"
          />
          HJ Admin
        </div>
        <button
          className="p-2 text-white lg:hidden focus:outline-none"
          onClick={toggleMenu}
          aria-label={showMenu ? "Close Menu" : "Open Menu"}
        >
          <FontAwesomeIcon icon={showMenu ? faTimes : faBars} />
        </button>
        <nav className={`lg:flex flex-grow items-center justify-between mt-4 lg:mt-0 ${showMenu ? '' : 'hidden'}`}>
          <div className="flex flex-col lg:flex-row lg:ml-auto">
            <div className="relative">
              <span
                className="py-4 mx-4 border-b border-transparent cursor-pointer hover:text-blue-300 hover:border-indigo-600 lg:py-0"
                onClick={toggleHealthPointsMenu}
              >
                <FontAwesomeIcon icon={faHospital} className="mr-2" /> HealthPoints 
              </span>
              {showHealthPointsMenu && (
                <div className="absolute left-0 z-10 p-2 mt-2 text-gray-100 bg-gray-900 rounded-md shadow-lg">
                  <Link to="/hospitalcrud" className="block py-2 hover:text-blue-300">Hospitals Management</Link>
                  <Link to="/doctorsmanagement" className="block py-2 hover:text-blue-300">Doctors Management</Link>
                  <Link to="/verifieddoctorsmanagement" className="block py-2 hover:text-blue-300">Verified Doctors</Link>
                  <Link to="/verifiedHospitalsmanagement" className="block py-2 hover:text-blue-300">Verified Hospitals</Link>
                  
                </div>
              )}
            </div>
            <div className="relative">
              <span
                className="py-4 mx-4 border-b border-transparent cursor-pointer hover:text-blue-300 hover:border-indigo-600 lg:py-0"
                onClick={toggleBloodMenu}
              >
                <FontAwesomeIcon icon={faTint} className="mr-2" /> Blood Management
              </span>
              {showBloodMenu && (
                <div className="absolute left-0 z-10 p-2 mt-2 text-gray-100 bg-gray-900 rounded-md shadow-lg">
                  <Link to="/privatebb" className="block py-2 hover:text-blue-300">Private Blood Banks</Link>
                  <Link to="/publicbb" className="block py-2 hover:text-blue-300">Public Blood Banks</Link>
                  <Link to="/recipients" className="block py-2 hover:text-blue-300">Recipients</Link>
                  <Link to="/donor" className="block py-2 hover:text-blue-300">Donors</Link>
                </div>
              )}
            </div>
            <div className="relative">
              <span
                className="py-4 mx-4 border-b border-transparent cursor-pointer hover:text-blue-300 hover:border-indigo-600 lg:py-0"
                onClick={toggleLabMenu}
              >
                <FontAwesomeIcon icon={faFlask} className="mr-2" /> Labs Management
              </span>
              {showLabMenu && (
                <div className="absolute left-0 z-10 p-2 mt-2 text-gray-100 bg-gray-900 rounded-md shadow-lg">
                  <Link to="/alliedlab" className="block py-2 hover:text-blue-300">Allied Lab</Link>
                  <Link to="/alnoorlab" className="block py-2 hover:text-blue-300">Alnoor Diagnostic Center</Link>
                  <Link to="/induslab" className="block py-2 hover:text-blue-300">Indus Lab</Link>
                  <Link to="/idclab" className="block py-2 hover:text-blue-300">IDC</Link>
                  <Link to="/lahoremdc" className="block py-2 hover:text-blue-300">LMDC</Link>
                  <Link to="/healthzonelab" className="block py-2 hover:text-blue-300">Health Zone</Link>
                  <Link to="/excellab" className="block py-2 hover:text-blue-300">Excel Lab</Link>
                  <Link to="/chughtailab" className="block py-2 hover:text-blue-300">Chughtai Lab</Link>
                  <Link to="/PHCLabs" className="block py-2 hover:text-blue-300">PHC Labs</Link>
                </div>
              )}
            </div>
            <div className="relative">
              <span
                className="py-4 mx-4 border-b border-transparent cursor-pointer hover:text-blue-300 hover:border-indigo-600 lg:py-0"
                onClick={toggleCharitableMenu}
              >
                <FontAwesomeIcon icon={faHandsHelping} className="mr-2" /> Beneficiary Programs
              </span>
              {showCharitableMenu && (
                <div className="absolute left-0 z-10 p-2 mt-2 text-gray-100 bg-gray-900 rounded-md shadow-lg">
                  <Link to="/charityORG" className="block py-2 hover:text-blue-300">NGOs Management</Link>
                  <Link to="/event" className="block py-2 hover:text-blue-300">Events Management</Link>
                  <Link to="/nutrifit" className="block py-2 hover:text-blue-300">NutriFit Management</Link>
                  <Link to="/medicine" className="block py-2 hover:text-blue-300">Medicine Management</Link>
                </div>
              )}
            </div>
          </div>
          <div>
            <button onClick={handleLogout} className="flex items-center py-4 mx-4 border-b border-transparent cursor-pointer hover:text-blue-300 hover:border-indigo-600 lg:py-0">
              <FontAwesomeIcon icon={faSignOutAlt} className="mr-2" />
              Logout
            </button>
          </div>
        </nav>
      </div>
    </header>
  );
}

export default Navbar;
