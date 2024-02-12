// HospitalForm.js

import React, { useState } from "react";
import {
  FaHospital,
  FaMapMarkerAlt,
  FaBuilding,
  FaCity,
  FaPhone,
  FaEnvelope,
  FaHospitalSymbol,
  FaBed,
} from "react-icons/fa";
import { Link } from "react-router-dom";

const HospitalForm = () => {
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

  const provinces = [
    "Province 1",
    "Province 2",
    "Province 3",
    "Province 4",
    "Province 5",
    "Province 6",
    "Province 7",
  ];

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Add your form submission logic here
    console.log("Form Data:", formData);
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-blue-200">
      <div className="w-full max-w-screen-md p-6 my-10 bg-white rounded-md shadow-md">
        <h2 className="mb-6 text-4xl font-bold text-blue-800">
          Hospital Information
        </h2>
        <form
          onSubmit={handleSubmit}
          className="grid grid-cols-1 gap-6 md:grid-cols-2"
        >
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
                pattern="[0-9]{10}"
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

          <br />
          {/* Submit Button */}
          <div className="mb-6">
            <Link to= "/hfcheckbox">
              <button
                type="submit"
                className="px-4 py-2 text-white bg-blue-500 rounded-md"
              >
                Submit
              </button>
            </Link>
          </div>
        </form>

        {/* Link Button to Next Phase */}
      </div>
    </div>
  );
};

export default HospitalForm;
