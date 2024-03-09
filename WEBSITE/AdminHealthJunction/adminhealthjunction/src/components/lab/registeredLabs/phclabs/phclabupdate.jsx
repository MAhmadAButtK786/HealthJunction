/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-unused-vars */
import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { doc, updateDoc } from "firebase/firestore";
import { database } from "../../../../firebase";

function UpdateLabPage() {
  const { id } = useParams();
  const [labData, setLabData] = useState({});
  const [updatedLabData, setUpdatedLabData] = useState({
    "Lab Name": "",
    Location: "",
    District: "",
    "Phone Number": "",
    "Serial Number": ""
  });

  useEffect(() => {
    if (database) {
      getLabData();
    }
  }, []);

  const getLabData = async () => {
    try {
      const docRef = doc(database, "Punjab Register Lab", id);
      const docSnap = await docRef.get();
      if (docSnap.exists()) {
        setLabData(docSnap.data());
        setUpdatedLabData(docSnap.data());
      } else {
        console.log("No such document!");
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const handleInputChange = event => {
    const { name, value } = event.target;
    setUpdatedLabData({ ...updatedLabData, [name]: value });
  };

  const handleUpdateLab = async () => {
    try {
      await updateDoc(doc(database, "Punjab Register Lab", id), updatedLabData);
      alert("Lab updated successfully!");
      // You can redirect the user to another page after successful update
    } catch (error) {
      console.error("Error updating lab:", error);
    }
  };

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-red-600">Update Lab</h1>
        </div>
        <div className="mt-5">
          <div className="mb-4">
            <label htmlFor="labName" className="block mb-1 font-medium text-gray-600">Lab Name</label>
            <input
              type="text"
              id="labName"
              name="Lab Name"
              value={updatedLabData["Lab Name"]}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="location" className="block mb-1 font-medium text-gray-600">Location</label>
            <input
              type="text"
              id="location"
              name="Location"
              value={updatedLabData.Location}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="district" className="block mb-1 font-medium text-gray-600">District</label>
            <input
              type="text"
              id="district"
              name="District"
              value={updatedLabData.District}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="phoneNumber" className="block mb-1 font-medium text-gray-600">Phone Number</label>
            <input
              type="text"
              id="phoneNumber"
              name="Phone Number"
              value={updatedLabData["Phone Number"]}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="serialNumber" className="block mb-1 font-medium text-gray-600">Serial Number</label>
            <input
              type="text"
              id="serialNumber"
              name="Serial Number"
              value={updatedLabData["Serial Number"]}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-400 rounded"
            />
          </div>
          <button onClick={handleUpdateLab} className="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700">
            Update Lab
          </button>
        </div>
      </div>
    </div>
  );
}

export default UpdateLabPage;
