import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../../firebase";

function PHChospitals() {
  const [testsData, setTestsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    if (database) {
      getData();
    }
  }, []);

  const getData = async () => {
    try {
      const querySnapshot = await getDocs(collection(database, "PHC Hospitals"));
      console.log("Query Snapshot:", querySnapshot.docs);
      const data = querySnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
      console.log("Data:", data);
      setTestsData(data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };
  

  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  const filteredTests = testsData.filter((test) =>
    test.Name &&
    typeof test.Name === 'string' &&
    test.Name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-blue-600">PHC Hospitals</h1>
        </div>
        <div className="">
          <div className="flex justify-center mb-4">
            <input
              type="text"
              className="px-4 py-2 border border-gray-400 rounded"
              placeholder="Search by name"
              value={searchTerm}
              onChange={handleSearch}
            />
          </div>
          <table className="w-full mt-5 text-center border border-blue-700">
            <thead className="h-10 bg-blue-700 border-b border-blue-500">
              <tr>
                <th className="px-4 py-2 text-white">Hospital Name</th>
                <th className="px-4 py-2 text-white">District</th>
                <th className="px-4 py-2 text-white">Address</th>
                <th className="px-4 py-2 text-white">Sector</th>
              </tr>
            </thead>
            <tbody>
              {filteredTests.map((hospital) => (
                <tr key={hospital.id} className="h-12 bg-white border-b border-gray-400">
                  <td className="px-4 py-2">{hospital["Hospital Name"]}</td>
                  <td className="px-4 py-2">{hospital.District}</td>
                  <td className="px-4 py-2 text-blue-600 underline">
                    <a
                      href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
                        hospital.Address
                      )}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {hospital.Address}
                    </a>
                  </td>
                  <td className="px-4 py-2">{hospital.Sector}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default PHChospitals;
