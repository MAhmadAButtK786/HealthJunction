import React from 'react';
import {Link} from "react-router-dom"
const ContentSection = () => {
  return (
    <section className="text-gray-600 body-font">
      <div className="container px-5 py-24 mx-auto">
        <div className="mb-20 text-center">
          <h1 className="mb-4 text-2xl font-medium text-center text-gray-900 sm:text-3xl title-font">What You can do</h1>
          <p className="mx-auto text-base leading-relaxed xl:w-2/4 lg:w-3/4"></p>
        </div>
        <div className="flex flex-wrap -mx-2 lg:w-4/5 sm:mx-auto sm:mb-2">
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Manage Recipients Data</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Manage Donors Data</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Manage Team</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Manage Events</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Recipients Registration</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Donor Registration</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Insert Team Member</span>
              </div>
            </Link>
          </div>
          <div className="w-full p-2 sm:w-1/2">
            <Link to="/eventuploader" className="block">
              <div className="flex items-center h-full p-4 bg-gray-100 rounded">
                <svg fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" className="flex-shrink-0 w-6 h-6 mr-4 text-red-500" viewBox="0 0 24 24">
                  <path d="M22 11.08V12a10 10 0 11-5.93-9.14"></path>
                  <path d="M22 4L12 14.01l-3-3"></path>
                </svg>
                <span className="font-medium title-font">Insert Events</span>
              </div>
            </Link>
          </div>
        </div>
       
      </div>
    </section>
  );
}

export default ContentSection;
