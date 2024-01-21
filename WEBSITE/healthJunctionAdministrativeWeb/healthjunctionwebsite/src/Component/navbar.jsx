import React, { useState } from 'react';
import { Link } from 'react-router-dom';

const Navbar = () => {
  const [showServicesDropdown, setShowServicesDropdown] = useState(false);

  const toggleServicesDropdown = () => {
    setShowServicesDropdown(!showServicesDropdown);
  };

  return (
    <header className="text-gray-100 bg-gray-900 body-font shadow w-full">
      <div className="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center">
        <nav className="flex lg:w-2/5 flex-wrap items-center text-base md:ml-auto">
          <Link to="/" className="mr-7 hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600">
            Health Points
          </Link>
          <div className="relative">
            <span
              className="mr-7 hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600"
              onClick={toggleServicesDropdown}
            >
              Services
            </span>
            {showServicesDropdown && (
            <div className="absolute top-full left-0 mt-2 bg-gray-900 text-gray-100 p-2 rounded-md z-10">
              <Link to="/bloodbank" className="block py-1 hover:text-blue-300">BloodBank</Link>
              <Link to="/homecharity" className="block py-1 hover:text-blue-300">Charity</Link>
              <Link to="/laboratories" className="block py-1 hover:text-blue-300">Laboratories</Link>
            </div>
          )}
           
          </div>
          <Link to="/contact" className="hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600">
            About Us
          </Link>
        </nav>
        <Link to="/" className="flex order-first lg:order-none lg:w-1/5 title-font font-medium items-center lg:items-center lg:justify-center mb-4 md:mb-0">
          <img
            src="images/hjlogo.png"
            style={{ height: 50, marginTop: 10, marginBottom: 10, borderRadius: '50%', backgroundColor: 'blue' }}
            alt="logo"
          />
          <span className="ml-3 text-xl">Health Junction</span>
        </Link>
        <div className="lg:w-2/5 inline-flex lg:justify-end ml-5 lg:ml-0 mt-4 lg:mt-0">
          <Link to="/login" className="bg-indigo-700 hover:bg-indigo-500 text-white ml-4 py-2 px-3 rounded-lg lg:ml-0 lg:mr-4">
            Login
          </Link>
          <Link to="/register" className="bg-indigo-700 hover:bg-indigo-500 text-white ml-4 py-2 px-3 rounded-lg lg:ml-0">
            Register
          </Link>
        </div>
      </div>
    </header>
  );
}

export default Navbar;
