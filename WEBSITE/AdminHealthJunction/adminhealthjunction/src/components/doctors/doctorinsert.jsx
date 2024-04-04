import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { collection, addDoc } from "firebase/firestore";
import { storage, database } from "../../firebase";
import { ref, uploadBytesResumable, getDownloadURL } from "firebase/storage";



import TimePicker from 'react-time-picker';
import 'react-time-picker/dist/TimePicker.css';

const DoctorRegistrationForm = () => {
  const history = useHistory();

  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    phoneNumber: '',
    gender: '',
    dateOfBirth: '',
    province: '',
    city: '',
    address: '',
    licenseNumber: '',
    specialty: '',
    experience: '',
    workingHours: '',
    pricePerVisit: '',
    profilePicture: null,
    bio: '',
    availableDays: [false, false, false, false, false, false, false],
    startTime: '09:00',
    endTime: '18:00'
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    setFormData({ ...formData, profilePicture: file });
  };

  const handleCheckboxChange = (index) => {
    const updatedDays = [...formData.availableDays];
    updatedDays[index] = !updatedDays[index];
    setFormData({ ...formData, availableDays: updatedDays });
  };

  const handleStartTimeChange = (time) => {
    setFormData({ ...formData, startTime: time });
  };

  const handleEndTimeChange = (time) => {
    setFormData({ ...formData, endTime: time });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      // Store profile picture in Firebase Storage
      const storageRef = ref(storage, `doctorimages/doctor_profiles/${formData.profilePicture.name}`);
      await uploadBytesResumable(storageRef, formData.profilePicture);
  
      // Get download URL for the profile picture
      const profilePictureUrl = await getDownloadURL(storageRef);
  
      // Add profile picture URL to the form data
      const formDataWithProfilePicture = { ...formData, profilePicture: profilePictureUrl };
  
      // Combine start time and end time to create working hours string
      const workingHours = `${formData.startTime} - ${formData.endTime}`;
  
      // Add working hours string to the form data
      const formDataWithWorkingHours = { ...formDataWithProfilePicture, workingHours };
  
      // Remove start time and end time from the form data
      delete formDataWithWorkingHours.startTime;
      delete formDataWithWorkingHours.endTime;
  
      // Store form data in Firebase Firestore
      const docRef = await addDoc(collection(database, 'doctors'), formDataWithWorkingHours);
      console.log('Document written with ID: ', docRef.id);
  
      // Reset form data
      setFormData({
        fullName: '',
        email: '',
        phoneNumber: '',
        gender: '',
        dateOfBirth: '',
        province: '',
        city: '',
        address: '',
        licenseNumber: '',
        specialty: '',
        experience: '',
        workingHours: '',
        pricePerVisit: '',
        profilePicture: null,
        bio: '',
        availableDays: [false, false, false, false, false, false, false],
        startTime: '09:00',
        endTime: '18:00'
      });
  
      // Redirect after form submission
      history.push('/doctorsmanagement');
    } catch (error) {
      console.error('Error adding document: ', error);
    }
  };
  
  
  
  return (
    <div className="container p-4 mx-auto">
      <h1 className="mb-8 text-3xl font-bold text-center text-teal-600">Doctor Registration</h1>
      <form onSubmit={handleSubmit} className="max-w-xl mx-auto">
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          {/* All Form Fields */}
          {/* Full Name */}
          <div>
            <label className="block text-gray-700" htmlFor="fullName">Full Name</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="text"
              id="fullName"
              name="fullName"
              value={formData.fullName}
              onChange={handleChange}
              required
            />
          </div>
          {/* Email */}
          <div>
            <label className="block text-gray-700" htmlFor="email">Email</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              required
            />
          </div>
          {/* Phone Number */}
          <div>
            <label className="block text-gray-700" htmlFor="phoneNumber">Phone Number</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="tel"
              id="phoneNumber"
              name="phoneNumber"
              value={formData.phoneNumber}
              onChange={handleChange}
              required
            />
          </div>
          {/* Gender */}
          <div>
            <label className="block text-gray-700" htmlFor="gender">Gender</label>
            <select
              className="block w-full mt-1 border-gray-300 rounded-md form-select focus:outline-none focus:border-teal-500"
              id="gender"
              name="gender"
              value={formData.gender}
              onChange={handleChange}
              required
            >
              <option value="">Select Gender</option>
              <option value="Male">Male</option>
              <option value="Female">Female</option>
              <option value="Other">Other</option>
            </select>
          </div>
          {/* Date of Birth */}
          <div>
            <label className="block text-gray-700" htmlFor="dateOfBirth">Date of Birth</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="date"
              id="dateOfBirth"
              name="dateOfBirth"
              value={formData.dateOfBirth}
              onChange={handleChange}
              required
            />
          </div>
          {/* Province */}
          <div>
            <label className="block text-gray-700" htmlFor="province">Province</label>
            <select
              className="block w-full mt-1 border-gray-300 rounded-md form-select focus:outline-none focus:border-teal-500"
              id="province"
              name="province"
              value={formData.province}
              onChange={handleChange}
              required
            >
              <option value="">Select Province</option>
              <option value="Punjab">Punjab</option>
              <option value="Sindh">Sindh</option>
              <option value="Khyber Pakhtunkhwa">Khyber Pakhtunkhwa</option>
              <option value="Balochistan">Balochistan</option>
              <option value="Gilgit-Baltistan">Gilgit-Baltistan</option>
              <option value="Azad Kashmir">Azad Kashmir</option>
            </select>
          </div>
          {/* City */}
          <div>
            <label className="block text-gray-700" htmlFor="city">City</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="text"
              id="city"
              name="city"
              value={formData.city}
              onChange={handleChange}
              required
            />
          </div>
          {/* Address */}
          <div className="col-span-2">
            <label className="block text-gray-700" htmlFor="address">Address</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="text"
              id="address"
              name="address"
              value={formData.address}
              onChange={handleChange}
              required
            />
          </div>
          {/* Medical License Number */}
          <div>
            <label className="block text-gray-700" htmlFor="licenseNumber">Medical License Number</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="text"
              id="licenseNumber"
              name="licenseNumber"
              value={formData.licenseNumber}
              onChange={handleChange}
              required
            />
          </div>
          {/* Specialty */}
          <div>
            <label className="block text-gray-700" htmlFor="specialty">Specialty</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="text"
              id="specialty"
              name="specialty"
              value={formData.specialty}
              onChange={handleChange}
              required
            />
          </div>
          {/* Years of Experience */}
          <div>
            <label className="block text-gray-700" htmlFor="experience">Years of Experience</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="number"
              id="experience"
              name="experience"
              value={formData.experience}
              onChange={handleChange}
              required
            />
          </div>
          {/* Working Hours */}
          <div className="col-span-2">
            <label className="block text-gray-700" htmlFor="workingHours">Working Hours</label>
            <div className="flex items-center mt-1">
              <div className="mr-4">
                <span className="text-gray-700">Start Time</span>
                <TimePicker
                  onChange={handleStartTimeChange}
                  value={formData.startTime}
                  className="mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
                  showSecond={false}
                />
              </div>
              <div>
                <span className="text-gray-700">End Time</span>
                <TimePicker
                  onChange={handleEndTimeChange}
                  value={formData.endTime}
                  className="mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
                  showSecond={false}
                />
              </div>
            </div>
          </div>
          {/* Price per Visit */}
          <div>
            <label className="block text-gray-700" htmlFor="pricePerVisit">Price per Visit (PKR)</label>
            <input
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
              type="number"
              id="pricePerVisit"
              name="pricePerVisit"
              value={formData.pricePerVisit}
              onChange={handleChange}
              required
            />
          </div>
          {/* Profile Picture */}
          <div className="col-span-2">
            <label className="block text-gray-700" htmlFor="profilePicture">Profile Picture</label>
            <input
              type="file"
              id="profilePicture"
              name="profilePicture"
              accept="image/*"
              onChange={handleFileChange}
              className="block w-full mt-1 border-gray-300 rounded-md form-input focus:outline-none focus:border-teal-500"
            />
          </div>
          {/* Bio */}
          <div className="col-span-2">
            <label className="block text-gray-700" htmlFor="bio">Bio (Optional)</label>
            <textarea
              className="block w-full mt-1 border-gray-300 rounded-md form-textarea focus:outline-none focus:border-teal-500"
              id="bio"
              name="bio"
              value={formData.bio}
              onChange={handleChange}
            />
          </div>
          {/* Available Days */}
          <div className="col-span-2">
            <label className="block text-gray-700">Available Days:</label>
            <div className="flex flex-wrap">
              {formData.availableDays.map((day, index) => (
                <div key={index} className="flex items-center mb-2 mr-4">
                  <input
                    type="checkbox"
                    id={`day${index}`}
                    name={`day${index}`}
                    checked={day}
                    onChange={() => handleCheckboxChange(index)}
                    className="w-5 h-5 text-indigo-600 form-checkbox focus:outline-none focus:border-teal-500"
                  />
                  <label htmlFor={`day${index}`} className="ml-2 text-gray-700">{['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index]}</label>
                </div>
              ))}
            </div>
          </div>
        </div>
        {/* Submit button */}
        <button type="submit" className="w-full px-4 py-2 mt-6 text-white bg-teal-500 rounded-md hover:bg-teal-600 focus:outline-none focus:bg-teal-600">Register</button>
      </form>
    </div>
  );
};

export default DoctorRegistrationForm;
