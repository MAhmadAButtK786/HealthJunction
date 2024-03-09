import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../../../../firebase";

function HealthZoneInsertPage() {
  const [formData, setFormData] = useState({
    "Test Name": "",
    "Code": "",
    "Price": "",
    "Reporting Time": "",
    "Sample Required": ""
  });

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      await addDoc(collection(database, "Health Zone Lab"), formData);
      setFormData({
        "Test Name": "",
        "Code": "",
        "Price": "",
        "Reporting Time": "",
        "Sample Required": ""
      });
    } catch (error) {
      console.error("Error adding document: ", error);
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <form onSubmit={handleSubmit} className="w-full max-w-md mt-5 bg-white rounded-lg shadow-md">
        <div className="px-6 py-4 font-bold text-center text-white bg-gray-600">
          Add Test Data For Health Zone Lab
        </div>
        <div className="px-6 py-8">
          <div className="mb-4">
            <label htmlFor="TestName" className="block text-sm font-semibold text-gray-600">Test Name</label>
            <input type="text" name="Test Name" id="TestName" value={formData["Test Name"]} onChange={handleInputChange} className="w-full px-3 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:border-blue-500" />
          </div>
          <div className="mb-4">
            <label htmlFor="Code" className="block text-sm font-semibold text-gray-600">Code</label>
            <input type="text" name="Code" id="Code" value={formData["Code"]} onChange={handleInputChange} className="w-full px-3 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:border-blue-500" />
          </div>
          <div className="mb-4">
            <label htmlFor="Price" className="block text-sm font-semibold text-gray-600">Price</label>
            <input type="text" name="Price" id="Price" value={formData["Price"]} onChange={handleInputChange} className="w-full px-3 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:border-blue-500" />
          </div>
          <div className="mb-4">
            <label htmlFor="ReportingTime" className="block text-sm font-semibold text-gray-600">Reporting Time</label>
            <input type="text" name="Reporting Time" id="ReportingTime" value={formData["Reporting Time"]} onChange={handleInputChange} className="w-full px-3 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:border-blue-500" />
          </div>
          <div className="mb-4">
            <label htmlFor="SampleRequired" className="block text-sm font-semibold text-gray-600">Sample Required</label>
            <input type="text" name="Sample Required" id="SampleRequired" value={formData["Sample Required"]} onChange={handleInputChange} className="w-full px-3 py-2 mt-1 text-sm border rounded-md focus:outline-none focus:border-blue-500" />
          </div>
          <button type="submit" className="w-full py-2.5 bg-gray-500 hover:bg-gray-600 focus:bg-black focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50 text-white text-sm font-semibold rounded-md shadow-md">Submit</button>
        </div>
      </form>
    </div>
  );
}

export default HealthZoneInsertPage;
