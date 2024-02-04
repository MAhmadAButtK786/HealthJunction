import React, { useState } from 'react';

const HospitalRegistrationForm = () => {
  // State to hold form data
  const [formData, setFormData] = useState({
    HospitalName: '',
    Address: '',
    City: '',
    State: '',
    Zip: '',
    Email: '',
    Contact: '',
    departments: {
      EmergencyDepartment: false,
      InpatientWards: false,
      OutpatientClinics: false,
      OperatingRooms: false,
      DiagnosticImaging: false,
      LaboratoryServices: false,
      Pharmacy: false,
      IntensiveCareUnits: false,
      RehabilitationServices: false,
      MaternityAndNeonatalCare: false,
      HospitalAdministration: false,
      PatientRegistration: false,
      CafeteriaAndNutritionServices: false,
      MedicalRecordsDepartment: false,
      InfectionControlAndSterilization: false,
      BiohazardWasteManagement: false,
      InformationTechnology: false,
      SecurityAndSafetyServices: false,
      EducationAndTrainingFacilities: false,
      CommunityHealthPrograms: false,
    },
    ExcelFile: null,
  });

  // State to hold form validation errors
  const [errors, setErrors] = useState({
    HospitalName: '',
    Address: '',
    City: '',
    State: '',
    Zip: '',
    Email: '',
    Contact: '',
    departments: '',
    ExcelFile: '',
  });

  // Event handler for form field changes
  const handleChange = (e) => {
    const { name, type, checked } = e.target;
    const value =
      type === 'checkbox'
        ? {
            ...formData.departments,
            [name]: checked,
          }
        : type === 'file'
        ? e.target.files[0]
        : e.target.value;

    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  // Function to validate form
  const validateForm = () => {
    let isValid = true;
    const newErrors = { ...errors };

    // Validation for other fields (similar to previous examples)

    // Validation for checkboxes
    if (!Object.values(formData.departments).some(Boolean)) {
      newErrors.departments = 'Please select at least one department';
      isValid = false;
    } else {
      newErrors.departments = '';
    }

    // Validation for Excel Sheet
    if (!formData.ExcelFile) {
      newErrors.ExcelFile = 'Excel file is required';
      isValid = false;
    } else {
      const allowedExtensions = ['.xls', '.xlsx'];
      const fileExtension = formData.ExcelFile.name.split('.').pop().toLowerCase();

      if (!allowedExtensions.includes(`.${fileExtension}`)) {
        newErrors.ExcelFile = 'Invalid file format. Please upload an Excel file.';
        isValid = false;
      } else {
        newErrors.ExcelFile = '';
      }
    }

    setErrors(newErrors);
    return isValid;
  };

  // Event handler for form submission
  const handleSubmit = (e) => {
    e.preventDefault();

    if (validateForm()) {
      // Add your form submission logic here
      console.log(formData);
    } else {
      console.log('Form validation failed');
    }
  };

  // JSX for the form
  return (
    <div className='p-10'>
      <form className="max-w-xl mx-auto" onSubmit={handleSubmit}>
        {/* ... (Other form fields) ... */}

        {/* Checkbox Fields */}
        <div className="mb-6">
          <label className="block mb-2 text-sm font-bold text-gray-700 uppercase">
            Hospital Departments
          </label>
          <div className="grid grid-cols-2 gap-4">
            {Object.entries(formData.departments).map(([key, value]) => (
              <div key={key} className="flex items-center">
                <input
                  type="checkbox"
                  id={key}
                  name={`departments.${key}`}
                  checked={value}
                  onChange={handleChange}
                  className="mr-2"
                />
                <label htmlFor={key}>{key.replace(/([a-z])([A-Z])/g, '$1 $2')}</label>
              </div>
            ))}
          </div>
          {errors.departments && <p className="text-xs italic text-red-500">{errors.departments}</p>}
        </div>

        {/* Excel Sheet */}
        <div className="mb-6">
          <label htmlFor="excelfile" className="block mb-2 text-sm font-bold text-gray-700 uppercase">
            Add Doctors Information Excel Sheet
          </label>
          <input
            type="file"
            id="excelfile"
            name="ExcelFile"
            accept=".xls, .xlsx"
            onChange={handleChange}
            className={`block w-full px-4 py-2 leading-tight text-gray-700 bg-gray-200 border ${errors.ExcelFile ? 'border-red-500' : 'border-gray-200'} rounded appearance-none focus:outline-none focus:bg-white`}
            placeholder="Add Excel File with Doctors Information"
          />
          {errors.ExcelFile && <p className="text-xs italic text-red-500">{errors.ExcelFile}</p>}
        </div>

        {/* Submit Button */}
        <div>
          <button
            type="submit"
            className="w-full px-4 py-2 text-white bg-blue-500 rounded-md hover:bg-blue-600 focus:outline-none focus:shadow-outline-blue active:bg-blue-800"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  );
};

export default HospitalRegistrationForm;
