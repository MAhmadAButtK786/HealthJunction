import React, { useState, useEffect } from "react";
import { useParams, useHistory } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../firebase";

function UpdateTeamMemberPage() {
  const { id } = useParams(); // Get the ID parameter from the URL
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

  useEffect(() => {
    // Fetch the existing data of the team member based on the ID
    const fetchData = async () => {
      try {
        const docRef = doc(database, "BDSteam", id);
        const docSnap = await getDoc(docRef);
        if (docSnap.exists()) {
          setMemberData(docSnap.data());
        } else {
          console.log("No such document!");
        }
      } catch (error) {
        console.error("Error fetching document: ", error);
      }
    };

    fetchData();
  }, [id]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setMemberData({
      ...memberData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      await updateDoc(doc(database, "BDSteam", id), memberData);
      alert("Team member updated successfully!");
      history.push("/teammanagement"); // Navigate back to the team page after updating
    } catch (error) {
      console.error("Error updating team member: ", error);
      alert("Failed to update team member. Please try again.");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-red-600 via-yellow-400 to-orange-500">
      <div className="w-full max-w-md p-8 bg-white rounded-lg shadow-md">
        <h1 className="mb-6 text-3xl font-bold text-center text-red-600">Update Team Member</h1>
        <form onSubmit={handleSubmit}>
          {/* Render input fields with existing data */}
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
              Update Team Member
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default UpdateTeamMemberPage;
