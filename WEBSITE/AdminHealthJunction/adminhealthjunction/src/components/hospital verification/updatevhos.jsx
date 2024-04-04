import React, { useState, useEffect } from 'react';
import { useParams, useHistory } from 'react-router-dom';
import { doc, getDoc, updateDoc } from 'firebase/firestore';
import { database } from '../../firebase';
import { FaHospital, FaMapMarkerAlt, FaBuilding, FaCity, FaPhone, FaEnvelope, FaBed, FaPlusCircle, FaTimesCircle } from "react-icons/fa";

const provinces = [
  "Punjab",
  "Sindh",
  "Balochistan",
  "Islamabad Capital Territory",
  "Khyber Pakhtunkhwa",
  "Azad Jammu and Kashmir",
  "Gilgit-Baltistan",
];

const departments = [
    'Emergency Department',
    'Inpatient Wards',
    'Outpatient Clinics',
    'Operating Rooms',
    'Diagnostic Imaging',
    'Laboratory Services',
    'Pharmacy',
    'Intensive Care Units',
    'Maternity And Neonatal Care',
    'Pediatrics Department',
    'Cardiology Department',
    'Neurology Department',
    'Orthopedics Department',
    'ENT Department',
    'Physical Therapy Department',
    'Occupational Therapy Department',
    'Speech Therapy Department',
    'Radiation Oncology Department',
    'Pulmonology Department',
    'Gastroenterology Department',
    'Nephrology Department',
    'Urology Department',
    'Anesthesiology Department',
    'Pathology Department',
    'Biochemistry Department',
    'Community Medicine Department',
    'Psychiatry Department', // Added Psychiatry Department
    'Dermatology Department', // Added Dermatology Department
    'Ophthalmology Department', // Added Ophthalmology Department
    'Oncology Department', // Added Oncology Department
    'Geriatric Department', // Added Geriatric Department
    'Endocrinology Department', // Added Endocrinology Department
    'Hematology Department', // Added Hematology Department
    'Rheumatology Department', // Added Rheumatology Department
    'Allergy and Immunology Department', // Added Allergy and Immunology Department
    'Microbiology Department', // Added Microbiology Department
    'Forensic Medicine Department', // Added Forensic Medicine Department
    'Medical Education Department', // Added Medical Education Department
    'Research and Development Department' // Added Research and Development Department
  ];
  
  // Facilities list remains unchanged
  const facilities = [
    'Emergency Room',
    'Pharmacy',
    'Laboratory',
    'Radiology',
    'Operating Rooms',
    'Intensive Care Unit',
    'Maternity Ward',
    'Pediatric Ward',
    'Cafeteria',
    'Parking',
    'Ambulance Service',
    'Gardens/Green Spaces',
    'Fitness Center',
    'Wi-Fi Access',
    'Wheelchair Accessibility',
    'Interpreter Services',
    'Family Accommodation',
    'Counseling Services',
    'Concierge Services',
    'Dining Services',
    'Spiritual Care Services',
    'Medical Library',
    'ATM/Banking Services',
    'Gift Shop'
  ];
  
  // Services list remains unchanged
  const services = [
    'Emergency Services',
    'Outpatient Services',
    'Inpatient Services',
    'Surgery',
    'Imaging Services',
    'Laboratory Services',
    'Pharmacy Services',
    'Physical Therapy',
    'Occupational Therapy',
    'Speech Therapy',
    'Dietary Services',
    'Social Work Services',
    'Palliative Care Services',
    'Mental Health Services',
    'Cancer Care Services',
    'Diabetes Care Services',
    'Pediatric Services',
    'Geriatric Services',
    'Neonatal Services',
    'Reproductive Health Services',
    'Travel Medicine Services',
    'Vaccination Services',
    'Dental Services',
    'Eye Care Services',
    'Digestive Health Services',
    'Endocrine Services',
    'Skin Disorder Services',
    'Respiratory Services',
    'Wound Care Services',
    'Rehabilitation Services',
    'Genetic Counseling Services',
    'Nutrition Counseling Services',
    'Stress Management Counseling Services',
    'Occupational Health Services',
    'Employee Assistance Programs',
    'Language Translation Services',
    'Legal Aid Services',
    'Financial Counseling Services'
  ];
  

const VerifiedHospitalUpdateForm = () => {
  const { id } = useParams();
  const history = useHistory();

  const [formData, setFormData] = useState({
    hospitalName: "",
    address: "",
    province: "",
    city: "",
    zipCode: "",
    contactNumber: "",
    email: "",
    numberOfDepartments: "",
    departments: [],
    wards: "",
    additionalInfo: "",
    facilities: [],
    services: [],
    visitingHours: [],
    insuranceAccepted: "Yes",
    sector: "Public",
    zakat: "Yes"
  });

  useEffect(() => {
    const fetchHospitalData = async () => {
      try {
        const docRef = doc(database, 'VerifiedHospitalData', id);
        const docSnap = await getDoc(docRef);

        if (docSnap.exists()) {
          setFormData(docSnap.data());
        } else {
          console.log("No such document exists!");
        }
      } catch (error) {
        console.error("Error fetching document:", error);
      }
    };

    fetchHospitalData();
  }, [id]);

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    if (name === 'visitingHours') {
      const hours = [...formData.visitingHours];
      const index = parseInt(e.target.getAttribute('data-index'));
      const field = e.target.getAttribute('data-field');
      hours[index][field] = value;
      setFormData(prevState => ({ ...prevState, visitingHours: hours }));
    } else {
      setFormData(prevState => ({
        ...prevState,
        [name]: type === 'checkbox' ? (checked ? [...prevState[name], value] : prevState[name].filter(item => item !== value)) : value
      }));
    }
  };

  const handleAddVisitingHours = () => {
    setFormData(prevState => ({
      ...prevState,
      visitingHours: [...prevState.visitingHours, { start: "", end: "" }]
    }));
  };

  const handleRemoveVisitingHours = (index) => {
    const hours = [...formData.visitingHours];
    hours.splice(index, 1);
    setFormData(prevState => ({ ...prevState, visitingHours: hours }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const docRef = doc(database, 'HospitalData', id);
      await updateDoc(docRef, formData);
      alert("Hospital data successfully updated!");
      history.push("/hospitalcrud");
    } catch (error) {
      console.error("Error updating document:", error);
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-blue-200">
      <div className="w-full max-w-screen-md p-6 my-10 bg-white rounded-md shadow-md">
        <h2 className="mb-6 text-4xl font-bold text-blue-800">
          <FaHospital className="inline-block mr-2" />
         Insert Hospital 
        </h2>
        <form onSubmit={handleSubmit} className="grid grid-cols-1 gap-6 md:grid-cols-2">

          {/* Hospital Information Section */}
          <div>
            <h3 className="mb-2 text-2xl font-semibold">Update Hospital</h3>
            <div className="grid grid-cols-1 gap-4">
              <div className="relative">
                <FaHospital className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="text"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Hospital Name"
                  name="hospitalName"
                  value={formData.hospitalName}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="relative">
                <FaMapMarkerAlt className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="text"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Address"
                  name="address"
                  value={formData.address}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="relative">
                <FaBuilding className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <select
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  name="province"
                  value={formData.province}
                  onChange={handleChange}
                  required
                >
                  <option value="" disabled>Select Province</option>
                  {provinces.map((province, index) => (
                    <option key={index} value={province}>{province}</option>
                  ))}
                </select>
              </div>
              <div className="relative">
                <FaCity className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="text"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter City"
                  name="city"
                  value={formData.city}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="relative">
                <FaBed className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="number"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Zip Code"
                  name="zipCode"
                  value={formData.zipCode}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="relative">
                <FaPhone className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="tel"
                  pattern="^(\+92|0)\d{10}$"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Contact Number"
                  name="contactNumber"
                  value={formData.contactNumber}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="relative">
                <FaEnvelope className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="email"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="relative">
                <FaBed className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="number"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Number of Wards"
                  name="wards"
                  value={formData.wards}
                  onChange={handleChange}
                  required
                />
              </div>
                {/* Facilities */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Facilities</label>
            {facilities.map((facility, index) => (
              <div key={index} className="flex items-center">
                <input
                  type="checkbox"
                  name="facilities"
                  id={facility}
                  value={facility}
                  checked={formData.facilities.includes(facility)}
                  onChange={handleChange}
                  className="mr-2 appearance-none focus:ring-2 focus:ring-blue-500"
                />
                <label htmlFor={facility}>{facility}</label>
              </div>
            ))}
          </div>

          {/* Services */}
          <div className="mb-6">
            <label className="block mb-1 text-gray-600">Services</label>
            {services.map((service, index) => (
              <div key={index} className="flex items-center">
                <input
                  type="checkbox"
                  name="services"
                  id={service}
                  value={service}
                  checked={formData.services.includes(service)}
                  onChange={handleChange}
                 
                  className="mr-2 appearance-none focus:ring-2 focus:ring-blue-500"
                />
                <label htmlFor={service}>{service}</label>
              </div>
            ))}
          </div>
            </div>
          </div>

          {/* Additional Information Section */}
          <div>
            <h3 className="mb-2 text-2xl font-semibold">Additional Information</h3>
            <div className="grid grid-cols-1 gap-4">
              <div className="relative">
                <FaBed className="absolute transform -translate-y-1/2 left-3 top-1/2" />
                <input
                  type="number"
                  className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter Number of Departments"
                  name="numberOfDepartments"
                  value={formData.numberOfDepartments}
                  onChange={handleChange}
                  required
                />
              </div>
              <div>
                <h4 className="mb-2 text-lg font-semibold">Departments</h4>
                {departments.map((dept, index) => (
                  <div key={index} className="flex items-center">
                    <input
                      type="checkbox"
                      name="departments"
                      id={dept}
                      value={dept}
                      checked={formData.departments.includes(dept)}
                      onChange={handleChange}
                      className="mr-2 appearance-none focus:ring-2 focus:ring-blue-500"
                    />
                    <label htmlFor={dept}>{dept}</label>
                  </div>
                ))}
              </div>
              <div className="relative">
                
                {formData.visitingHours.map((hour, index) => (
                  <div key={index} className="flex items-center">
                    <input
                      type="time"
                      className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                      placeholder="Start Time"
                      name="visitingHours"
                      data-index={index}
                      data-field="start"
                      value={hour.start}
                      onChange={handleChange}
                      required
                    />
                    <input
                      type="time"
                      className="w-full py-2 pl-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                      placeholder="End Time"
                      name="visitingHours"
                      data-index={index}
                      data-field="end"
                      value={hour.end}
                      onChange={handleChange}
                      required
                    />
                    {index > 0 && (
                      <FaTimesCircle
                        className="ml-2 text-red-500 cursor-pointer"
                        onClick={() => handleRemoveVisitingHours(index)}
                      />
                    )}
                  </div>
                ))}
                <div className="flex items-center">
                  <FaPlusCircle
                    className="text-blue-500 cursor-pointer"
                    onClick={handleAddVisitingHours}
                  />
                  <span className="ml-2">Add Visiting Hours</span>
                </div>
              </div>
              <div className="relative">
                <label className="block mb-1 text-gray-600">Insurance Accepted</label>
                <select
                  className="w-full py-2 pl-2 pr-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  name="insuranceAccepted"
                  value={formData.insuranceAccepted}
                  onChange={handleChange}
                  required
                >
                  <option value="Yes">Yes</option>
                  <option value="No">No</option>
                </select>
              </div>
              <div className="relative">
                <label className="block mb-1 text-gray-600">Sector</label>
                <select
                  className="w-full py-2 pl-2 pr-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  name="sector"
                  value={formData.sector}
                  onChange={handleChange}
                  required
                >
                  <option value="Public">Public</option>
                  <option value="Private">Private</option>
                </select>
              </div>
              <div className="relative">
                <label className="block mb-1 text-gray-600">Treat Patient with Zakat</label>
                <select
                  className="w-full py-2 pl-2 pr-10 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  name="zakat"
                  value={formData.zakat}
                  onChange={handleChange}
                  required
                >
                  <option value="Yes">Yes</option>
                  <option value="No">No</option>
                </select>
              </div>
              <div className="relative">
                <label className="block mb-1 text-gray-600">Additional Information</label>
                <textarea
                  className="w-full h-24 p-2 border rounded-md focus:outline-none focus:ring focus:border-blue-300"
                  placeholder="Enter any additional information here..."
                  name="additionalInfo"
                  value={formData.additionalInfo}
                  onChange={handleChange}
                />
              </div>
            </div>
          </div>

          {/* Submit Button */}
          <div className="col-span-2">
            <button
              type="submit"
              className="w-full py-2 text-xl text-white bg-blue-600 rounded-md hover:bg-blue-700 focus:outline-none focus:ring focus:ring-blue-300"
            >
              Update
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default VerifiedHospitalUpdateForm;
