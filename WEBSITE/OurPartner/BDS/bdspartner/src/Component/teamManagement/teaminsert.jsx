import React, { useState } from "react";
import { useHistory } from "react-router-dom";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../firebase";

function AddTeamMemberPage() {
  const history = useHistory();
  const [memberData, setMemberData] = useState({
    fullName: "",
    fatherName: "",
    age: "",
    bloodGroup: "",
    address: "",
    city: "",
    province: "",
    email: "",
    phone: "",
    bio: "",
  });

  const bloodGroupOptions = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "Not Specified"];
  const provinceOptions = [
    "Punjab",
    "Sindh",
    "Khyber Pakhtunkhwa",
    "Balochistan",
    "Gilgit-Baltistan",
    "Azad Jammu and Kashmir",
    "Islamabad Capital Territory",
    "Not Specified",
  ];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setMemberData({
      ...memberData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validation
    const requiredFields = ["fullName", "fatherName", "age", "bloodGroup", "address", "city", "province", "email", "phone", "bio"];
    for (const field of requiredFields) {
      if (!memberData[field]) {
        alert(`Please fill in the ${field.replace(/([A-Z])/g, " $1").toLowerCase()} field.`);
        return;
      }
    }

    // Regular expression for email validation
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(memberData.email)) {
      alert("Please enter a valid email address.");
      return;
    }

    // Regular expression for phone number validation
    const phonePattern = /^[0-9]{10}$/;
    if (!phonePattern.test(memberData.phone)) {
      alert("Please enter a valid phone number.");
      return;
    }

    try {
      await addDoc(collection(database, "BDSteam"), memberData);
      alert("Team member added successfully!");
      setMemberData({
        fullName: "",
        fatherName: "",
        age: "",
        bloodGroup: "",
        address: "",
        city: "",
        province: "",
        email: "",
        phone: "",
        bio: "",
      });
      history.push("/team"); // Navigate to the team page after adding a member
    } catch (error) {
      console.error("Error adding team member: ", error);
      alert("Failed to add team member. Please try again.");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-red-600 via-yellow-400 to-orange-500">
      <div className="w-full max-w-md p-8 bg-white rounded-lg shadow-md">
        <h1 className="mb-6 text-3xl font-bold text-center text-red-600">Add Team Member</h1>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="fullName">Full Name</label>
            <input
              type="text"
              name="fullName"
              value={memberData.fullName}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="fatherName">Father's Name</label>
            <input
              type="text"
              name="fatherName"
              value={memberData.fatherName}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="age">Age</label>
            <input
              type="number"
              name="age"
              value={memberData.age}
              onChange={handleInputChange}
              required
              min="18"
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="bloodGroup">Blood Group</label>
            <select
              name="bloodGroup"
              value={memberData.bloodGroup}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            >
              <option value="">Select Blood Group</option>
              {bloodGroupOptions.map((type) => (
                <option key={type} value={type}>
                  {type}
                </option>
              ))}
            </select>
          </div>

          <div className="mb-4">
            <label htmlFor="address">Address</label>
            <input
              type="text"
              name="address"
              value={memberData.address}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="city">City</label>
            <input
              type="text"
              name="city"
              value={memberData.city}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="province">Province</label>
            <select
              name="province"
              value={memberData.province}
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

          <div className="mb-4">
            <label htmlFor="email">Email</label>
            <input
              type="email"
              name="email"
              value={memberData.email}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="phone">Phone</label>
            <input
              type="text"
              name="phone"
              value={memberData.phone}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="mb-4">
            <label htmlFor="bio">Bio</label>
            <textarea
              name="bio"
              value={memberData.bio}
              onChange={handleInputChange}
              required
              className="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring focus:border-blue-500"
            />
          </div>

          <div className="flex justify-center">
            <button
              type="submit"
              className="px-6 py-3 text-white bg-blue-500 rounded-md hover:bg-blue-600 focus:outline-none focus:ring focus:border-blue-300"
            >
              Add Team Member
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AddTeamMemberPage;
