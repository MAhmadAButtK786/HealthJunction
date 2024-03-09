import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../../firebase";

function PHCLabData() {
  const [labsData, setLabsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    if (database) {
      getData();
    }
  }, []);

  const getData = async () => {
    try {
      const querySnapshot = await getDocs(collection(database, "Punjab Register Lab"));
      const data = querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
      setLabsData(data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const handleSearch = event => {
    setSearchTerm(event.target.value);
  };

  const filteredLabs = labsData.filter(lab =>
    (lab["Lab Name"] && typeof lab["Lab Name"] === 'string' && lab["Lab Name"].toLowerCase().includes(searchTerm.toLowerCase())) ||
    (lab.District && typeof lab.District === 'string' && lab.District.toLowerCase().includes(searchTerm.toLowerCase()))
  );

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-gray-700">Punjab Register Labs</h1>
        </div>
        <div className="">
          <div className="flex justify-center mb-4">
            <input
              type="text"
              className="px-4 py-2 border border-gray-400 rounded"
              placeholder="Search by name or district"
              value={searchTerm}
              onChange={handleSearch}
            />
          </div>
          <table className="w-full mt-5 text-center border border-red-500">
            <thead className="h-10 bg-gray-700 border-b border-gray-500">
              <tr>
                <th className="px-4 py-2 text-white">Lab Name</th>
                <th className="px-4 py-2 text-white">Location</th>
                <th className="px-4 py-2 text-white">District</th>
                <th className="px-4 py-2 text-white">Phone Number</th>
                <th className="px-4 py-2 text-white">Serial Number</th>
              </tr>
            </thead>
            <tbody>
              {filteredLabs.map(lab => (
                <tr
                  key={lab.id}
                  className="h-12 bg-white border-b border-gray-400"
                >
                  <td className="px-4 py-2">{lab["Lab Name"]}</td>
                  <td className="px-4 py-2 text-blue-600 underline">{lab.Location}</td>
                  <td className="px-4 py-2">{lab.District}</td>
                  <td className="px-4 py-2">{lab["Phone Number"]}</td>
                  <td className="px-4 py-2">{lab["Serial Number"]}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default PHCLabData;
