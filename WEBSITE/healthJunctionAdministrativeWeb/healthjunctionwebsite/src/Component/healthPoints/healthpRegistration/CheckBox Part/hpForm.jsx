import React, { useState, useEffect } from 'react';
import { collection, addDoc, getDocs } from 'firebase/firestore';
import { database } from '../../../firebase';
import { useHistory } from 'react-router-dom';

const departments = [
  'Emergency Department',
  'Inpatient Wards',
  'Outpatient Clinics',
  'Operating Rooms',
  'Diagnostic Imaging',
  'Laboratory Services',
  'Pharmacy',
  'Intensive Care Units',
  'Rehabilitation Services',
  'Maternity And Neonatal Care',
  'Hospital Administration',
  'Patient Registration',
  'Cafeteria And Nutrition Services',
  'Medical Records Department',
  'Infection Control And Sterilization',
  'Biohazard Waste Management',
  'Information Technology',
  'Security And Safety Services',
  'Education And Training Facilities',
  'Community Health Programs',
];

function HospitalFormCheckbox() {
  const [formState, setFormState] = useState(
    departments.reduce((state, dept) => ({ ...state, [dept]: false }), {})
  );
  const [numberOfDocs, setNumberOfDocs] = useState(0);
  const history = useHistory();

  useEffect(() => {
    const getDocsCount = async () => {
      const querySnapshot = await getDocs(collection(database, 'HospitalDataCheckBox'));
      setNumberOfDocs(querySnapshot.size);
    };
    getDocsCount();
  }, []);

  const handleChange = (event) => {
    setFormState({ ...formState, [event.target.name]: event.target.checked });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    const isConfirmed = window.confirm("Are you sure you want to submit the form?");
    if (!isConfirmed) {
      return;
    }
    const id = `H${numberOfDocs + 1}`;
    await addDoc(collection(database, 'HospitalDataCheckBox'), {
      id,
      ...Object.entries(formState).reduce(
        (data, [dept, checked]) => ({ ...data, [dept]: checked ? 'yes' : 'no' }),
        {}
      ),
    });
    alert("Data has been successfully submitted!");
    history.push('/hospitalformexcelsheet');
  };

  return (
    <div className="p-6 bg-white rounded-md shadow-md">
      <h2 className="mb-4 text-2xl font-bold">Hospital Departments</h2>
      <form onSubmit={handleSubmit} className="grid grid-cols-2 gap-4">
        {departments.map((dept) => (
          <div key={dept} className="flex items-center">
            <input
              type="checkbox"
              name={dept}
              id={dept}
              checked={formState[dept]}
              onChange={handleChange}
              className="mr-2 appearance-none focus:ring-2 focus:ring-blue-500"
            />
            <label htmlFor={dept}>{dept}</label>
          </div>
        ))}
        <button type="submit" className="col-span-2 px-4 py-2 font-bold text-white bg-blue-500 rounded-md hover:bg-blue-700">
          Submit
        </button>
      </form>
    </div>
  );
}

export default HospitalFormCheckbox;
