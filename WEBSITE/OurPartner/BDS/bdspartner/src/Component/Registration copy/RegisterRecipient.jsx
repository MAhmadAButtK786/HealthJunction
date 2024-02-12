import React, { useState } from "react";
import { useHistory } from "react-router-dom";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../firebase";

function AddRecipientPage() {
  const [recipientData, setRecipientData] = useState({
    FullName: "",
    Age: "",
    BloodType: "",
    City: "",
    Email: "",
    Phone: "",
    Province: "",
  });

  const bloodTypeOptions = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "NI"];
  const provinceOptions = [
    "Punjab",
    "Sindh",
    "Khyber Pakhtunkhwa",
    "Balochistan",
    "Gilgit-Baltistan",
    "Azad Jammu and Kashmir",
    "Islamabad Capital Territory",
  ];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setRecipientData({
      ...recipientData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validation
    if (
      !recipientData.FullName ||
      !recipientData.Age ||
      !recipientData.BloodType ||
      !recipientData.City ||
      !recipientData.Email ||
      !recipientData.Phone ||
      !recipientData.Province
    ) {
      alert("Please fill in all fields.");
      return;
    }

    if (isNaN(recipientData.Age) || recipientData.Age < 18) {
      alert("Age must be a number and at least 18 years old.");
      return;
    }

    // Regular expression for Pakistani phone number
    const phonePattern = /^[0-9]{11}$/;
    if (!phonePattern.test(recipientData.Phone)) {
      alert("Please enter a valid Pakistani phone number.");
      return;
    }

    // Regular expression for email validation
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(recipientData.Email)) {
      alert("Please enter a valid email address.");
      return;
    }

    try {
      await addDoc(collection(database, "Recepients"), recipientData);
      alert("Recipient added successfully!");
      setRecipientData({
        FullName: "",
        Age: "",
        BloodType: "",
        City: "",
        Email: "",
        Phone: "",
        Province: "",
      });
      // history.push("/recipient");
    } catch (error) {
      console.error("Error adding recipient: ", error);
      alert("Failed to add recipient. Please try again.");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-red-600 via-yellow-400 to-orange-500">
      <div className="w-full max-w-md p-8 bg-white rounded-lg shadow-md">
        <h1 className="mb-6 text-3xl font-bold text-center text-red-600">Add Recipient</h1>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="Full Name">Enter your Full Name</label>
            <input
              type="text"
              placeholder="Full Name"
              name="FullName"
              value={recipientData.FullName}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Age">Enter Your Age</label>
            <input
              type="number"
              placeholder="Age"
              name="Age"
              value={recipientData.Age}
              onChange={handleInputChange}
              required
              min="18"
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            
            <select
              placeholder="Blood Type"
              name="BloodType"
              value={recipientData.BloodType}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            >
              <option value="">Select Blood Type</option>
              {bloodTypeOptions.map((type) => (
                <option key={type} value={type}>
                  {type}
                </option>
              ))}
            </select>
          </div>

          <div className="mb-4">
            <label htmlFor="City">Enter Your City</label>
            <input
              type="text"
              placeholder="City"
              name="City"
              value={recipientData.City}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Email">Enter Your Email</label>
            <input
              type="email"
              placeholder="Email"
              name="Email"
              value={recipientData.Email}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="Phone">Enter Your Phone Number</label>
            <input
              type="text"
              placeholder="Phone"
              name="Phone"
              value={recipientData.Phone}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <select
              placeholder="Province"
              name="Province"
              value={recipientData.Province}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            >
              <option value="">Select Province</option>
              {provinceOptions.map((province) => (
                <option key={province} value={province}>
                  {province}
                </option>
              ))}
            </select>
          </div>

          <div className="flex justify-center">
            <button
              type="submit"
              className="px-6 py-3 text-white bg-blue-500 rounded-md hover:bg-blue-600 focus:outline-none focus:ring focus:border-blue-300"
            >
              Add Recipient
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AddRecipientPage;
