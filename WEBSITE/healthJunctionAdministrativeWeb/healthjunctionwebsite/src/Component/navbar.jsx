import React from 'react';

const Navbar = () => {
  return (
    <header className="text-gray-100 bg-gray-900 body-font shadow w-full">
      <div className="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center">
        <nav className="flex lg:w-2/5 flex-wrap items-center text-base md:ml-auto">
          <a className="mr-5 hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600">
            About
          </a>
          <a className="mr-5 hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600">
            Products
          </a>
          <a className="mr-5 hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600">
            Investor Relations
          </a>
          <a className="hover:text-blue-300 cursor-pointer border-b border-transparent hover:border-indigo-600">
            Contact
          </a>
        </nav>
        <a className="flex order-first lg:order-none lg:w-1/5 title-font font-medium items-center lg:items-center lg:justify-center mb-4 md:mb-0">
          <img
            src="images/hjlogo.png"
            style={{ height: 50, marginTop: 10, marginBottom: 10, borderRadius: '50%', backgroundColor: 'blue' }}
            alt="logo"
          />
          <span className="ml-3 text-xl">Health Junction</span>
        </a>
        <div className="lg:w-2/5 inline-flex lg:justify-end ml-5 lg:ml-0">
          <a
            href=""
            className="bg-indigo-700 hover:bg-indigo-500 text-white ml-4 py-2 px-3 rounded-lg"
          >
           Login
          </a>
        
       
          <a
            href=""
            className="bg-indigo-700 hover:bg-indigo-500 text-white ml-4 py-2 px-3 rounded-lg"
          >
            Register
          </a>
        </div>
      </div>
    </header>
  );
}

export default Navbar;
