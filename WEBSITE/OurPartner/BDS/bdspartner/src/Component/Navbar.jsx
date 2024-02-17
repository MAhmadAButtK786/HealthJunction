import React, { useState } from "react";
import { Transition } from "@headlessui/react";

const Navbar = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [isDropdown1Open, setIsDropdown1Open] = useState(false);
  const [isDropdown2Open, setIsDropdown2Open] = useState(false);

  return (
    <nav className="bg-blue-600">
      <div className="px-2 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div className="relative flex items-center justify-between h-16">
          <div className="absolute inset-y-0 left-0 flex items-center sm:hidden">
            <button
              type="button"
              className="inline-flex items-center justify-center p-2 text-gray-400 rounded-md hover:text-white hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
              aria-controls="mobile-menu"
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
                  strokeWidth={2}
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
                  strokeWidth={2}
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
          {/* Navbar items */}
          <div className="flex items-center justify-center flex-1 sm:items-stretch sm:justify-start">
            {/* Home link */}
            <a href="#" className="flex items-center flex-shrink-0 text-white">
              <h1>
                <i class="fa fa-dashboard" aria-hidden="true">
                  {" "}
                  Dashboard
                </i>
              </h1>
            </a>

            <div className="hidden sm:block sm:ml-6">
              <div className="flex space-x-4">
                {/* Dropdown 1 */}
                <div className="relative">
                  <button
                    className="px-3 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                    onClick={() => setIsDropdown1Open(!isDropdown1Open)}
                  >
                    <i class="fa fa-building" aria-hidden="true">
                      {" "}
                      Organization Data
                    </i>
                  </button>
                  <Transition
                    show={isDropdown1Open}
                    enter="transition ease-out duration-100 transform"
                    enterFrom="opacity-0 scale-95"
                    enterTo="opacity-100 scale-100"
                    leave="transition ease-in duration-75 transform"
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
                          <a
                            href="#"
                            className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                          >
                            Team Data
                          </a>
                        </div>
                      </div>
                    )}
                  </Transition>
                </div>
                {/* Dropdown 2 */}
                <div className="relative">
                  <button
                    className="px-3 py-2 text-sm font-medium text-white rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                    onClick={() => setIsDropdown2Open(!isDropdown2Open)}
                  >
                    <i class="fa fa-database" aria-hidden="true">
                      {" "}
                      Add Data
                    </i>
                  </button>
                  <Transition
                    show={isDropdown2Open}
                    enter="transition ease-out duration-100 transform"
                    enterFrom="opacity-0 scale-95"
                    enterTo="opacity-100 scale-100"
                    leave="transition ease-in duration-75 transform"
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
              </div>
            </div>
            <a
              href="/eventuploader"
              className="block px-3 py-2 text-base font-medium text-white rounded-md hover:bg-gray-700 hover:text-white"
            >
              <i class="fa fa-info" aria-hidden="true">
                {" "}
                Upload Event
              </i>
            </a>
            <a
              href="/eventupdatedelete"
              className="block px-3 py-2 text-base font-medium text-white rounded-md hover:bg-gray-700 hover:text-white"
            >
              <i class="fa fa-info" aria-hidden="true">
                {" "}
                Events 
              </i>
            </a>
          </div>
        </div>
      </div>

      {/* Mobile menu, toggle classes based on menu state */}
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
            className={`${isOpen ? "block" : "hidden"} sm:hidden`}
            id="mobile-menu"
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
                  enter="transition ease-out duration-100 transform"
                  enterFrom="opacity-0 scale-95"
                  enterTo="opacity-100 scale-100"
                  leave="transition ease-in duration-75 transform"
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
                        <a
                          href="#"
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
                  className="w-full px-3 py-2 text-sm font-medium text-left text-gray-300 rounded-md hover:bg-gray-700 hover:text-white focus:outline-none"
                  onClick={() => setIsDropdown2Open(!isDropdown2Open)}
                >
                  Insert Data
                </button>
                <Transition
                  show={isDropdown2Open}
                  enter="transition ease-out duration-100 transform"
                  enterFrom="opacity-0 scale-95"
                  enterTo="opacity-100 scale-100"
                  leave="transition ease-in duration-75 transform"
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
                          href="#"
                          className="block px-4 py-2 text-sm text-gray-300 hover:bg-gray-800 hover:text-white"
                        >
                          Add Donor
                        </a>
                        <a
                          href="#"
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
                href="#"
                className="block px-3 py-2 text-base font-medium text-gray-300 rounded-md hover:bg-gray-700 hover:text-white"
              >
                Home
              </a>
              <a
                href="#"
                className="block px-3 py-2 text-base font-medium text-gray-300 rounded-md hover:bg-gray-700 hover:text-white"
              >
                About
              </a>
              <a
                href="#"
                className="block px-3 py-2 text-base font-medium text-gray-300 rounded-md hover:bg-gray-700 hover:text-white"
              >
                Contact
              </a>
            </div>
          </div>
        )}
      </Transition>
    </nav>
  );
};

export default Navbar;
