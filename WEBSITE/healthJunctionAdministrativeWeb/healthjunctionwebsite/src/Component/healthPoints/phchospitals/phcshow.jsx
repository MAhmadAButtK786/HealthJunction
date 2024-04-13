import React, { useState, useEffect } from 'react';
import { collection, getDocs } from 'firebase/firestore';
import { database } from '../../firebase';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch } from '@fortawesome/free-solid-svg-icons';

const PHCHospitalsScreen = () => {
  const [hospitals, setHospitals] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');


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

 


  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  const filteredHospitals = hospitals.filter(hospital => {
    const name = (hospital["Hospital Name"] || '').toLowerCase();
    const district = (hospital.District || '').toLowerCase();
    const searchTermLower = searchTerm.toLowerCase();
    return name.includes(searchTermLower) || district.includes(searchTermLower);
  });
  

 

  return (
    <div className="container mx-auto">
      <div className="flex items-center my-4">
        <img src="images/img/Lab/govt.png" alt="PHC Hospitals" className="mr-2 w-55 h-55" />
        <h1 className="text-6xl font-bold text-green-600">PHC Hospitals</h1>
      </div>
      <div className="flex items-center mb-4">
       
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
            
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default PHCHospitalsScreen;
