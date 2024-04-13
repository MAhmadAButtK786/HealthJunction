import React, { useState, useEffect } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { doc, getDoc, updateDoc } from 'firebase/firestore';
import { database } from '../../firebase';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHospital, faMapMarkerAlt, faBuilding, faCog, faArrowLeft, faSave } from '@fortawesome/free-solid-svg-icons';

const PHCUpdatePage = () => {
  const history = useHistory();
  const { id } = useParams();
  const [formData, setFormData] = useState({
    "Hospital Name": '',
    District: '',
    Address: '',
    Sector: ''
  });

  useEffect(() => {
    const fetchData = async () => {
      try {
        const docRef = doc(database, 'PHC Hospitals', id);
        const docSnap = await getDoc(docRef);
        if (docSnap.exists()) {
          setFormData(docSnap.data());
        } else {
          console.log('No such document!');
        }
      } catch (error) {
        console.error('Error fetching document: ', error);
      }
    };
    fetchData();
  }, [id]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    try {
      // Update the data in Firestore
      const docRef = doc(database, 'PHC Hospitals', id);
      await updateDoc(docRef, formData);
      
      // Provide feedback to the user (optional)
      alert('Data updated successfully!');
      
      // Navigate back to the previous screen
      history.goBack();
    } catch (error) {
      console.error('Error updating document: ', error);
      // Provide feedback to the user (optional)
      alert('Failed to update data!');
    }
  };

  return (
    <div className="container mx-auto mt-10">
      <div className="flex items-center mb-5">
        <button onClick={() => history.goBack()} className="px-3 py-1 mr-2 text-white bg-green-500 rounded-md hover:bg-green-600 focus:outline-none">
          <FontAwesomeIcon icon={faArrowLeft} />
        </button>
        <h1 className="text-3xl font-bold">Update Hospital Data</h1>
      </div>
      <form onSubmit={handleUpdate} className="max-w-lg mx-auto">
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
          <button type="submit" className="w-full px-6 py-3 font-semibold text-white bg-green-500 rounded-lg hover:bg-green-600 focus:outline-none focus:ring focus:border-green-500">
            <FontAwesomeIcon icon={faSave} className="mr-2" />
            Update
          </button>
        </div>
      </form>
    </div>
  );
};

export default PHCUpdatePage;
