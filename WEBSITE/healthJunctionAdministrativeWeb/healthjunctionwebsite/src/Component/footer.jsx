import React from "react";
import { Link } from "react-router-dom";
const Footer = () => {
  return (
    <>
      <footer className="font-sans bg-blue-100/80 dark:bg-gray-900">
        <div className="container px-4 py-4 mx-auto sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-y-4 md:grid-cols-3 lg:grid-cols-4">
            <div className="sm:col-span-2 md:col-span-1 lg:col-span-2">
              <h1 className="text-lg font-semibold tracking-tight text-gray-800 dark:text-white">
                Our Vision
              </h1>
              <div className="col-span-1 mt-2 space-y-4 text-gray-600 dark:text-gray-300">
                <p className="leading-relaxed">
                  We envision a world where healthcare is a fundamental right
                  accessible to everyone. Our mission is to ensure that every
                  individual receives the highest quality healthcare services,
                  promoting well-being and fostering a healthier society.
                </p>
                
               
              </div>
            </div>

            <div className="md:col-span-1 lg:col-span-1">
              <p className="font-semibold text-gray-800 dark:text-white">
                Quick Links
              </p>
              <div className="flex flex-col items-start mt-2 space-y-2">
                <Link to= "/home">
                <p className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500">
                  Home
                </p>
                </Link>
                <Link to="/contact">
                <p className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500">
                  Who We Are
                </p>
                </Link>
                <Link to="/contact">
                <p className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500">
                  Our Philosophy
                </p>
                </Link>
              </div>
            </div>
            <div className="md:col-span-1 lg:col-span-1">
              <p className="font-semibold text-gray-800 dark:text-white">
                Services
              </p>
              <div className="flex flex-col items-start mt-2 space-y-2">
                <Link
                  to="/healthPointHome"
                  className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500"
                >
                  Hospitals & Clinics
                </Link>
                <Link
                to="/bloodbank"
                  className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500"
                >
                  Blood Banks
                </Link>
                <Link
                to="/homecharity"
                  className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500"
                >
                  Charity 
                </Link>
                <Link
                to="/Labhome"
                  className="text-gray-600 hover:underline hover:cursor-pointer hover:text-blue-500"
                >
                   Lab Information
                </Link>
              </div>
            </div>
          </div>
          <hr className="h-1 my-4 border-gray-200 dark:border-gray-700" />
          <div className="flex flex-col items-center justify-between md:flex-row">
            <div className="flex gap-2">
              <a href="https://www.google.com">
                <img
                  src="https://www.svgrepo.com/show/303139/google-play-badge-logo.svg"
                  width={120}
                  height={95}
                  alt=""
                />
              </a>
              <a href="https://www.apple.com/app-store/">
                <img
                  src="https://www.svgrepo.com/show/303128/download-on-the-app-store-apple-logo.svg"
                  width={120}
                  height={95}
                  alt=""
                />
              </a>
            </div>
            <div className="flex gap-2">
              <a href="https://www.facebook.com">
                <img
                  src="https://www.svgrepo.com/show/303114/facebook-3-logo.svg"
                  width={30}
                  height={30}
                  alt="fb"
                />
              </a>
              <a href="https://www.twitter.com">
                <img
                  src="https://www.svgrepo.com/show/303115/twitter-3-logo.svg"
                  width={30}
                  height={30}
                  alt="tw"
                />
              </a>
              <a href="https://www.instagram.com">
                <img
                  src="https://www.svgrepo.com/show/303145/instagram-2-1-logo.svg"
                  width={30}
                  height={30}
                  alt="inst"
                />
              </a>
              {/* Additional social media icons */}
              <a href="https://www.github.com">
                <img
                  src="https://www.svgrepo.com/show/94698/github.svg"
                  width={30}
                  height={30}
                  alt="gt"
                />
              </a>
              <a href="https://www.linkedin.com">
                <img
                  src="https://www.svgrepo.com/show/28145/linkedin.svg"
                  width={30}
                  height={30}
                  alt="in"
                />
              </a>
              <a href="https://www.dribbble.com">
                <img
                  src="https://www.svgrepo.com/show/22048/dribbble.svg"
                  width={30}
                  height={30}
                  alt="db"
                />
              </a>
            </div>
          </div>
          <p className="mt-4 font-sans text-sm text-center text-gray-600 dark:text-white">
            © 2024 Your Company Inc. All rights reserved.
          </p>
        </div>
      </footer>
    </>
  );
};

export default Footer;
