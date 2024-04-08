import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../firebase";

function AddPHC() {
  const [BBPrivateData, setBBPrivateData] = useState({
    Address: "",
   District : "", // Adjusted field name
    "Hospital Name": "",
    Sector: "", 
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setBBPrivateData({
      ...BBPrivateData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validation
    if (
      !BBPrivateData.Address ||
      !BBPrivateData.District ||
      !BBPrivateData["Hospital Name"]||
      !BBPrivateData.Sector
    ) {
      alert("Please fill in all fields.");
      return;
    }

    try {
      await addDoc(collection(database, "PHC Hospitals"), BBPrivateData);
      alert("Hospital added successfully!");

      // Reset form fields
      setBBPrivateData({
        Address: "",
        Distrct: "",
        "Hospital Name": "",
        Secter: "", 
      });
    } catch (error) {
      console.error("Error adding Hospital: ", error);
      alert("Failed to add Hospital. Please try again.");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-blue-600 via-indigo-400 to-blue-500">
      <div className="w-full max-w-md p-8 bg-white rounded-lg shadow-md">
        <h1 className="mb-6 text-3xl font-bold text-center text-red-600">
          Add Hospital
        </h1>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="Address">Address</label>
            <input
              type="text"
              placeholder="Address"
              name="Address"
              value={BBPrivateData.Address}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="District">District</label>
            <input
              type="text"
              placeholder="District"
              name="District"
              value={BBPrivateData.District}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Hospital Name">Name</label>
            <input
              type="text"
              placeholder="Hospital Name"
              name="Hospital Name"
              value={BBPrivateData["Hospital Name"]}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Sector">Sector</label>
            <select
              name="Sector"
              value={BBPrivateData.Sector}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            >
                 <option value="">Select Sector</option>
              <option value="Private">Private</option>
              <option value="Public">Public</option>
            </select>
          </div>

          <div className="mb-4">
            <p>Note: Please ensure to pin your location on Google Maps.</p>
          </div>

          <div className="flex justify-center">
            <button
              type="submit"
              className="px-6 py-3 text-white bg-blue-500 rounded-md hover:bg-blue-600 focus:outline-none focus:ring focus:border-blue-300"
            >
              Insert Hospital
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AddPHC;
