/* eslint-disable no-unused-vars */
import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { database } from "../../../../firebase";
import { useHistory } from "react-router-dom";

function InsertLabPage() {
  const history = useHistory();
  const [newLabData, setNewLabData] = useState({
    "Lab Name": "",
    Location: "",
    District: "",
    "Phone Number": "",
    "Serial Number": ""
  });
  const [errors, setErrors] = useState({});

  const handleInputChange = event => {
    setNewLabData({ ...newLabData, [event.target.name]: event.target.value });
  };

  const validateForm = () => {
    let valid = true;
    let errors = {};
    if (!newLabData["Lab Name"]) {
      errors["Lab Name"] = "Lab Name is required";
      valid = false;
    }
    if (!newLabData.Location) {
      errors["Location"] = "Location is required";
      valid = false;
    }
    if (!newLabData.District) {
      errors["District"] = "District is required";
      valid = false;
    }
    if (!/^\d{10}$/.test(newLabData["Phone Number"])) {
      errors["Phone Number"] = "Phone Number should be a 10-digit number";
      valid = false;
    }
    setErrors(errors);
    return valid;
  };

  const handleInsertLab = async () => {
    if (validateForm()) {
      try {
        await addDoc(collection(database, "Punjab Register Lab"), newLabData);
        alert("Lab inserted successfully!");
        // Redirect the user to the PHCLab page after successful insertion
        history.push("/PHCLab");
      } catch (error) {
        console.error("Error inserting lab:", error);
      }
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-gray-500 to-gray-400">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center">Insert New Lab</h1>
        <form>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Lab Name:
                <input
                  type="text"
                  name="Lab Name"
                  value={newLabData["Lab Name"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50 ${errors["Lab Name"] ? "border-red-500" : ""}`}
                />
                {errors["Lab Name"] && <p className="mt-1 text-sm text-red-500">{errors["Lab Name"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Location:
                <input
                  type="text"
                  name="Location"
                  value={newLabData.Location}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50 ${errors["Location"] ? "border-red-500" : ""}`}
                />
                {errors["Location"] && <p className="mt-1 text-sm text-red-500">{errors["Location"]}</p>}
                <p className="mt-1 text-sm text-gray-500">Please enter the location or pin it on Google Maps.</p>
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                District:
                <input
                  type="text"
                  name="District"
                  value={newLabData.District}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50 ${errors["District"] ? "border-red-500" : ""}`}
                />
                {errors["District"] && <p className="mt-1 text-sm text-red-500">{errors["District"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Phone Number:
                <input
                  type="text"
                  name="Phone Number"
                  value={newLabData["Phone Number"]}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50 ${errors["Phone Number"] ? "border-red-500" : ""}`}
                />
                {errors["Phone Number"] && <p className="mt-1 text-sm text-red-500">{errors["Phone Number"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Serial Number:
                <input
                  type="text"
                  name="Serial Number"
                  value={newLabData["Serial Number"]}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50"
                />
              </label>
            </div>
          </div>
          <button
            type="button"
            onClick={handleInsertLab}
            className="w-full px-4 py-2 mt-4 text-white transition duration-300 bg-blue-500 rounded-md hover:bg-blue-600"
          >
            Insert Lab
          </button>
        </form>
      </div>
    </div>
  );
}

export default InsertLabPage;
