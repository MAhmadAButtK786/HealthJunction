import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { collection, addDoc } from 'firebase/firestore';
import { database } from '../../firebase';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHospital, faMapMarkerAlt, faBuilding, faCog, faArrowLeft } from '@fortawesome/free-solid-svg-icons';

const PHCInsertPage = () => {
  const history = useHistory();
  const [formData, setFormData] = useState({
    "Hospital Name": '',
    District: '',
    Address: '',
    Sector: ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      // Add the data to Firestore
      await addDoc(collection(database, 'PHC Hospitals'), formData);
      
      // Clear the form
      setFormData({
        "Hospital Name": '',
        District: '',
        Address: '',
        Sector: ''
      });
      
      // Provide feedback to the user (optional)
      alert('Data added successfully!');
      
      // Navigate back to the previous screen
      history.goBack();
    } catch (error) {
      console.error('Error adding document: ', error);
      // Provide feedback to the user (optional)
      alert('Failed to add data!');
    }
  };

  return (
    <div className="container mx-auto mt-10">
      <div className="flex items-center mb-5">
        <button onClick={() => history.goBack()} className="px-3 py-1 mr-2 text-white bg-green-500 rounded-md hover:bg-green-600 focus:outline-none">
          <FontAwesomeIcon icon={faArrowLeft} />
        </button>
        <h1 className="text-3xl font-bold">Insert Hospital Data</h1>
      </div>
      <form onSubmit={handleSubmit} className="max-w-lg mx-auto">
        <div className="mb-4">
          <label htmlFor="hospitalName" className="flex items-center mb-1">
            <FontAwesomeIcon icon={faHospital} className="mr-2" />
            Hospital Name:
          </label>
          <input type="text" id="hospitalName" name="Hospital Name" value={formData["Hospital Name"]} onChange={handleChange} className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:border-green-500" />
        </div>
        <div className="mb-4">
          <label htmlFor="Address" className="flex items-center mb-1">
            <FontAwesomeIcon icon={faMapMarkerAlt} className="mr-2" />
            Address:
          </label>
          <input type="text" id="Address" name="Address" value={formData.Address} onChange={handleChange} className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:border-green-500" />
        </div>
        <div className="mb-4">
          <label htmlFor="District" className="flex items-center mb-1">
            <FontAwesomeIcon icon={faBuilding} className="mr-2" />
            District:
          </label>
          <input type="text" id="District" name="District" value={formData.District} onChange={handleChange} className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:border-green-500" />
        </div>
        <div className="mb-4">
          <label htmlFor="Sector" className="flex items-center mb-1">
            <FontAwesomeIcon icon={faCog} className="mr-2" />
            Sector:
          </label>
          <select id="Sector" name="Sector" value={formData.Sector} onChange={handleChange} className="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring focus:border-green-500">
            <option value="">Select Sector</option>
            <option value="Public">Public</option>
            <option value="Private">Private</option>
          </select>
        </div>
        <div className="text-center">
          <button type="submit" className="w-full px-6 py-3 font-semibold text-white bg-green-500 rounded-lg hover:bg-green-600 focus:outline-none focus:ring focus:border-green-500">Insert</button>
        </div>
      </form>
    </div>
  );
};

export default PHCInsertPage;
