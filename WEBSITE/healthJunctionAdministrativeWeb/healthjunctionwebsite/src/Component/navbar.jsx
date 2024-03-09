import React, { useState } from 'react';
import { Link } from 'react-router-dom';

const Navbar = () => {
  const [showServicesDropdown, setShowServicesDropdown] = useState(false);
  const [showUserMenu, setShowUserMenu] = useState(false);

  const toggleServicesDropdown = () => {
    setShowServicesDropdown(!showServicesDropdown);
  };

  const toggleUserMenu = () => {
    setShowUserMenu(!showUserMenu);
  };

  return (
    <header className="w-full text-gray-100 bg-gray-900 shadow body-font">
      <div className="container flex flex-col flex-wrap items-center p-5 mx-auto md:flex-row">
        <nav className="flex flex-wrap items-center text-base lg:w-2/5 md:ml-auto">
          <Link to="/healthPointHome" className="border-b border-transparent cursor-pointer mr-7 hover:text-blue-300 hover:border-indigo-600">
            Health Points
          </Link>
          <div className="relative">
            <span
              className="border-b border-transparent cursor-pointer mr-7 hover:text-blue-300 hover:border-indigo-600"
              onClick={toggleServicesDropdown}
            >
              Services
            </span>
            {showServicesDropdown && (
              <div className="absolute left-0 z-10 p-2 mt-2 text-gray-100 bg-gray-900 rounded-md top-full">
                <Link to="/bloodbank" className="block py-1 hover:text-blue-300">BloodBank</Link>
                <Link to="/homecharity" className="block py-1 hover:text-blue-300">Charity</Link>
                <Link to="/LabHome" className="block py-1 hover:text-blue-300">Laboratories</Link>
                <Link to="/eventpage" className="block py-1 hover:text-blue-300">Events</Link>
              </div>
            )}
          </div>
         
          <Link to="/contact" className="border-b border-transparent cursor-pointer hover:text-blue-300 hover:border-indigo-600">
            About Us
          </Link>
        </nav>
        <Link to="/" className="flex items-center order-first mb-4 font-medium lg:order-none lg:w-1/5 title-font lg:items-center lg:justify-center md:mb-0">
          <img
            src="images/hjlogo.png"
            style={{ height: 50, marginTop: 10, marginBottom: 10, borderRadius: '50%', backgroundColor: 'blue' }}
            alt="logo"
          />
          <span className="ml-3 text-xl">Health Junction</span>
        </Link>
        <div className="inline-flex mt-4 ml-5 lg:w-2/5 lg:justify-end lg:ml-0 lg:mt-0">
          {/* Updated User menu design with a different icon */}
          <div className="relative">
            <button
              className="px-3 py-2 text-white bg-indigo-700 rounded-lg hover:bg-indigo-500 focus:outline-none"
              onClick={toggleUserMenu}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                className="w-5 h-5"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M13 15v-3m0 0v-3m0 3h3m-3 0h-3m-3 3h3m0 0h3m0-3v3m0 0v3m0-3h-3m3 0z"
                />
              </svg>
            </button>
            {showUserMenu && (
              <div className="absolute right-0 mt-2 text-gray-100 bg-gray-900 rounded-md">
                <Link to="/profile" className="block px-4 py-2 hover:text-blue-300">Profile</Link>
                <Link to="/settings" className="block px-4 py-2 hover:text-blue-300">Settings</Link>
                <Link to="/logout" className="block px-4 py-2 hover:text-blue-300">Logout</Link>
              </div>
            )}
          </div>
        </div>
      </div>
    </header>
  );
}

export default Navbar;
