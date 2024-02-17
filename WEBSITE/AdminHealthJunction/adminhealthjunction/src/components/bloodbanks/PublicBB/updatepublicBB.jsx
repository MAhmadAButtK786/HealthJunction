import React, { useEffect, useState } from "react";
import { useParams, useHistory } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../../firebase";

function UpdatePublicBBLPage() {
  const { id } = useParams();
  const history = useHistory();
  const [privateBBLData, setPrivateBBLData] = useState({});
  const [formData, setFormData] = useState({
    Name: "",
    Address: "",
    LicenseNumber: "",
    Sector: "",
  });

  useEffect(() => {
    const fetchPrivateBBLData = async () => {
      const privateBBLDoc = doc(database, "Public Blood Banks", id);
      const privateBBLSnapshot = await getDoc(privateBBLDoc);
      if (privateBBLSnapshot.exists()) {
        const data = privateBBLSnapshot.data();
        setPrivateBBLData(data);
        setFormData(data); // Set form data with private BBL data
      } else {
        console.log("No such document!");
      }
    };
    fetchPrivateBBLData();
  }, [id]);

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    const privateBBLDoc = doc(database, "Public Blood Banks", id);
    await updateDoc(privateBBLDoc, formData);
    alert("Private Blood Bank updated successfully");
    // Redirect to PrivateBBL list page after update
    history.push("/privateBBL");
  };

  return (
    <div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-red-500 to-orange-500">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center">Update Public Blood Bank Information</h1>
        <form onSubmit={handleUpdate}>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Name:
                <input
                  type="text"
                  name="Name"
                  value={formData.Name}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Address:
                <input
                  type="text"
                  name="Address"
                  value={formData.Address}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                License Number:
                <input
                  type="text"
                  name="LicenseNumber"
                  value={formData["License Number"]}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                Sector:
                <input
                  type="text"
                  name="Sector"
                  disabled
                  value={formData.Secter}
                  onChange={handleInputChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
          </div>
          <button
            type="submit"
            className="w-full px-4 py-2 mt-4 text-white transition duration-300 bg-indigo-500 rounded-md hover:bg-indigo-600"
          >
            Update Public Blood Bank
          </button>
        </form>
      </div>
    </div>
  );
}

export default UpdatePublicBBLPage;
