import React, { useEffect, useState } from "react";
import { collection, getDocs, doc, deleteDoc } from "firebase/firestore";
import { database } from "../../../firebase";
import { Link } from 'react-router-dom';
import { FaTrash, FaEdit } from 'react-icons/fa';

function CharityORGL() {
  const [NGOsData, setNGOsData] = useState([]);

  useEffect(() => {
    getData();
  }, []);

  const getData = async () => {
    const querySnapshot = await getDocs(collection(database, "NGOs"));
    const data = querySnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    setNGOsData(data);
  };

  const handleDelete = async (id) => {
    if (window.confirm("Are you sure you want to delete this NGO?")) {
      try {
        await deleteDoc(doc(database, "NGOs", id));
        setNGOsData(NGOsData.filter(NGO => NGO.id !== id));
        alert("NGO deleted successfully!");
      } catch (error) {
        console.error("Error deleting NGO:", error);
      }
    }
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
      <div className="flex justify-end px-6 py-4">
        <Link to={`/NGOupdate/${NGO.id}`}>
          <button className="mr-2 text-green-500 hover:text-green-700">
            <FaEdit />
          </button>
        </Link>
        <button onClick={() => handleDelete(NGO.id)} className="text-red-500 hover:text-red-700">
          <FaTrash />
        </button>
      </div>
    </details>
  );

  return (
    <div>
     <div className="p-5 text-center md:text-left md:flex md:items-center md:justify-center md:space-x-10 animate-pulse">
  <div className="md:w-1/2">
    <h1 className="text-4xl font-bold text-purple-900">
      Admin Panel
    </h1>
    <p className="text-lg text-indigo-700">Manage Charitable Organizations</p>
  </div>
  <div className="md:w-1/2">
    <p className="text-lg text-gray-700">
      Welcome to the admin panel where you can manage charitable organizations. Charitable organizations play a vital role in addressing societal needs and advocating for systemic change to better serve disadvantaged populations. By promoting a culture of giving, they strengthen community bonds and contribute to global development.
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
          <NGOCard key={NGO.id} NGO={NGO} />
        ))}
      </div>
    </div>
  );
}

export default CharityORGL;
