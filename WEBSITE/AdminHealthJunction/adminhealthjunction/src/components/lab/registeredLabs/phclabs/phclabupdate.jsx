/* eslint-disable no-unused-vars */
import React, { useEffect, useState } from "react";
import { useParams, useHistory } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../../../firebase";

function UpdateLabPage() {
  const { id } = useParams();
  const history = useHistory();
  const [labData, setLabData] = useState({});
  const [formData, setFormData] = useState({
    "Lab Name": "",
    Location: "",
    District: "",
    "Phone Number": "",
    "Serial Number": ""
  });
  const [errors, setErrors] = useState({});

  useEffect(() => {
    const fetchLabData = async () => {
      const labDoc = doc(database, "Punjab Register Lab", id);
      const labSnapshot = await getDoc(labDoc);
      if (labSnapshot.exists()) {
        const data = labSnapshot.data();
        setLabData(data);
        setFormData(data); // Set form data with lab data
      } else {
        console.log("No such document!");
      }
    };
    fetchLabData();
  }, [id]);

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const validateForm = () => {
    let valid = true;
    let errors = {};
    if (!formData["Lab Name"]) {
      errors["Lab Name"] = "Lab Name is required";
      valid = false;
    }
    if (!formData.Location) {
      errors["Location"] = "Location is required";
      valid = false;
    }
    if (!formData.District) {
      errors["District"] = "District is required";
      valid = false;
    }
    setErrors(errors);
    return valid;
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    if (validateForm()) {
      const labDoc = doc(database, "Punjab Register Lab", id);
      await updateDoc(labDoc, formData);
      alert("Lab updated successfully");
      // Redirect to lab list page after update
      history.push("/PHCLabs");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-gray-500 to-gray-400">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center">Update Lab Information</h1>
        <form onSubmit={handleUpdate}>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Lab Name:
                <input
                  type="text"
                  name="Lab Name"
                  value={formData["Lab Name"]}
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
                  value={formData.Location}
                  onChange={handleInputChange}
                  className={`block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50 ${errors["Location"] ? "border-red-500" : ""}`}
                />
                {errors["Location"] && <p className="mt-1 text-sm text-red-500">{errors["Location"]}</p>}
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                District:
                <input
                  type="text"
                  name="District"
                  value={formData.District}
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
                  value={formData["Phone Number"]}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Serial Number:
                <input
                  type="text"
                  name="Serial Number"
                  value={formData["Serial Number"]}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-blue-500 focus:ring focus:ring-blue-200 focus:ring-opacity-50"
                />
              </label>
            </div>
          </div>
          <button
            type="submit"
            className="w-full px-4 py-2 mt-4 text-white transition duration-300 bg-blue-500 rounded-md hover:bg-blue-600"
          >
            Update Lab
          </button>
        </form>
      </div>
    </div>
  );
}

export default UpdateLabPage;
