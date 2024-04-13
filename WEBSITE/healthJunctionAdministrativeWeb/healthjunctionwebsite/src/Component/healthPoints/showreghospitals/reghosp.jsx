import React, { useState, useEffect } from 'react';
import { collection, getDocs } from 'firebase/firestore';
import { database } from '../../firebase';
import { faChevronUp, faChevronDown, faMapMarkerAlt, faPhone, faEnvelope, faUser, faBriefcase, faMoneyBillAlt, faRupeeSign, faClipboardCheck, faHome, faIdBadge, faBalanceScale, faClock, faFileAlt, faUsers } from '@fortawesome/free-solid-svg-icons'; // Importing necessary icons from FontAwesome
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'; // Importing FontAwesomeIcon component

const HospitalList = () => {
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

  const sortedHospitals = hospitals.sort((a, b) => a.hospitalName.localeCompare(b.hospitalName));

  return (
    <div className="container py-8 mx-auto">
      {/* Adorable and Eye-Catching Header */}
      <div className="flex items-center justify-center mb-6">
        <img
          src="images/hopitallogo.png" 
          alt="Adorable Hospital Logo"
          className="h-auto mr-2 w-34"
        />
      <h2 className="text-2xl font-bold text-center text-teal-600 sm:text-xl md:text-3xl">
  Find Your Perfect Care Haven!
</h2>

      </div>

      {/* Adorable Hospital List with Soft Colors and Rounded Elements */}
      <ul className="overflow-hidden border-teal-200 divide-y rounded-lg">
        {sortedHospitals.map(hospital => (
          <li key={hospital.id} className="px-6 py-4 hover:bg-teal-100">
            <div className="flex items-center justify-between">
              <div className="flex flex-col space-y-1">
                <h3 className="text-xl font-semibold text-teal-800">
                  {hospital.hospitalName}
                </h3>
                <p className="text-sm text-gray-600">
                  {hospital.province}, {hospital.city}
                </p>
              </div>
              <button
                className="flex items-center px-4 py-2 font-medium text-teal-500 bg-transparent border border-teal-500 rounded-full focus:outline-none hover:text-teal-700" // Adorable button style
                onClick={() => toggleExpansion(hospital.id)}
              >
                {expandedId === hospital.id ? (
                  <>
                    Hide Details
                    <FontAwesomeIcon icon={faChevronUp} className="w-5 h-5 ml-1" /> {/* FontAwesome Chevron Up icon */}
                  </>
                ) : (
                  <>
                    Show Details
                    <FontAwesomeIcon icon={faChevronDown} className="w-5 h-5 ml-1" /> {/* FontAwesome Chevron Down icon */}
                  </>
                )}
              </button>
            </div>
            {expandedId === hospital.id && (
              <div className="px-6 py-4 pt-4 mt-4 border-t border-teal-200 rounded-lg">
                {/* Hospital Details with Clear Labels and Spacing */}
                <p>
                  <FontAwesomeIcon icon={faMapMarkerAlt} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Address:</span>{' '}
                  {hospital.address}
                </p>
                <p>
                  <FontAwesomeIcon icon={faUser} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Province:</span>{' '}
                  {hospital.province}
                </p>
                <p>
                  <FontAwesomeIcon icon={faHome} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">City:</span>{' '}
                  {hospital.city}
                </p>
                <p>
                  <FontAwesomeIcon icon={faIdBadge} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Zip Code:</span>{' '}
                  {hospital.zipCode}
                </p>
                <p>
                  <FontAwesomeIcon icon={faPhone} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Contact Number:</span>{' '}
                  {hospital.contactNumber}
                </p>
                <p>
                  <FontAwesomeIcon icon={faEnvelope} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Email:</span>{' '}
                  {hospital.email}
                </p>
                
                <p>
                  <FontAwesomeIcon icon={faClipboardCheck} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Number of Departments:</span>{' '}
                  {hospital.numberOfDepartments}
                </p>
                <div className="mt-2">
                  <FontAwesomeIcon icon={faBriefcase} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <p className="font-semibold text-teal-800">Departments:</p>
                  <ul className="pl-4 list-disc list-inside">
                    {hospital.departments.map((dept, index) => (
                      <li key={index}>{dept}</li>
                    ))}
                  </ul>
                </div>
                <p>
                  <FontAwesomeIcon icon={faBalanceScale} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Number of Wards:</span>{' '}
                  {hospital.wards}
                </p>
                <p>
                  <FontAwesomeIcon icon={faFileAlt} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Additional Information:</span>{' '}
                  {hospital.additionalInfo}
                </p>

                {/* Adorable Accordion for Facilities and Services */}
                <details className="mb-4">
                  <summary className="flex items-center font-semibold text-teal-800 cursor-pointer hover:text-teal-700">
                    <FontAwesomeIcon icon={faUsers} className="inline-block w-5 h-5 mr-2" />
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
                    <FontAwesomeIcon icon={faClock} className="inline-block w-5 h-5 mr-2" />
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
                  <FontAwesomeIcon icon={faClock} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <p className="font-semibold text-teal-800">Visiting Hours:</p>
                  <ul className="pl-4 list-disc list-inside">
                    {hospital.visitingHours.map((hour, index) => (
                      <li key={index}>{hour.start} - {hour.end}</li>
                    ))}
                  </ul>
                </div>
                <p>
                  <FontAwesomeIcon icon={faMoneyBillAlt} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Insurance Accepted:</span>{' '}
                  {hospital.insuranceAccepted}
                </p>
                <p>
                  <FontAwesomeIcon icon={faBalanceScale} className="inline-block w-5 h-5 mr-2 text-teal-800" />
                  <span className="font-semibold text-teal-800">Sector:</span>{' '}
                  {hospital.sector}
                </p>
                <p>
                  <FontAwesomeIcon icon={faRupeeSign} className="inline-block w-5 h-5 mr-2 text-teal-800" />
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

export default HospitalList;
