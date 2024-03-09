import React, { useEffect, useState } from "react";
import { collection, getDocs, doc, deleteDoc } from "firebase/firestore";
import { database } from "../../../../firebase";
import { Link } from 'react-router-dom';
import { FaTrash, FaEdit } from 'react-icons/fa';

function PHCLab() {
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

  const handleDelete = lab => {
    if (window.confirm(`Are you sure you want to delete ${lab["Lab Name"]}?`)) {
      deleteLab(lab);
    }
  };

  const deleteLab = async lab => {
    try {
      await deleteDoc(doc(database, "Punjab Register Lab", lab.id));

      // Refresh data after deletion
      getData();
      alert(`${lab["Lab Name"]} has been deleted successfully.`);
    } catch (error) {
      console.error("Error deleting lab: ", error);
    }
  };

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-red-600">Punjab Register Labs</h1>
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
            <thead className="h-10 bg-red-700 border-b border-red-500">
              <tr>
                <th className="px-4 py-2 text-white">Lab Name</th>
                <th className="px-4 py-2 text-white">Location</th>
                <th className="px-4 py-2 text-white">District</th>
                <th className="px-4 py-2 text-white">Phone Number</th>
                <th className="px-4 py-2 text-white">Serial Number</th>
                <th className="px-4 py-2 text-white">Action</th>
                <th className="px-4 py-2 text-white">Action</th>
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
                  <td className='px-4 py-2'> <FaTrash onClick={() => handleDelete(lab)} className="text-red-500 cursor-pointer" /></td>
                  <td className='px-4 py-2'>
                    <Link to={`/updateLabPage/${lab.id}`}><FaEdit className="text-green-500 cursor-pointer" /></Link>
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

export default PHCLab;
