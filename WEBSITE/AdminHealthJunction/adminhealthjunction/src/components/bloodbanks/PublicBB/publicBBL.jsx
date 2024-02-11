import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../../../firebase";
import {Link} from 'react-router-dom'
function PublicBBL() {
  const [testsData, setTestsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    if (database) {
      getData();
    }
  }, []);

  const getData = async () => {
    try {
      const querySnapshot = await getDocs(collection(database, "Public Blood Banks"));
      const data = querySnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
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
          <h1 className="text-5xl font-bold text-red-600">Public Blood Banks</h1>
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
          <Link to="/insertsPublicBB">
          <button className="px-4 py-2 font-bold text-white bg-red-500 rounded hover:bg-red-700 ">
            Insert Public Blood Bank
          </button>
        </Link>
          <table className="w-full mt-5 text-center border border-red-500">
            <thead className="h-10 bg-red-700 border-b border-red-500">
              <tr>
                <th className="px-4 py-2 text-white">Name</th>
                <th className="px-4 py-2 text-white">Address</th>
                <th className="px-4 py-2 text-white">License Number</th>
                <th className="px-4 py-2 text-white">Sector</th>
              </tr>
            </thead>
            <tbody>
              {filteredTests.map((donor) => (
                <tr
                  key={donor.id}
                  className="h-12 bg-white border-b border-gray-400"
                >
                  <td className="px-4 py-2">{donor.Name}</td>
                  <td className="px-4 py-2 text-blue-600 underline">
                    <a
                      href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
                        donor.Address
                      )}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {donor.Address}
                    </a>
                  </td>
                  <td className="px-4 py-2">{donor["License Number"]}</td>
                  <td className="px-4 py-2">{donor.Secter}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default PublicBBL;
