import React from 'react';
import CharityData from './dataofCharity';

function CStory() {
  return (
    <>
   <div className='text-3xl font-bold mb-2 text-center '>
     <span  className="text-purple-900">
     Our Heros and Inspiration
      </span> 
    </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 p-4">
        {CharityData.map((charity, index) => (
          <div
            key={index}
            className="bg-gray-100 p-6 rounded-lg shadow-md flex flex-col transition-transform transform hover:scale-105 duration-300 ease-in-out"
          >
            <div className="mb-4 flex-shrink-0">
              <img
                src={charity.Image}
                alt={charity.title}
                className="w-24 h-24 object-cover rounded-full "
              />
            </div>
            <div>
              <h3 className="text-2xl font-semibold mb-2 text-blue-500">{charity.title}</h3>
              <p className="text-gray-700">{charity.description}</p>
            </div>
          </div>
        ))}
      </div>
    </>
  );
}

export default CStory;
