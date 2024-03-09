import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../../firebase";

function InsertLabPage() {
  const [newLabData, setNewLabData] = useState({
    "Lab Name": "",
    Location: "",
    District: "",
    "Phone Number": "",
    "Serial Number": ""
  });

  const handleInputChange = event => {
    const { name, value } = event.target;
    setNewLabData({ ...newLabData, [name]: value });
  };

  const handleInsertLab = async () => {
    try {
      await addDoc(collection(database, "Punjab Register Lab"), newLabData);
      alert("Lab inserted successfully!");
      // You can redirect the user to another page after successful insertion
    } catch (error) {
      console.error("Error inserting lab:", error);
    }
  };

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-red-600">Insert New Lab</h1>
        </div>
        <div className="mt-5">
          <div className="mb-4">
            <label htmlFor="labName" className="block mb-1 font-medium text-gray-600">Lab Name</label>
            <input
              type="text"
              id="labName"
              name="Lab Name"
              value={newLabData["Lab Name"]}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="location" className="block mb-1 font-medium text-gray-600">Location</label>
            <input
              type="text"
              id="location"
              name="Location"
              value={newLabData.Location}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="district" className="block mb-1 font-medium text-gray-600">District</label>
            <input
              type="text"
              id="district"
              name="District"
              value={newLabData.District}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="phoneNumber" className="block mb-1 font-medium text-gray-600">Phone Number</label>
            <input
              type="text"
              id="phoneNumber"
              name="Phone Number"
              value={newLabData["Phone Number"]}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="serialNumber" className="block mb-1 font-medium text-gray-600">Serial Number</label>
            <input
              type="text"
              id="serialNumber"
              name="Serial Number"
              value={newLabData["Serial Number"]}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <button onClick={handleInsertLab} className="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700">
            Insert Lab
          </button>
        </div>
      </div>
    </div>
  );
}

export default InsertLabPage;
