import React, { useState } from "react";
import { FaHospital, FaMapMarkerAlt, FaBuilding, FaCity, FaPhone, FaEnvelope, FaHospitalSymbol, FaBed } from "react-icons/fa";
import { database } from "../../../firebase";
import { useHistory } from "react-router-dom";
import { collection, addDoc, getDocs } from "firebase/firestore"; 
const HospitalForm = () => {
  const history = useHistory();

  const [formData, setFormData] = useState({
    hospitalName: "",
    address: "",
    province: "",
    city: "",
    zipCode: "",
    contactNumber: "",
    email: "",
    departments: "",
    wards: "",
    additionalInfo: "",
  });

  // List of provinces
  const provinces = [
    "Punjab",
    "Sindh",
    "Balochistan",
    "Islamabad Capital Territory",
    "Khyber Pakhtunkhwa",
    "Azad Jammu and Kashmir",
    "Gilgit-Baltistan",
  ];

  // Function to handle form field changes
  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  // Function to handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
  
    // Confirmation dialog
    const isConfirmed = window.confirm("Are you sure you want to submit the form?");
    if (!isConfirmed) {
      return; // If user cancels, do nothing
    }
  
    // Validation: Check if all required fields are filled
    if (!formData.hospitalName || !formData.address || !formData.province || !formData.city || !formData.zipCode || !formData.contactNumber || !formData.email || !formData.departments || !formData.wards) {
      alert("Please fill in all the fields.");
      return;
    }
  
    try {
      // Get the number of existing documents in the collection
      const querySnapshot = await getDocs(collection(database, "HospitalData"));
      const numberOfDocs = querySnapshot.size;
  
      // Generate the ID (incremental)
      const id = `H${numberOfDocs+1}`;
  
      // Add the ID to the form data
      const formDataWithId = { ...formData, id };
  
      // Add the document to the Firestore collection
      await addDoc(collection(database, "HospitalData"), formDataWithId);
      
      console.log("Form data successfully submitted to Firebase.");
      history.push("/hfcheckbox");
    } catch (error) {
      console.error("Error adding document: ", error);
    }
  };
  return (
    <div className="flex items-center justify-center min-h-screen bg-blue-200">
      <div className="w-full max-w-screen-md p-6 my-10 bg-white rounded-md shadow-md">
        <h2 className="mb-6 text-4xl font-bold text-blue-800">
          Hospital Information
        </h2>
        <form onSubmit={handleSubmit} className="grid grid-cols-1 gap-6 md:grid-cols-2">
          {/* Hospital Name */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Hospital Name</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaHospital />
              </span>
              <input
                type="text"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter Hospital Name"
                name="hospitalName"
                value={formData.hospitalName}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Hospital Address */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Hospital Address</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaMapMarkerAlt />
              </span>
              <input
                type="text"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter Hospital Address"
                name="address"
                value={formData.address}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Province Selection */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Province</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaBuilding />
              </span>
              <select
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                name="province"
                value={formData.province}
                onChange={handleChange}
                required
              >
                <option value="" disabled>
                  Select Province
                </option>
                {provinces.map((province) => (
                  <option key={province} value={province}>
                    {province}
                  </option>
                ))}
              </select>
            </div>
          </div>

          {/* City */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">City</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaCity />
              </span>
              <input
                type="text"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter City"
                name="city"
                value={formData.city}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Zip Code */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Zip Code</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaHospitalSymbol />
              </span>
              <input
                type="number"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter Zip Code"
                name="zipCode"
                value={formData.zipCode}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Contact Number */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Contact Number</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaPhone />
              </span>
              <input
                 type="tel"
                 pattern="^(\+92|0)\d{10}$"
                 className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                 placeholder="Enter Contact Number"
                 name="contactNumber"
                 value={formData.contactNumber}
                 onChange={handleChange}
                 required
              />
            </div>
          </div>

          {/* Email */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Email</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaEnvelope />
              </span>
              <input
                type="email"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter Email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Number Of Departments */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">
              Number Of Departments
            </label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaBuilding />
              </span>
              <input
                type="number"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter Number Of Departments"
                name="departments"
                value={formData.departments}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Number Of Wards */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Number Of Wards</label>
            <div className="relative">
              <span className="absolute transform -translate-y-1/2 left-3 top-1/2">
                <FaBed />
              </span>
              <input
                type="number"
                className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                placeholder="Enter Number Of Wards"
                name="wards"
                value={formData.wards}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          {/* Additional Information */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Additional Information</label>
            <textarea
              className="w-full h-24 px-3 py-2 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
              placeholder="Enter Additional Information"
              name="additionalInfo"
              value={formData.additionalInfo}
              onChange={handleChange}
            ></textarea>
          </div>

          {/* Submit Button */}
          <div className="mb-6">
            <button
              type="submit"
              className="px-4 py-2 text-white bg-blue-500 rounded-md"
            >
              Submit
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default HospitalForm;
