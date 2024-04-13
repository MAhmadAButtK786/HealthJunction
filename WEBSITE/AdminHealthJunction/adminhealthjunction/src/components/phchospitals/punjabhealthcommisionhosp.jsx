import React, { useState, useEffect } from 'react';
import { collection, getDocs, deleteDoc,doc } from 'firebase/firestore';
import { database } from '../../firebase';
import { Link, useHistory } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrashAlt, faEdit, faSearch } from '@fortawesome/free-solid-svg-icons';

const PHCHospitalsScreen = () => {
  const [hospitals, setHospitals] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const history = useHistory();

  useEffect(() => {
    const fetchHospitals = async () => {
      try {
        const querySnapshot = await getDocs(collection(database, 'PHC Hospitals'));
        const hospitalData = querySnapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }));
        setHospitals(hospitalData);
      } catch (error) {
        console.error('Error fetching hospitals:', error);
      }
    };

    fetchHospitals();
  }, []);

  const handleDelete = async (id) => {
    if (window.confirm("Are you sure you want to delete this hospital?")) {
      try {
        await deleteDoc(doc(database, 'PHC Hospitals', id));
        setHospitals(hospitals.filter(hospital => hospital.id !== id));
        alert('Hospital deleted successfully!');
      } catch (error) {
        console.error('Error deleting hospital:', error);
      }
    }
  };

  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  const filteredHospitals = hospitals.filter(hospital => {
    const name = (hospital["Hospital Name"] || '').toLowerCase();
    const district = (hospital.District || '').toLowerCase();
    const searchTermLower = searchTerm.toLowerCase();
    return name.includes(searchTermLower) || district.includes(searchTermLower);
  });
  

  const handleUpdate = (id) => {
    history.push(`/updatePHCHospital/${id}`);
  };

  return (
    <div className="container mx-auto">
      <div className="flex items-center my-4">
        <img src="images/img/Lab/govt.png" alt="PHC Hospitals" className="mr-2 w-55 h-55" />
        <h1 className="text-6xl font-bold text-green-600">PHC Hospitals</h1>
      </div>
      <div className="flex items-center mb-4">
        <Link to="/phcinsert" className="px-4 py-2 mr-4 text-white bg-green-500 rounded hover:bg-green-600">
          Insert Hospital
        </Link>
        <div className="relative">
          <input
            type="text"
            placeholder="Search by name or district"
            value={searchTerm}
            onChange={handleSearch}
            className="px-4 py-2 pl-10 border border-gray-300 rounded"
          />
          <FontAwesomeIcon icon={faSearch} className="absolute text-gray-500 top-3 left-3" />
        </div>
      </div>
      <table className="w-full border border-collapse border-gray-300">
        <thead>
          <tr className="bg-green-200">
            <th className="px-4 py-2">Name</th>
            <th className="px-4 py-2">Address</th>
            <th className="px-4 py-2">District</th>
            <th className="px-4 py-2">Sector</th>
            <th className="px-4 py-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {filteredHospitals.map(hospital => (
            <tr key={hospital.id}>
              <td className="px-4 py-2">{hospital["Hospital Name"]}</td>
              <td className="px-4 py-2">
                <a href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(hospital.Address)}`} target="_blank" rel="noopener noreferrer">
                  {hospital.Address}
                </a>
              </td>
              <td className="px-4 py-2">{hospital.District}</td>
              <td className="px-4 py-2">{hospital.Sector}</td>
              <td className="px-4 py-2">
                <button onClick={() => handleDelete(hospital.id)} className="mr-2 text-red-600 hover:text-red-800">
                  <FontAwesomeIcon icon={faTrashAlt} />
                </button>
                <button onClick={() => handleUpdate(hospital.id)} className="text-blue-600 hover:text-blue-800">
                  <FontAwesomeIcon icon={faEdit} />
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default PHCHospitalsScreen;
