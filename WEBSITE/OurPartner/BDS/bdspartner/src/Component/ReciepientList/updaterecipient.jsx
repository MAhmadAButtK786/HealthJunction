import React, { useEffect, useState } from "react";
import { useHistory, useLocation } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../firebase";

function UpdateRecipient() {
  const location = useLocation();
  const recipientFromLocation = location.state ? location.state.recipient : null;
  const [recipient, setRecipient] = useState(recipientFromLocation || {});
  const [updatedData, setUpdatedData] = useState(recipientFromLocation || {});

  const history = useHistory();

  useEffect(() => {
    if (!recipientFromLocation) {
      const fetchData = async () => {
        try {
          const recipientRef = doc(database, "BDS Recipient", recipient.id);
          const recipientDoc = await getDoc(recipientRef);
          if (recipientDoc.exists()) {
            setRecipient(recipientDoc.data());
            setUpdatedData(recipientDoc.data());
          } else {
            console.log("No such document!");
          }
        } catch (error) {
          console.error("Error getting document:", error);
        }
      };

      fetchData();
    }
  }, [recipientFromLocation, recipient]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setUpdatedData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleUpdate = async () => {
    try {
      const recipientRef = doc(database, "BDS Recipient", recipient.id);
      await updateDoc(recipientRef, updatedData);
      history.push("/recipientlist");
    } catch (error) {
      console.error("Error updating document:", error);
    }
  };

  return (
    <div className="container mx-auto">
      <h1 className="mb-4 text-2xl font-bold">Update Recipient</h1>
      <form>
        <div className="mb-4">
          <label className="block text-gray-700">Full Name</label>
          <input
            type="text"
            name="FullName"
            value={updatedData.FullName}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Age</label>
          <input
            type="number"
            name="Age"
            value={updatedData.Age}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Blood Type</label>
          <input
            type="text"
            name="BloodType"
            value={updatedData.BloodType}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">City</label>
          <input
            type="text"
            name="City"
            value={updatedData.City}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Email</label>
          <input
            type="email"
            name="Email"
            value={updatedData.Email}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Phone</label>
          <input
            type="tel"
            name="Phone"
            value={updatedData.Phone}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Province</label>
          <input
            type="text"
            name="Province"
            value={updatedData.Province}
            onChange={handleInputChange}
            className="block w-full mt-1 form-input"
          />
        </div>
        <button
          type="button"
          onClick={handleUpdate}
          className="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700"
        >
          Save
        </button>
      </form>
    </div>
  );
}

export default UpdateRecipient;
