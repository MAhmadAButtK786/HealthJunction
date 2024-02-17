import React, { useEffect, useState } from "react";
import { collection, getDocs, deleteDoc,doc } from "firebase/firestore";
import { database } from "../../../../../firebase";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit, faSearch, faTrash } from '@fortawesome/free-solid-svg-icons'; // Added faTrash for delete icon
import { Link } from "react-router-dom";

function Allied() {
  const [testsData, setTestsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    getData();
  }, []);

  const getData = async () => {
    try {
      const querySnapshot = await getDocs(collection(database, "Allied Lab"));
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
    test["Test Name"] &&
    typeof test["Test Name"] === 'string' &&
    test["Test Name"].toLowerCase().includes(searchTerm.toLowerCase())
  );
  const handleDelete = (test) => {
    if (window.confirm(`Are you sure you want to delete ${test["Test Name"]}?`)) {
      deleteRecipient(test);
    }
  };
  
  const deleteRecipient = async (test) => {
    try {
      await deleteDoc(doc(database, "Allied Lab", test.id));
  
      // Refresh data after deletion
      getData();
      alert(`${test["Test Name"]} has been deleted successfully.`);
    } catch (error) {
      console.error("Error deleting test: ", error);
    }
  };
  
  
  return (
    <>
      <div className="flex items-center justify-center">
        <img src="images/img/Lab/AlliedLabs.png" alt="" className="mx-auto rounded-full w-52 h-52" />
      </div>
      <div className="px-8">
        <Link to="/alliedinsertpage">
          <button className="px-6 py-2 font-semibold text-white transition duration-300 ease-in-out bg-gray-400 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-opacity-50">
            Insert Test
          </button>
        </Link>
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
                <th className="px-4 py-3 text-xl font-bold">Actions</th> 
                <th className="px-4 py-3 text-xl font-bold">Action</th>{/* Added Actions column */}
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
                  <td className="px-4 py-2 border">
                    <button onClick={() => handleDelete(test)} className="text-red-500 hover:text-red-700">
                      <FontAwesomeIcon icon={faTrash} />
                    </button>
                  </td>
                  <td className="px-4 py-2 border">
                    <Link to ={`/updateAlliedPage/${test.id}`}>
                    <button className="text-green-500 hover:text-green-700">
                      <FontAwesomeIcon icon={faEdit} />
                    </button>
                    </Link>
                  </td>
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
