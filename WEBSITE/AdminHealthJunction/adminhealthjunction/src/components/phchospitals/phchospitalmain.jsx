/* eslint-disable no-unused-vars */
import React, { useState, useEffect } from 'react';
import { database } from '../../firebase'; // Import the database instance from your firebase.js

const PHCHospitalDetails = () => {
  const [hospitals, setHospitals] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const snapshot = await database.collection('PHC Hospitals').get();
        const hospitalData = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        setHospitals(hospitalData);
      } catch (error) {
        console.error('Error fetching hospitals:', error);
      }
    };

    fetchData();
  }, []);

  const handleDelete = async (id) => {
    try {
      await database.collection('PHC Hospitals').doc(id).delete();
      setHospitals(prevHospitals => prevHospitals.filter(hospital => hospital.id !== id));
    } catch (error) {
      console.error('Error deleting hospital:', error);
    }
  };

  const handleUpdate = async (id, newData) => {
    try {
      await database.collection('PHC Hospital').doc(id).update(newData);
      const updatedHospitals = hospitals.map(hospital => {
        if (hospital.id === id) {
          return { ...hospital, ...newData };
        }
        return hospital;
      });
      setHospitals(updatedHospitals);
    } catch (error) {
      console.error('Error updating hospital:', error);
    }
  };

  return (
    <div>
      <h1>Hospital Details</h1>
      <ul>
        {hospitals.map(hospital => (
          <li key={hospital.id}>
            <div>{hospital.HospitalName}</div>
            <div>{hospital.Address}</div>
            <div>{hospital.District}</div>
            <div>{hospital.Sector}</div>
            <button onClick={() => handleDelete(hospital.id)}>Delete</button>
           
          </li>
        ))}
      </ul>
    </div>
  );
};

export default PHCHospitalDetails;
