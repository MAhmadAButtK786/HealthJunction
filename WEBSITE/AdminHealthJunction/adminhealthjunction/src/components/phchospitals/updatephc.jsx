import React, { useEffect, useState } from "react";
import { useParams, useHistory } from "react-router-dom";
import { doc, getDoc, updateDoc } from "firebase/firestore";
import { database } from "../../../firebase";

function UpdatePHCHospitalPage() {
  const { id } = useParams();
  const history = useHistory();
  const [privateBBLData, setPrivateBBLData] = useState({});
  const [formData, setFormData] = useState({
    HospitalName: "",
    Address: "",
    District: "",
    Sector: "",
  });

  useEffect(() => {
    const fetchPrivateBBLData = async () => {
      const privateBBLDoc = doc(database, "PHC Hospitals", id);
      const privateBBLSnapshot = await getDoc(privateBBLDoc);
      if (privateBBLSnapshot.exists()) {
        const data = privateBBLSnapshot.data();
        setPrivateBBLData(data);
        setFormData(data); 
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
    const privateBBLDoc = doc(database, "PHC Hospitals", id);
    await updateDoc(privateBBLDoc, formData);
    alert("Hospital updated successfully");
    // Redirect to PrivateBBL list page after update
    history.push("/phcmainscreen");
  };

  return (
    <div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-blue-500 to-indigo-500">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center">Update Hospital Information</h1>
        <form onSubmit={handleUpdate}>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
              Hospital Name:
                <input
                  type="text"
                  name="Name"
                  value={formData["Hospital Name"]}
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
               District
                <input
                  type="text"
                  name="District"
                  value={formData.District}
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
            Update Private Blood Bank
          </button>
        </form>
      </div>
    </div>
  );
}

export default UpdatePHCHospitalPage;
