import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { useHistory } from "react-router-dom";
import { database } from "../../firebase";
function AddDonorPage() {
  const [donorData, setRecipientData] = useState({
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
      ...donorData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validation
    if (
      !donorData.FullName ||
      !donorData.Age ||
      !donorData.BloodType ||
      !donorData.City ||
      !donorData.Email ||
      !donorData.Phone ||
      !donorData.Province
    ) {
      alert("Please fill in all fields.");
      return;
    }

    if (isNaN(donorData.Age) || donorData.Age < 18) {
      alert("Age must be a number and at least 18 years old.");
      return;
    }

    // Regular expression for Pakistani phone number
    const phonePattern = /^[0-9]{11}$/;
    if (!phonePattern.test(donorData.Phone)) {
      alert("Please enter a valid Pakistani phone number.");
      return;
    }

    // Regular expression for email validation
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(donorData.Email)) {
      alert("Please enter a valid email address.");
      return;
    }

    try {
      await addDoc(collection(database, "BDS Donors"), donorData);
      alert("Donor added successfully!");
      setRecipientData({
        FullName: "",
        Age: "",
        BloodType: "",
        City: "",
        Email: "",
        Phone: "",
        Province: "",
      });
    // history.push("/donors"); 
    } catch (error) {
      console.error("Error adding donor: ", error);
      alert("Failed to add donor. Please try again.");
    }
  };
 
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-red-600 via-yellow-400 to-orange-500">
      <div className="w-full max-w-md p-8 bg-white rounded-lg shadow-md">
        <h1 className="mb-6 text-3xl font-bold text-center text-red-600">Add Donors</h1>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="Full Name">Enter your Full Name</label>
            <input
              type="text"
              placeholder="Full Name"
              name="FullName"
              value={donorData.FullName}
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
              value={donorData.Age}
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
              value={donorData.BloodType}
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
              value={donorData.City}
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
              value={donorData.Email}
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
              value={donorData.Phone}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <select
              placeholder="Province"
              name="Province"
              value={donorData.Province}
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
              Add Donor
            </button>
          </div>
        </form>
      </div>
      
    </div>
  );
}

export default AddDonorPage;
