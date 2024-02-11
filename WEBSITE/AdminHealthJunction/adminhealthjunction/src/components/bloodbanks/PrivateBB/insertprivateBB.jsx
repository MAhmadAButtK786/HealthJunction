import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../../firebase";

function AddPrivateBB() {
  const [BBPrivateData, setBBPrivateData] = useState({
    Address: "",
    "License Number": "", // Adjusted field name
    Name: "",
    Secter: "Private", // Setting default value to "Private"
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
      !BBPrivateData["License Number"] ||
      !BBPrivateData.Name ||
      !BBPrivateData.Secter
    ) {
      alert("Please fill in all fields.");
      return;
    }

    try {
      await addDoc(collection(database, "Private Blood Banks"), BBPrivateData);
      alert("Private Blood Bank added successfully!");

      // Reset form fields
      setBBPrivateData({
        Address: "",
        "License Number": "",
        Name: "",
        Secter: "Private", // Resetting sector to "Private"
      });
    } catch (error) {
      console.error("Error adding private blood bank: ", error);
      alert("Failed to add private blood bank. Please try again.");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-red-600 via-yellow-400 to-orange-500">
      <div className="w-full max-w-md p-8 bg-white rounded-lg shadow-md">
        <h1 className="mb-6 text-3xl font-bold text-center text-red-600">
          Add Private Blood Bank
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
            <label htmlFor="License Number">License Number</label>
            <input
              type="text"
              placeholder="License Number"
              name="License Number"
              value={BBPrivateData["License Number"]}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Name">Name</label>
            <input
              type="text"
              placeholder="Name"
              name="Name"
              value={BBPrivateData.Name}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Sector">Sector</label>
            <select
              name="Sector"
              value={BBPrivateData.Secter}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            >
              <option value="Private">Private</option>
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
              Add Private Blood Bank
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AddPrivateBB;
