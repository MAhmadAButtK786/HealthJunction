import React, { useState, useEffect } from 'react';
import { collection, getDocs, deleteDoc, doc } from 'firebase/firestore';
import { database } from '../../firebase';
import { faChevronUp, faChevronDown, faPhone, faEnvelope, faUser, faClipboardCheck, faBalanceScale, faClock, faFileAlt, faUsers, faEdit, faTrashAlt } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

const DoctorCRUD = () => {
  const [doctors, setDoctors] = useState([]);
  const [expandedId, setExpandedId] = useState(null);

  useEffect(() => {
    const fetchDoctors = async () => {
      try {
        const querySnapshot = await getDocs(collection(database, 'doctors'));
        const doctorData = [];
        querySnapshot.forEach(doc => {
          doctorData.push({ id: doc.id, ...doc.data() });
        });
        setDoctors(doctorData);
      } catch (error) {
        console.error('Error fetching doctors:', error);
      }
    };

    fetchDoctors();
  }, []);

  const toggleExpansion = (id) => {
    setExpandedId(id === expandedId ? null : id);
  };

  const handleDelete = async (id) => {
    if (window.confirm("Are you sure you want to delete this doctor?")) {
      try {
        await deleteDoc(doc(database, 'doctors', id));
        setDoctors(doctors.filter(doctor => doctor.id !== id));
        alert('Doctor deleted successfully!');
      } catch (error) {
        console.error('Error deleting doctor:', error);
      }
    }
  };

  const sortedDoctors = doctors.sort((a, b) => {
    const fullNameA = a.fullName || '';
    const fullNameB = b.fullName || '';
    return fullNameA.localeCompare(fullNameB);
  });

  return (
    <div className="container py-8 mx-auto">
      <h2 className="text-4xl font-bold text-center text-teal-600">Doctors List</h2>

      <ul className="overflow-hidden border-teal-200 divide-y rounded-lg">
        {sortedDoctors.map(doctor => (
          <li key={doctor.id} className="px-6 py-4 hover:bg-teal-100">
            <div className="flex items-center justify-between">
              <div className="flex flex-col space-y-1">
                <h3 className="text-xl font-semibold text-teal-800">{doctor.fullName}</h3>
                <p className="text-sm text-gray-600">{doctor.specialty}</p>
              </div>
              <div className="flex">
                <button
                  className="flex items-center px-4 py-2 mr-2 font-medium text-teal-500 bg-transparent border border-teal-500 rounded-full focus:outline-none hover:text-teal-700"
                  onClick={() => toggleExpansion(doctor.id)}
                >
                  {expandedId === doctor.id ? (
                    <>
                      Hide Details
                      <FontAwesomeIcon icon={faChevronUp} className="w-5 h-5 ml-1" />
                    </>
                  ) : (
                    <>
                      Show Details
                      <FontAwesomeIcon icon={faChevronDown} className="w-5 h-5 ml-1" />
                    </>
                  )}
                </button>
                <button
                  className="flex items-center px-4 py-2 mr-2 font-medium text-red-500 bg-transparent border border-red-500 rounded-full focus:outline-none hover:text-red-700"
                  onClick={() => handleDelete(doctor.id)}
                >
                  <FontAwesomeIcon icon={faTrashAlt} className="w-5 h-5 mr-1" />
                  Delete
                </button>
                <button
                  className="flex items-center px-4 py-2 font-medium text-green-500 bg-transparent border border-green-500 rounded-full focus:outline-none hover:text-green-700"
                  //onClick={() => handleUpdate(doctor.id)} 
                >
                  <FontAwesomeIcon icon={faEdit} className="w-5 h-5 mr-1" />
                  Update
                </button>
              </div>
            </div>
            {expandedId === doctor.id && (
              <div className="px-6 py-4 pt-4 mt-4 border-t border-teal-200 rounded-lg">
                {/* Doctor details */}
                <p><FontAwesomeIcon icon={faEnvelope} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Email: {doctor.email}</p>
                <p><FontAwesomeIcon icon={faPhone} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Phone Number: {doctor.phoneNumber}</p>
                <p><FontAwesomeIcon icon={faFileAlt} className="inline-block w-5 h-5 mr-2 text-teal-800" /> License Number: {doctor.licenseNumber}</p>
                <p><FontAwesomeIcon icon={faUser} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Gender: {doctor.gender}</p>
                <p><FontAwesomeIcon icon={faBalanceScale} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Experience: {doctor.experience} years</p>
                <p><FontAwesomeIcon icon={faClock} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Working Hours: {doctor.workingHours}</p>
                <p><FontAwesomeIcon icon={faUsers} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Specialty: {doctor.specialty}</p>
                <p><FontAwesomeIcon icon={faClipboardCheck} className="inline-block w-5 h-5 mr-2 text-teal-800" /> Available Days:</p>
                {doctor.availableDays && (
  <ul>
    <li>Monday: {doctor.availableDays[0] ? 'Available' : 'Not Available'}</li>
    <li>Tuesday: {doctor.availableDays[1] ? 'Available' : 'Not Available'}</li>
    <li>Wednesday: {doctor.availableDays[2] ? 'Available' : 'Not Available'}</li>
    <li>Thursday: {doctor.availableDays[3] ? 'Available' : 'Not Available'}</li>
    <li>Friday: {doctor.availableDays[4] ? 'Available' : 'Not Available'}</li>
    <li>Saturday: {doctor.availableDays[5] ? 'Available' : 'Not Available'}</li>
    <li>Sunday: {doctor.availableDays[6] ? 'Available' : 'Not Available'}</li>
  </ul>
)}
              </div>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default DoctorCRUD;
