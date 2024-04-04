import React, { useState, useEffect } from 'react';
import { collection, getDocs, deleteDoc, doc, addDoc } from 'firebase/firestore';
import { database } from '../../firebase';
import { faChevronUp, faCheck, faChevronDown, faMapMarkerAlt, faPhone, faEnvelope, faUser, faBriefcase, faMoneyBillAlt, faRupeeSign, faClipboardCheck, faHome, faIdBadge, faBalanceScale, faClock, faFileAlt, faUsers, faEdit, faTrashAlt } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

const HospitalCRUD = () => {
  const [hospitals, setHospitals] = useState([]);
  const [expandedId, setExpandedId] = useState(null);

  useEffect(() => {
    const fetchHospitals = async () => {
      try {
        const querySnapshot = await getDocs(collection(database, 'HospitalData'));
        const hospitalData = [];
        querySnapshot.forEach(doc => {
          hospitalData.push({ id: doc.id, ...doc.data() });
        });
        setHospitals(hospitalData);
      } catch (error) {
        console.error('Error fetching hospitals:', error);
      }
    };

    fetchHospitals();
  }, []);

  const toggleExpansion = (id) => {
    setExpandedId(id === expandedId ? null : id);
  };

  const handleDelete = async (id) => {
    if (window.confirm("Are you sure you want to delete this hospital?")) {
      try {
        await deleteDoc(doc(database, 'HospitalData', id));
        setHospitals(hospitals.filter(hospital => hospital.id !== id));
        alert('Hospital deleted successfully!');
      } catch (error) {
        console.error('Error deleting hospital:', error);
      }
    }
  };
  const handlePushToNewCollection = async (hospital) => {
    try {
      await addDoc(collection(database, 'VerifiedHospitalData'), hospital);
      alert('Hospital Verified!');
    } catch (error) {
      console.error('Error while Verifying data:', error);
    }
  };
  const handleUpdate = (id) => {
    // Redirect to the update page with the specific ID
    window.location.href = `/updatethospitalPage/${id}`;
  };
  const sortedHospitals = hospitals.sort((a, b) => a.hospitalName.localeCompare(b.hospitalName));

  return (
    <div className="container py-8 mx-auto">
    <div className="flex flex-col items-center justify-center mb-6">
      <img src="images/hopitallogo.png" alt="Hospital Logo" className="w-20 h-auto mb-2 sm:w-32" />
      <h2 className="text-lg font-bold text-center text-teal-600 sm:text-2xl lg:text-4xl">Find Your Perfect Care Haven!</h2>
    </div>

    <button
      className="px-3 py-1 mb-4 font-medium text-white bg-green-500 rounded-full focus:outline-none hover:bg-green-700"
      onClick={() => {
        window.location.href = "/hospitalinsertform";
      }}
    >
      Insert Hospital
    </button>

    <ul className="overflow-hidden border-teal-200 divide-y rounded-lg">
      {sortedHospitals.map(hospital => (
        <li key={hospital.id} className="px-6 py-4 hover:bg-teal-100">
          <div className="flex flex-col items-center justify-between sm:flex-row">
            <div className="flex flex-col space-y-1 sm:flex-row sm:space-y-0 sm:space-x-2">
              <h3 className="text-sm font-semibold text-teal-800 sm:text-lg lg:text-xl">{hospital.hospitalName}</h3>
              <p className="text-xs text-gray-600 sm:text-sm">{hospital.province}, {hospital.city}</p>
            </div>
            <div className="flex flex-wrap mt-2 sm:mt-0">
              <button
                className="flex items-center px-3 py-1 mb-2 mr-2 font-medium text-teal-500 bg-transparent border border-teal-500 rounded-full sm:mb-0 focus:outline-none hover:text-teal-700"
                onClick={() => toggleExpansion(hospital.id)}
              >
                {expandedId === hospital.id ? (
                  <>
                    Hide Details
                    <FontAwesomeIcon icon={faChevronUp} className="w-3 h-3 ml-1" />
                  </>
                ) : (
                  <>
                    Show Details
                    <FontAwesomeIcon icon={faChevronDown} className="w-3 h-3 ml-1" />
                  </>
                )}
              </button>
              <button
                className="flex items-center px-3 py-1 mb-2 mr-2 font-medium text-red-500 bg-transparent border border-red-500 rounded-full sm:mb-0 focus:outline-none hover:text-red-700"
                onClick={() => handleDelete(hospital.id)}
              >
                <FontAwesomeIcon icon={faTrashAlt} className="w-3 h-3 mr-1" />
                Delete
              </button>
              <button
                className="flex items-center px-3 py-1 mb-2 mr-2 font-medium text-green-500 bg-transparent border border-green-500 rounded-full sm:mb-0 focus:outline-none hover:text-green-700"
                onClick={() => handleUpdate(hospital.id)}
              >
                <FontAwesomeIcon icon={faEdit} className="w-3 h-3 mr-1" />
                Update
              </button>
              <button
                className="flex items-center px-3 py-1 mb-2 font-medium text-green-500 bg-transparent border border-green-500 rounded-full sm:mb-0 focus:outline-none hover:text-green-700"
                onClick={() => handlePushToNewCollection(hospital)}
              >
                <FontAwesomeIcon icon={faCheck} className="w-3 h-3 mr-1" />
                Hospital Verification
              </button>
            </div>
          </div>
          {expandedId === hospital.id && (
            <div className="px-6 py-4 pt-4 mt-4 border-t border-teal-200 rounded-lg">
                <p><FontAwesomeIcon icon={faMapMarkerAlt} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Address: {hospital.address}</p>
                <p><FontAwesomeIcon icon={faUser} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Province: {hospital.province}</p>
                <p><FontAwesomeIcon icon={faHome} className="inline-block w-3 h-3 mr-2 text-teal-800" /> City: {hospital.city}</p>
                <p><FontAwesomeIcon icon={faIdBadge} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Zip Code: {hospital.zipCode}</p>
                <p><FontAwesomeIcon icon={faPhone} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Contact Number: {hospital.contactNumber}</p>
                <p><FontAwesomeIcon icon={faEnvelope} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Email: {hospital.email}</p>
                <p><FontAwesomeIcon icon={faClipboardCheck} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Number of Departments: {hospital.numberOfDepartments}</p>
                <div className="mt-2">
                  <FontAwesomeIcon icon={faBriefcase} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Departments:
                  <ul className="pl-4 list-disc list-inside">
                    {hospital.departments.map((dept, index) => (
                      <li key={index}>{dept}</li>
                    ))}
                  </ul>
                </div>
                <p><FontAwesomeIcon icon={faBalanceScale} className="inline-block w-3 h-3 mr-2 text-teal-800" /> Number of Wards: {hospital.numberOfWards}</p>
                <p>
                  <FontAwesomeIcon icon={faFileAlt} className="inline-block w-3 h-3 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Additional Information:</span>{' '}
                  {hospital.additionalInfo}
                </p>

                {/* Adorable Accordion for Facilities and Services */}
                <details className="mb-4">
                  <summary className="flex items-center font-semibold text-teal-800 cursor-pointer hover:text-teal-700">
                    <FontAwesomeIcon icon={faUsers} className="inline-block w-3 h-3 mr-2" />
                    Facilities
                  </summary>
                  <ul className="pl-4 list-disc list-inside">
                    {hospital.facilities.map((facility, index) => (
                      <li key={index}>{facility}</li>
                    ))}
                  </ul>
                </details>
                <details className="">
                  <summary className="flex items-center font-semibold text-teal-800 cursor-pointer hover:text-teal-700">
                    <FontAwesomeIcon icon={faClock} className="inline-block w-3 h-3 mr-2" />
                    Services
                  </summary>
                  <ul className="pl-4 list-disc list-inside">
                    {hospital.services.map((service, index) => (
                      <li key={index}>{service}</li>
                    ))}
                  </ul>
                </details>

                {/* Visiting Hours with Cute Clock Icon */}
                <div className="mt-2">

                  <p className="font-semibold text-teal-800">
                    <FontAwesomeIcon icon={faClock} className="inline-block w-3 h-3 mr-2 text-teal-800" />
                    Visiting Hours:</p>
                  <ul className="pl-4 list-disc list-inside">
                    {hospital.visitingHours.map((hour, index) => (
                      <li key={index}>{hour.start} - {hour.end}</li>
                    ))}
                  </ul>
                </div>
                <p>
                  <FontAwesomeIcon icon={faMoneyBillAlt} className="inline-block w-3 h-3 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Insurance Accepted:</span>{' '}
                  {hospital.insuranceAccepted}
                </p>
                <p>
                  <FontAwesomeIcon icon={faBalanceScale} className="inline-block w-3 h-3 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Sector:</span>{' '}
                  {hospital.sector}
                </p>
                <p>
                  <FontAwesomeIcon icon={faRupeeSign} className="inline-block w-3 h-3 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Treat Patient with Zakat:</span>{' '}
                  {hospital.zakat}
                </p>
              </div>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default HospitalCRUD;
