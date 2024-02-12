import React from 'react'
import { FaHospital, FaInfoCircle, FaFileExcel } from 'react-icons/fa'
import { motion } from 'framer-motion'

const guidelines = [
  "Provide accurate and up-to-date information about your hospital.",
  "Ensure that your hospital meets the required standards for patient care.",
  "Upload necessary documents and certifications for verification.",
  "Maintain a high standard of cleanliness and hygiene within the hospital premises.",
  "Ensure all medical equipment is properly maintained and functional.",
  // Add more guidelines as needed
];

const mandatoryInfo = [
  "Add Hospital Name",
  "Add Hospital Address [Location Should be pinned on Google Maps] ",
  "Add Hospital Contact Information, such as Contact Number and Email Address",
  "Check all the checkboxes related to Facilities in Hospitals",
  "Specify whether the Hospital is Private or Public",
  "Provide the Number of Departments",
  "Provide the Number of Wards",
  "Include the total number of beds available in the hospital",
  "Specify the types of specialized services offered"
];

const excelFile = [
  "You are required to provide an Excel Sheet. The sheet should include basic information about doctors such as their Name, Age, Gender, Level of Degree, Timing, Specialization, Years of Experience, and License Number."
];

function GuidelinesDetails() {
  return (
    <motion.div className="container mx-auto my-8 p-6 bg-white rounded shadow-xl" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 0.5 }}>
      <h1 className="text-4xl font-bold mb-4 text-center text-cyan-600">Hospital Registration Guidelines</h1>
      <div className="mb-4">
        <h2 className="text-2xl font-bold mb-2 text-cyan-600"><FaHospital className="inline-block mr-2"/> General Guidelines</h2>
        <ul className="list-disc pl-6">
          {guidelines.map((guideline, index) => (
            <li key={index} className="mb-2">{guideline}</li>
          ))}
        </ul>
      </div>
      <div className="mb-4">
        <h2 className="text-2xl font-bold mb-2 text-cyan-600"><FaInfoCircle className="inline-block mr-2"/> Mandatory Information</h2>
        <ul className="list-disc pl-6">
          {mandatoryInfo.map((info, index) => (
            <li key={index} className="mb-2">{info}</li>
          ))}
        </ul>
      </div>
      <div>
        <h2 className="text-2xl font-bold mb-2 text-cyan-600"><FaFileExcel className="inline-block mr-2"/> Excel File Requirements</h2>
        <ul className="list-disc pl-6">
          {excelFile.map((info, index) => (
            <li key={index} className="mb-2">{info}</li>
          ))}
        </ul>
      </div>
      <div className="mt-6 p-4 bg-blue-100 rounded text-blue-700">
        <p>Note: All the facilities will be observed by a team of members to ensure compliance with the guidelines.</p>
      </div>
    </motion.div>
  )
}

export default GuidelinesDetails;
