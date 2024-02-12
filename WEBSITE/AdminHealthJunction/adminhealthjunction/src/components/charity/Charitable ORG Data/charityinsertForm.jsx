/* eslint-disable no-unused-vars */
import React, { useEffect, useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../../firebase";

function CharityForm() {
  const [formData, setFormData] = useState({
    "Title": "",
    "Descripyion": "", // Corrected typo here
    "Location": "",
    "Account Details": "",
    "Account Number": "",
    "Branch Code": "",
    "Contact": "",
    "IBAN": "",
    "Internation Contact": "", // Corrected typo here
    "Swift Code": ""
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const docRef = await addDoc(collection(database, "NGOs"), formData);
      console.log("Document written with ID: ", docRef.id);
      // Clear form data after submission
      setFormData({
        "Title": "",
        "Descripyion": "", // Corrected typo here
        "Location": "",
        "Account Details": "",
        "Account Number": "",
        "Branch Code": "",
        "Contact": "",
        "IBAN": "",
        "Internation Contact": "", // Corrected typo here
        "Swift Code": ""
      });
    } catch (error) {
      console.error("Error adding document: ", error);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="max-w-md p-6 mx-auto mt-8 bg-white rounded-lg shadow-md">
      <h2 className="mb-4 text-2xl font-bold">Add New Charity Organization</h2>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="title">Title</label>
        <input
          type="text"
          id="title"
          name="Title"
          value={formData.Title}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          required
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="description">Description</label>
        <textarea
          id="description"
          name="Descripyion" // Corrected typo here
          value={formData.Descripyion} // Corrected typo here
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          rows="4"
          required
        ></textarea>
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="location">Location</label>
        <input
          type="text"
          id="location"
          name="Location"
          value={formData.Location}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          required
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="accountDetails">Account Details</label>
        <input
          type="text"
          id="accountDetails"
          name="Account Details"
          value={formData["Account Details"]}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="accountNumber">Account Number</label>
        <input
          type="text"
          id="accountNumber"
          name="Account Number"
          value={formData["Account Number"]}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="branchCode">Branch Code</label>
        <input
          type="text"
          id="branchCode"
          name="Branch Code"
          value={formData["Branch Code"]}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="contact">Contact</label>
        <input
          type="text"
          id="contact"
          name="Contact"
          value={formData.Contact}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="iban">IBAN</label>
        <input
          type="text"
          id="iban"
          name="IBAN"
          value={formData.IBAN}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="internationalContact">International Contact</label>
        <input
          type="text"
          id="internationalContact"
          name="Internation Contact" // Corrected typo here
          value={formData["Internation Contact"]} // Corrected typo here
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <div className="mb-4">
        <label className="block mb-2 text-sm font-bold text-gray-700" htmlFor="swiftCode">Swift Code</label>
        <input
          type="text"
          id="swiftCode"
          name="Swift Code"
          value={formData["Swift Code"]}
          onChange={handleChange}
          className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
        />
      </div>
      <button type="submit" className="w-full px-4 py-2 text-white transition duration-200 bg-purple-600 rounded-lg hover:bg-purple-700">Submit</button>
    </form>
  );
}

export default CharityForm;
