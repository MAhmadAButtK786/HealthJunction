/* eslint-disable no-unused-vars */
import React, { useEffect, useState } from "react";
import { useParams, useHistory } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../../firebase";
import { FaArrowLeft } from 'react-icons/fa';

function UpdateCharity() {
  const { id } = useParams();
  const history = useHistory();
  const [NGOData, setNGOData] = useState({});
  const [formData, setFormData] = useState({
    "Account Details": "",
    "Account Number": "",
    "Branch Code": "",
    "Contact": "",
    "Descripyion": "",
    "IBAN": "",
    "Internation Contact": "",
    "Location": "",
    "Swift Code": "",
    "Title": "",
  });
  const [errors, setErrors] = useState({});

  useEffect(() => {
    const fetchNGOData = async () => {
      const NGORef = doc(database, "NGOs", id);
      const NGOSnapshot = await getDoc(NGORef);
      if (NGOSnapshot.exists()) {
        const data = NGOSnapshot.data();
        setNGOData(data);
        setFormData(data); // Set form data with NGO data
      } else {
        console.log("No such document!");
      }
    };
    fetchNGOData();
  }, [id]);

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const validateForm = () => {
    let valid = true;
    let errors = {};
    if (!formData.Title) {
      errors.Title = "Title is required";
      valid = false;
    }
    if (!formData.Location) {
      errors.Location = "Location is required";
      valid = false;
    }
    setErrors(errors);
    return valid;
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    if (validateForm()) {
      const NGORef = doc(database, "NGOs", id);
      await updateDoc(NGORef, formData);
      alert("NGO updated successfully");
      // Redirect to NGO list page after update
      history.push("/charityORG");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-purple-500 via-indigo-600 to-blue-700">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center text-gray-800">Update Charity Information</h1>
        <form onSubmit={handleUpdate}>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Account Details:
                <input
                  type="text"
                  name="Account Details"
                  value={formData["Account Details"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Account Details"] ? "border-red-500" : ""}`}
                />
                {errors["Account Details"] && <p className="mt-1 text-sm text-red-500">{errors["Account Details"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Account Number:
                <input
                  type="text"
                  name="Account Number"
                  value={formData["Account Number"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Account Number"] ? "border-red-500" : ""}`}
                />
                {errors["Account Number"] && <p className="mt-1 text-sm text-red-500">{errors["Account Number"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Branch Code:
                <input
                  type="text"
                  name="Branch Code"
                  value={formData["Branch Code"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Branch Code"] ? "border-red-500" : ""}`}
                />
                {errors["Branch Code"] && <p className="mt-1 text-sm text-red-500">{errors["Branch Code"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Contact:
                <input
                  type="text"
                  name="Contact"
                  value={formData["Contact"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Contact"] ? "border-red-500" : ""}`}
                />
                {errors["Contact"] && <p className="mt-1 text-sm text-red-500">{errors["Contact"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Descripyion:
                <textarea
                  name="Descripyion"
                  value={formData["Descripyion"]}
                  onChange={handleInputChange}
                  rows="4"
                  className={`block w-full mt-1 border-gray-300 rounded-md form-textarea focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50`}
                ></textarea>
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                IBAN:
                <input
                  type="text"
                  name="IBAN"
                  value={formData["IBAN"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["IBAN"] ? "border-red-500" : ""}`}
                />
                {errors["IBAN"] && <p className="mt-1 text-sm text-red-500">{errors["IBAN"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Internation Contact:
                <input
                  type="text"
                  name="Internation Contact"
                  value={formData["Internation Contact"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Internation Contact"] ? "border-red-500" : ""}`}
                />
                {errors["Internation Contact"] && <p className="mt-1 text-sm text-red-500">{errors["Internation Contact"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Location:
                <input
                  type="text"
                  name="Location"
                  value={formData["Location"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Location"] ? "border-red-500" : ""}`}
                />
                {errors["Location"] && <p className="mt-1 text-sm text-red-500">{errors["Location"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Swift Code:
                <input
                  type="text"
                  name="Swift Code"
                  value={formData["Swift Code"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Swift Code"] ? "border-red-500" : ""}`}
                />
                {errors["Swift Code"] && <p className="mt-1 text-sm text-red-500">{errors["Swift Code"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Title:
                <input
                  type="text"
                  name="Title"
                  value={formData["Title"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-purple-500 focus:ring focus:ring-purple-200 focus:ring-opacity-50 ${errors["Title"] ? "border-red-500" : ""}`}
                />
                {errors["Title"] && <p className="mt-1 text-sm text-red-500">{errors["Title"]}</p>}
              </label>
            </div>
          </div>
          <button
            type="submit"
            className="w-full px-4 py-2 mt-4 text-white transition duration-300 bg-purple-500 rounded-md hover:bg-purple-600"
          >
            Update Charity
          </button>
          <div className="flex items-center justify-center mt-4 text-gray-600 hover:text-gray-900">
            <FaArrowLeft className="mr-2" /> 
            <button onClick={() => history.goBack()} className="text-xl font-semibold">Back to Charity List</button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default UpdateCharity;
