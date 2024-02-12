import React from 'react';
import LabData from './data';

function LabDataHome() {
  return (
    <>
      <div className='text-4xl font-extrabold mb-8 text-center text-gray-800'>
        Service Providers
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 p-4">
        {LabData.map((Lab, index) => (
          <div
            key={index}
            className="bg-white p-6 rounded-lg shadow-md overflow-hidden transform hover:scale-105 duration-300 ease-in-out"
          >
            <div className="mb-4">
              <img
                src={Lab.Image}
                alt={Lab.title}
                className="w-32 h-32 object-cover rounded-full mx-auto"
              />
            </div>
            <div>
              <h3 className="text-xl md:text-2xl lg:text-3xl font-semibold mb-2 text-blue-500">
                {Lab.title}
              </h3>
              <p className="text-gray-700">{Lab.description}</p>
            </div>
          </div>
        ))}
      </div>
    </>
  );
}

export default LabDataHome;
