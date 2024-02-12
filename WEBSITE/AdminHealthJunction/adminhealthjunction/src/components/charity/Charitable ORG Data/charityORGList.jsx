import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../../../firebase";
import {Link} from 'react-router-dom'
function CharityORGL() {
  const [NGOsData, setNGOsData] = useState([]);

  useEffect(() => {
    getData();
  }, []);

  const getData = async () => {
    const querySnapshot = await getDocs(collection(database, "NGOs"));
    const data = querySnapshot.docs.map((doc) => doc.data());
    setNGOsData(data);
  };

  const NGOCard = ({ NGO }) => (
    <details className="h-full max-w-md mx-4 mb-8 overflow-hidden transition-transform duration-200 ease-in-out transform bg-white rounded-lg shadow-lg hover:scale-105">
      <summary className="px-6 py-4 text-white cursor-pointer bg-gradient-to-r from-purple-600 to-red-500">
        <div className="mb-2 text-xl font-bold">{NGO.Title || NGO.title}</div>
        <p className="text-base">{NGO.Descripyion || NGO.description}</p>
      </summary>
      <div className="flex-grow px-6 py-4">
        {Object.entries(NGO).map(([key, value]) =>
          key !== "Title" && key !== "Descripyion" ? (
            <p key={key} className="text-gray-700">
              <strong>{key.charAt(0).toUpperCase() + key.slice(1)}:</strong>
              {key === "Location" ? (
                <a
                  href={`https://www.google.com/maps/search/?api=1&query=${value}`}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  📍{value}
                </a>
              ) : (
                value
              )}
            </p>
          ) : null
        )}
      </div>
    </details>
  );

  return (
    <>
    <div>
      <div className="p-5 text-center md:text-left md:flex md:items-center md:justify-center md:space-x-10 animate-pulse">
        <div className="md:w-1/2">
          <h1 className="text-5xl font-bold text-transparent text-purple-700 bg-clip-text bg-gradient-to-r from-purple-700 to-red-700">
            Charitable Organization Information
          </h1>
        </div>
        <div className="md:w-1/2">
          <p className="text-xl font-semibold text-purple-700">
            Charitable organizations are vital as they address societal needs
            often overlooked by government resources. They provide essential
            services like food, shelter, education, and healthcare, and advocate
            for systemic change to better serve disadvantaged populations. By
            promoting a culture of giving, they strengthen community bonds and
            contribute to global development. Thus, they are integral to a
            compassionate and functioning society, both locally and globally.
          </p>
        </div>
      </div>
      <div>
      <Link to="/charityinsert">
          <button className="px-4 py-2 font-bold text-white bg-purple-500 rounded hover:bg-purple-700 ">
            Add NGOs 
          </button>
        </Link>
      </div>
     
      <div className="flex flex-wrap items-stretch justify-center w-full px-4 pt-10 mx-auto">
        {NGOsData.map((NGO) => (
          <NGOCard NGO={NGO} />
        ))}
      </div>
      </div>
    </>
  );
}

export default CharityORGL;
