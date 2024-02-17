import React, { useEffect, useState } from "react";
import { useParams, useHistory } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../firebase";

function UpdateDonorPage() {
  const { id } = useParams();
  const history = useHistory();
  const [donorData, setDonorData] = useState({});
  const [formData, setFormData] = useState({
    FullName: "",
    Age: "",
    BloodType: "",
    City: "",
    Email: "",
    Phone: "",
    Province: "",
  });

  useEffect(() => {
    const fetchDonorData = async () => {
      const donorDoc = doc(database, "BDS Donors", id);
      const donorSnapshot = await getDoc(donorDoc);
      if (donorSnapshot.exists()) {
        const data = donorSnapshot.data();
        setDonorData(data);
        setFormData(data); // Set form data with donor data
      } else {
        console.log("No such document!");
      }
    };
    fetchDonorData();
  }, [id]);

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    const donorDoc = doc(database, "BDS Donors", id);
    await updateDoc(donorDoc, formData);
    alert("Donor updated successfully");
    // Redirect to donor list page after update
    history.push("/donorlistORG");
  };

  return (
<div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-red-500 to-orange-500">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center">Update Donor Information</h1>
        <form onSubmit={handleUpdate}>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Full Name:
                <input
                  type="text"
                  name="FullName"
                  value={formData.FullName}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Age:
                <input
                  type="number"
                  name="Age"
                  value={formData.Age}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Blood Type:
                <select
                  name="BloodType"
                  value={formData.BloodType}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-select focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                >
                  <option value="">Select Blood Type</option>
                  <option value="A+">A+</option>
                  <option value="A-">A-</option>
                  <option value="B+">B+</option>
                  <option value="B-">B-</option>
                  <option value="AB+">AB+</option>
                  <option value="AB-">AB-</option>
                  <option value="O+">O+</option>
                  <option value="O-">O-</option>
                  <option value="NI">NI</option>
                </select>
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                City:
                <input
                  type="text"
                  name="City"
                  value={formData.City}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Email:
                <input
                  type="email"
                  name="Email"
                  value={formData.Email}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Phone:
                <input
                  type="tel"
                  name="Phone"
                  value={formData.Phone}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Province:
                <select
                  name="Province"
                  value={formData.Province}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-select focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                >
                  <option value="">Select Province</option>
                  <option value="Punjab">Punjab</option>
                  <option value="Sindh">Sindh</option>
                  <option value="Khyber Pakhtunkhwa">Khyber Pakhtunkhwa</option>
                  <option value="Balochistan">Balochistan</option>
                  <option value="Gilgit-Baltistan">Gilgit-Baltistan</option>
                  <option value="Azad Jammu and Kashmir">Azad Jammu and Kashmir</option>
                  <option value="Islamabad Capital Territory">Islamabad Capital Territory</option>
                </select>
              </label>
            </div>
          </div>
          <button
            type="submit"
            className="w-full px-4 py-2 mt-4 text-white transition duration-300 bg-indigo-500 rounded-md hover:bg-indigo-600"
          >
            Update Donor
          </button>
        </form>
      </div>
    </div>
  );
}

export default UpdateDonorPage;
