import React, { useState } from 'react';

const Navbar = () => {
  const [showDropdown1, setShowDropdown1] = useState(false);
  const [showDropdown2, setShowDropdown2] = useState(false);

  const toggleDropdown1 = () => {
    setShowDropdown1(!showDropdown1);
  };

  const toggleDropdown2 = () => {
    setShowDropdown2(!showDropdown2);
  };

  return (
    <header className="text-gray-600 body-font bg-red-500">
      <div className="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center">
        <nav className="flex lg:w-2/5 flex-wrap items-center text-base md:ml-auto">
          <a href="#" className="mr-5 text-white hover:text-white">Home</a>
          <div className="relative inline-block">
            <button onClick={toggleDropdown1} className="mr-5 bg-white hover:bg-gray-200 text-red-500 py-2 px-4 rounded inline-flex items-center">
             Lists
              <svg xmlns="http://www.w3.org/2000/svg" className="w-6 h-6 ml-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </button>
            {showDropdown1 && (
              <div className="absolute mt-1 right-0 w-40 bg-white rounded-lg shadow-md z-10">
                <a href="#" className="block px-4 py-2 text-gray-800 hover:bg-gray-200">Donor List</a>
                <a href="#" className="block px-4 py-2 text-gray-800 hover:bg-gray-200">Recipient List</a>
                <a href="#" className="block px-4 py-2 text-gray-800 hover:bg-gray-200">Our Team</a>
              </div>
            )}
          </div>
          <div className="relative inline-block">
            <button onClick={toggleDropdown2} className="bg-white hover:bg-gray-200 text-red-500 py-2 px-4 rounded inline-flex items-center">
              Insert
              <svg xmlns="http://www.w3.org/2000/svg" className="w-6 h-6 ml-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </button>
            {showDropdown2 && (
              <div className="absolute mt-1 right-0 w-40 bg-white rounded-lg shadow-md z-10">
                <a href="/donorReg" className="block px-4 py-2 text-gray-800 hover:bg-gray-200">Insert Donor</a>
                <a href="/recipientReg" className="block px-4 py-2 text-gray-800 hover:bg-gray-200">Insert Recipient</a>
              </div>
            )}
          </div>
        </nav>
        <a href="#" className="flex order-first lg:order-none lg:w-1/5 title-font font-medium items-center text-white lg:items-center lg:justify-center mb-4 md:mb-0">
          <span className="ml-3 text-2xl">Blood Donor Society</span>
        </a>
        <div className="lg:w-2/5 inline-flex lg:justify-end ml-5 lg:ml-0">
          <button className="inline-flex items-center bg-white border-0 py-1 px-3 focus:outline-none hover:bg-gray-200 rounded text-base mt-4 md:mt-0 text-red-500">Button
            <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" className="w-4 h-4 ml-1" viewBox="0 0 24 24">
              <path d="M5 12h14M12 5l7 7-7 7"></path>
            </svg>
          </button>
        </div>
      </div>
    </header>
  );
}

export default Navbar;
