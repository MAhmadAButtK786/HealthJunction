/* eslint-disable jsx-a11y/anchor-is-valid */
import React, { useState } from "react";
import { Transition } from "@headlessui/react";


const Navbar = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isDropdown1Open, setIsDropdown1Open] = useState(false);
  const [isDropdown2Open, setIsDropdown2Open] = useState(false);

  return (
    <nav className="bg-gradient-to-r from-blue-500 to-purple-500">
      <div className="px-4 py-6 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div className="flex items-center justify-between">
          <div className="flex items-center">
            <a href="/" className="text-2xl font-bold text-white">
              <i className="fa fa-dashboard" aria-hidden="true"></i> Dashboard
            </a>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden space-x-4 md:flex">
            <div className="relative">
              <button
                className="px-3 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                onClick={() => setIsDropdown1Open(!isDropdown1Open)}
              >
                <i className="fa fa-building" aria-hidden="true"></i> Organization Data
              </button>
              <Transition
                show={isDropdown1Open}
                enter="transition ease-out duration-200 transform"
                enterFrom="opacity-0 scale-95"
                enterTo="opacity-100 scale-100"
                leave="transition ease-in duration-150 transform"
                leaveFrom="opacity-100 scale-100"
                leaveTo="opacity-0 scale-95"
              >
                {(ref) => (
                  <div
                    ref={ref}
                    className="absolute right-0 w-56 mt-2 origin-top-right bg-gray-700 divide-y divide-gray-200 rounded-md shadow-lg ring-1 ring-black ring-opacity-5"
                  >
                    <div className="py-1">
                      <a
                        href="/donorlistORG"
                        className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                      >
                        Donor Data
                      </a>
                      <a
                        href="/recipientlistORG"
                        className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                      >
                        Recipient Data
                      </a>
                      <a  href="/teammanagement"
                        className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                      >
                        Team Data
                      </a>
                    </div>
                  </div>
                )}
              </Transition>
            </div>
            <div className="relative">
              <button
                className="px-3 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                onClick={() => setIsDropdown2Open(!isDropdown2Open)}
              >
                <i className="fa fa-database" aria-hidden="true"></i> Add Data
              </button>
              <Transition
                show={isDropdown2Open}
                enter="transition ease-out duration-200 transform"
                enterFrom="opacity-0 scale-95"
                enterTo="opacity-100 scale-100"
                leave="transition ease-in duration-150 transform"
                leaveFrom="opacity-100 scale-100"
                leaveTo="opacity-0 scale-95"
              >
                {(ref) => (
                  <div
                    ref={ref}
                    className="absolute right-0 w-56 mt-2 origin-top-right bg-gray-700 divide-y divide-gray-200 rounded-md shadow-lg ring-1 ring-black ring-opacity-5"
                  >
                    <div className="py-1">
                      <a
                        href="/recipientReg"
                        className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                      >
                        Insert Recipient
                      </a>
                      <a
                        href="/donorReg"
                        className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                      >
                        Insert Donor
                      </a>
                    </div>
                  </div>
                )}
              </Transition>
            </div>
            <a
              href="/eventuploader"
              className="px-3 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
            >
              <i className="fa fa-info" aria-hidden="true"></i> Upload Event
            </a>
            <a
              href="/eventupdatedelete"
              className="px-3 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
            >
              <i className="fa fa-info" aria-hidden="true"></i> Events
            </a>
          </div>

          {/* Mobile Navigation */}
          <div className="flex items-center md:hidden">
            <button
              className="p-2 text-white rounded-md hover:text-white hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
              aria-expanded="false"
              onClick={() => setIsOpen(!isOpen)}
            >
              <span className="sr-only">Open main menu</span>
              <svg
                className={`${isOpen ? "hidden" : "block"} h-6 w-6`}
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                aria-hidden="true"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M4 6h16M4 12h16m-7 6h7"
                />
              </svg>
              <svg
                className={`${isOpen ? "block" : "hidden"} h-6 w-6`}
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                aria-hidden="true"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu, show/hide based on menu state */}
      <Transition
        show={isOpen}
        enter="duration-200 ease-out"
        enterFrom="opacity-0 scale-95"
        enterTo="opacity-100 scale-100"
        leave="duration-100 ease-in"
        leaveFrom="opacity-100 scale-100"
        leaveTo="opacity-0 scale-95"
      >
        {(ref) => (
          <div
            className={`${isOpen ? "block" : "hidden"} md:hidden`}
            ref={ref}
          >
            <div className="px-2 pt-2 pb-3 space-y-1">
              <div className="relative">
                <button
                  className="w-full px-3 py-2 text-sm font-medium text-left text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                  onClick={() => setIsDropdown1Open(!isDropdown1Open)}
                >
                  Organization Data
                </button>
                <Transition
                  show={isDropdown1Open}
                  enter="transition ease-out duration-200 transform"
                  enterFrom="opacity-0 scale-95"
                  enterTo="opacity-100 scale-100"
                  leave="transition ease-in duration-150 transform"
                  leaveFrom="opacity-100 scale-100"
                  leaveTo="opacity-0 scale-95"
                >
                  {(ref) => (
                    <div
                      ref={ref}
                      className="absolute right-0 w-full mt-2 origin-top-right bg-gray-700 divide-y divide-gray-200 rounded-md shadow-lg ring-1 ring-black ring-opacity-5"
                    >
                      <div className="py-1">
                        <a
                          href="/donorlistORG"
                          className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                        >
                          Donor Data
                        </a>
                        <a
                          href="/recipientlistORG"
                          className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                        >
                          Recipient Data
                        </a>
                        <a href="/insertteammember"
                          className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                        >
                          Team Data
                        </a>
                      </div>
                    </div>
                  )}
                </Transition>
              </div>
              <div className="relative">
                <button
                  className="w-full px-3 py-2 text-sm font-medium text-left text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                  onClick={() => setIsDropdown2Open(!isDropdown2Open)}
                >
                  Insert Data
                </button>
                <Transition
                  show={isDropdown2Open}
                  enter="transition ease-out duration-200 transform"
                  enterFrom="opacity-0 scale-95"
                  enterTo="opacity-100 scale-100"
                  leave="transition ease-in duration-150 transform"
                  leaveFrom="opacity-100 scale-100"
                  leaveTo="opacity-0 scale-95"
                >
                  {(ref) => (
                    <div
                      ref={ref}
                      className="absolute right-0 w-full mt-2 origin-top-right bg-gray-700 divide-y divide-gray-200 rounded-md shadow-lg ring-1 ring-black ring-opacity-5"
                    >
                      <div className="py-1">
                        <a
                          href="/donorlistORG"
                          className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                        >
                          Add Donor
                        </a>
                        <a
                          href="/recipientlistORG"
                          className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                        >
                          Add Recipient
                        </a>
                      </div>
                    </div>
                  )}
                </Transition>
              </div>
              <a
                href="/insertteammember"
                className="block px-3 py-2 text-base font-medium text-white rounded-md hover:bg-gray-700 hover:text-white"
              >
                Team
              </a>
              <a
                href="/eventupdatedelete"
                className="block px-3 py-2 text-base font-medium text-white rounded-md hover:bg-gray-700 hover:text-white"
              >
                Event
              </a>
            </div>
          </div>
        )}
      </Transition>
    </nav>
  );
};

export default Navbar;
