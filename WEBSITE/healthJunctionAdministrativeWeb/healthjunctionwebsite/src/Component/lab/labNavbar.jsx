/* eslint-disable jsx-a11y/anchor-is-valid */
import React, { useState } from "react";

const LabNavbar = () => {
  const [open, setOpen] = useState(false);

  return (
    <div className="relative z-10 w-full text-white bg-gray-700 dark-mode:text-gray-200 dark-mode:bg-gray-800">
      <div className="flex flex-col max-w-screen-xl px-4 mx-auto md:items-center md:justify-between md:flex-row md:px-6 lg:px-8">
        <div className="flex flex-row items-center justify-between p-4">
          <div className="flex items-center">
            <img
              src="images/hjlogo.png"
              alt="Logo"
              className="h-8 mr-2 rounded-full"
            />
            <a
              href="/home"
              className="text-lg font-semibold tracking-widest uppercase focus:outline-none focus:shadow-outline"
            >
              Health Junction
            </a>
          </div>
          <button
            className="rounded-lg md:hidden focus:outline-none focus:shadow-outline"
            onClick={() => setOpen(!open)}
          >
            <svg fill="currentColor" viewBox="0 0 20 20" className="w-6 h-6">
              <path
                fillRule="evenodd"
                d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM9 15a1 1 0 011-1h6a1 1 0 110 2h-6a1 1 0 01-1-1z"
                clipRule="evenodd"
              ></path>
            </svg>
          </button>
        </div>
        <nav
          className={`flex-col flex-grow pb-4 md:pb-0 md:flex md:justify-end md:flex-row ${
            open ? "flex" : "hidden"
          }`}
        >
          <a
            className="px-4 py-2 mt-2 text-sm font-semibold bg-gray-600 rounded-lg md:mt-0 focus:text-gray-900 focus:outline-none focus:shadow-outline"
            href="/LabHome"
          >
            Laboratory Home
          </a>
          <button
            onClick={() => setOpen(!open)}
            className="flex flex-row items-center w-full px-4 py-2 mt-2 text-sm font-semibold text-left bg-transparent rounded-lg md:w-auto md:inline md:mt-0 md:ml-4 hover:text-gray-900 focus:text-gray-900 hover:bg-gray-200 focus:bg-gray-200 focus:outline-none focus:shadow-outline"
          >
            <span>Private Labs</span>
            <svg
              fill="currentColor"
              viewBox="0 0 20 20"
              className={`inline w-4 h-4 mt-1 ml-1 transition-transform duration-200 transform ${
                open ? "rotate-180" : "rotate-0"
              }`}
            >
              <path
                fillRule="evenodd"
                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                clipRule="evenodd"
              ></path>
            </svg>
          </button>
          <a
            className="px-4 py-2 mt-2 text-sm font-semibold bg-transparent rounded-lg md:mt-0 md:ml-4 hover:text-black focus:text-white focus:bg-gray-200 focus:outline-none focus:shadow-outline"
            href=""
          >
            Govt Registered Labs
          </a>
          <a
            className="px-4 py-2 mt-2 text-sm font-semibold bg-transparent rounded-lg md:mt-0 md:ml-4 hover:text-gray-900 focus:text-gray-900 hover:bg-gray-200 focus:bg-gray-200 focus:outline-none focus:shadow-outline"
            href="/contact"
          >
            Contact Us
          </a>
          <div onClick={() => setOpen(false)} className="relative">
            <div
              className={`absolute right-0 w-full mt-2 origin-top-right rounded-md shadow-lg md:w-48 ${
                open ? "block" : "hidden"
              }`}
            >
              <div className="px-2 py-2 bg-gray-500 rounded-md shadow">
                <a
                  className="block px-4 py-2 mt-2 text-sm font-semibold bg-transparent rounded-lg hover:text-blue-600 focus:text-white hover:bg-gray-200 focus:bg-gray-200 focus:outline-none focus:shadow-outline"
                  href="/AlliedLab"
                >
                  Allied Labs
                </a>
                <a
                  className="block px-4 py-2 mt-2 text-sm font-semibold bg-transparent rounded-lg hover:text-blue-600 focus:text-white hover:bg-gray-200 focus:bg-gray-200 focus:outline-none focus:shadow-outline"
                  href=""
                >
                  Link #1
                </a>
                <a
                  className="block px-4 py-2 mt-2 text-sm font-semibold bg-transparent rounded-lg hover:text-blue-600 focus:text-white hover:bg-gray-200 focus:bg-gray-200 focus:outline-none focus:shadow-outline"
                  href=""
                >
                  Link #1
                </a>
              </div>
            </div>
          </div>
        </nav>
      </div>
    </div>
  );
};

export default LabNavbar;
