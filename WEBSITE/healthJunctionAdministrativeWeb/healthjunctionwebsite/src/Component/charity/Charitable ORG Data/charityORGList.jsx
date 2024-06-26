import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../../firebase";

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
    <details className="max-w-md mx-4 mb-8 rounded-lg overflow-hidden shadow-lg bg-white transform hover:scale-105 transition-transform duration-200 ease-in-out h-full">
      <summary className="px-6 py-4 bg-gradient-to-r from-purple-600 to-red-500 text-white cursor-pointer">
        <div className="font-bold text-xl mb-2">{NGO.Title || NGO.title}</div>
        <p className="text-base">{NGO.Descripyion || NGO.description}</p>
      </summary>
      <div className="px-6 py-4 flex-grow">
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
          <h1 className="text-purple-700 text-5xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-purple-700 to-red-700">
            Charitable Organization Information
          </h1>
        </div>
        <div className="md:w-1/2">
          <p className="text-purple-700 text-xl font-semibold">
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
      <div className="flex flex-wrap justify-center items-stretch w-full px-4 pt-10 mx-auto">
        {NGOsData.map((NGO) => (
          <NGOCard NGO={NGO} />
        ))}
      </div>
      </div>
    </>
  );
}

export default CharityORGL;
