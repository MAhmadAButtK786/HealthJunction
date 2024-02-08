import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../../../../../firebase";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch } from '@fortawesome/free-solid-svg-icons';

function Allied() {
  const [testsData, setTestsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    getData();
  }, []);

  const getData = async () => {
    try {
      const querySnapshot = await getDocs(collection(database, "Allied Lab"));
      const data = querySnapshot.docs.map((doc) => doc.data());
      setTestsData(data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  const filteredTests = testsData.filter((test) =>
    test["Test Name"] &&
    typeof test["Test Name"] === 'string' &&
    test["Test Name"].toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <>
      <div className="flex items-center justify-center">
        <img src="images/img/Lab/AlliedLabs.png" alt="" className="mx-auto rounded-full w-52 h-52" />
        
      </div>

      <div className="w-full px-4 pt-2 pb-5 mx-auto">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center space-x-2">
            <FontAwesomeIcon icon={faSearch} className="w-6 h-6 text-gray-500" />
            <input
              type="text"
              placeholder="Search tests..."
              onChange={handleSearch}
              className="p-2 border border-gray-300 rounded-md focus:outline-none focus:border-blue-500"
            />
          </div>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full table-auto">
            <thead>
              <tr>
              <th className="px-4 py-3 text-xl font-bold">Test Name</th>
                <th className="px-4 py-3 text-xl font-bold">Code</th>
                <th className="px-4 py-3 text-xl font-bold">Price</th>
                <th className="px-4 py-3 text-xl font-bold">Reporting Time</th>
                <th className="px-4 py-3 text-xl font-bold">Sample Required</th>
               
              </tr>
            </thead>
            <tbody>
              {filteredTests.map((test, index) => (
                <tr key={index} className={`${index % 2 === 0 ? 'bg-gray-100' : 'bg-white'}`}>
                   <td className="px-4 py-2 border">{test["Test Name"]}</td>
                  <td className="px-4 py-2 border">{test["Code"]}</td>
                  <td className="px-4 py-2 border">{test["Price"]}</td>
                  <td className="px-4 py-2 border">{test["Reporting Time"]}</td>
                  <td className="px-4 py-2 border">{test["Sample Required"]}</td>
                 
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
}

export default Allied;
