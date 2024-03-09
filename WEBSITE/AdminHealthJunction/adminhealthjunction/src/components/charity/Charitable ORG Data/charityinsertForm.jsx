import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../../firebase";
import { useHistory } from "react-router-dom";

function CharityForm() {
  const [formData, setFormData] = useState({
    "Title": "",
    "Descripyion": "",
    "Location": "",
    "Account Details": "",
    "Account Number": "",
    "Branch Code": "",
    "Contact": "",
    "IBAN": "",
    "Internation Contact": "",
    "Swift Code": "",
    "Website": ""
  });

  const history = useHistory();

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
      // Clear form data after successful submission
      setFormData({
        "Title": "",
        "Descripyion": "",
        "Location": "",
        "Account Details": "",
        "Account Number": "",
        "Branch Code": "",
        "Contact": "",
        "IBAN": "",
        "Internation Contact": "",
        "Swift Code": "",
        "Website": ""
      });
      // Show success alert
      alert("Form submitted successfully!");
      // Redirect to "/charityORG"
      history.push("/charityORG");
    } catch (error) {
      console.error("Error adding document: ", error);
      // Show error alert
      alert("Error submitting form. Please try again.");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-indigo-700">
      <form onSubmit={handleSubmit} className="max-w-md p-8 bg-white rounded-lg shadow-md">
        <h2 className="mb-6 text-3xl font-bold text-center text-indigo-600">Add New Charity Organization</h2>
        
        {/* Title */}
        <div className="mb-4">
          <label htmlFor="title" className="block mb-2 text-sm font-bold text-gray-700">Title</label>
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
        
        {/* Description */}
        <div className="mb-4">
          <label htmlFor="description" className="block mb-2 text-sm font-bold text-gray-700">Description</label>
          <textarea
            id="description"
            name="Descripyion"
            value={formData.Descripyion}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
            rows="4"
            required
          ></textarea>
        </div>
        
        {/* Location */}
        <div className="mb-4">
          <label htmlFor="location" className="block mb-2 text-sm font-bold text-gray-700">Location</label>
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

        {/* Account Details */}
        <div className="mb-4">
          <label htmlFor="accountDetails" className="block mb-2 text-sm font-bold text-gray-700">Account Details</label>
          <input
            type="text"
            id="accountDetails"
            name="Account Details"
            value={formData["Account Details"]}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* Account Number */}
        <div className="mb-4">
          <label htmlFor="accountNumber" className="block mb-2 text-sm font-bold text-gray-700">Account Number</label>
          <input
            type="text"
            id="accountNumber"
            name="Account Number"
            value={formData["Account Number"]}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* Branch Code */}
        <div className="mb-4">
          <label htmlFor="branchCode" className="block mb-2 text-sm font-bold text-gray-700">Branch Code</label>
          <input
            type="text"
            id="branchCode"
            name="Branch Code"
            value={formData["Branch Code"]}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* Contact */}
        <div className="mb-4">
          <label htmlFor="contact" className="block mb-2 text-sm font-bold text-gray-700">Contact</label>
          <input
            type="text"
            id="contact"
            name="Contact"
            value={formData.Contact}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* IBAN */}
        <div className="mb-4">
          <label htmlFor="iban" className="block mb-2 text-sm font-bold text-gray-700">IBAN</label>
          <input
            type="text"
            id="iban"
            name="IBAN"
            value={formData.IBAN}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* International Contact */}
        <div className="mb-4">
          <label htmlFor="internationalContact" className="block mb-2 text-sm font-bold text-gray-700">International Contact</label>
          <input
            type="text"
            id="internationalContact"
            name="Internation Contact"
            value={formData["Internation Contact"]}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* Swift Code */}
        <div className="mb-4">
          <label htmlFor="swiftCode" className="block mb-2 text-sm font-bold text-gray-700">Swift Code</label>
          <input
            type="text"
            id="swiftCode"
            name="Swift Code"
            value={formData["Swift Code"]}
            onChange={handleChange}
            className="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-purple-500"
          />
        </div>

        {/* Submit Button */}
        <button type="submit" className="w-full px-4 py-2 text-white transition duration-200 bg-indigo-600 rounded-lg hover:bg-indigo-700">Submit</button>
      </form>
    </div>
  );
}

export default CharityForm;
