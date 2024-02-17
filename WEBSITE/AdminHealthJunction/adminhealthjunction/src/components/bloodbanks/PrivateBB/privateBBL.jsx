import React, { useEffect, useState } from "react";
import { collection, getDocs, doc, deleteDoc } from "firebase/firestore"
import { database } from "../../../firebase";
import { Link } from 'react-router-dom';

function PrivateBBL() {
  const [testsData, setTestsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");

  useEffect(() => {
    if (database) {
      getData();
    }
  }, []);

  const getData = async () => {
    try {
      const querySnapshot = await getDocs(collection(database, "Private Blood Banks"));
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
  const handleDelete = (pbb) => {
    if (window.confirm(`Are you sure you want to delete ${pbb.Name}?`)) {
      deleteRecipient(pbb);
    }
  };

  const deleteRecipient = async (pbb) => {
    try {
      await deleteDoc(doc(database, "Private Blood Banks", pbb.id));
  
      // Refresh data after deletion
      getData();
      alert(`${pbb.Name} has been deleted successfully.`);
    } catch (error) {
      console.error("Error deleting recipient: ", error);
    }
  };
  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-red-600">Private Blood Banks</h1>
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
          <Link to="/insertsPrivateBB">
            <button className="px-4 py-2 font-bold text-white bg-red-500 rounded hover:bg-red-700 ">
              Insert Private Blood Bank
            </button>
          </Link>
          <table className="w-full mt-5 text-center border border-red-500">
            <thead className="h-10 bg-red-700 border-b border-red-500">
              <tr>
                <th className="px-4 py-2 text-white">Name</th>
                <th className="px-4 py-2 text-white">Address</th>
                <th className="px-4 py-2 text-white">License Number</th>
                <th className="px-4 py-2 text-white">Sector</th>
                <th className="px-4 py-2 text-white">Action</th>
                <th className="px-4 py-2 text-white">Action</th>
              </tr>
            </thead>
            <tbody>
              {filteredTests.map((recipient) => (
                <tr
                  key={recipient.id}
                  className="h-12 bg-white border-b border-gray-400"
                >
                  <td className="px-4 py-2">{recipient.Name}</td>
                  <td className="px-4 py-2 text-blue-600 underline">
                    <a
                      href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
                        recipient.Address
                      )}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {recipient.Address}
                    </a>
                  </td>
                  <td className="px-4 py-2">{recipient["License Number"]}</td>
                  <td className="px-4 py-2">{recipient.Secter}</td>
                  <td className='px-4 py-2'>
                    <button onClick={() => handleDelete(recipient)} className="px-3 py-1 text-white bg-red-500 rounded-md">Delete</button>
                  </td>
                  <td className='px-4 py-2'>
                    <Link to ={`/updatePrivateBBPage/${recipient.id}`}><button className="px-3 py-1 text-white bg-green-500 rounded-md">Update</button></Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default PrivateBBL;
