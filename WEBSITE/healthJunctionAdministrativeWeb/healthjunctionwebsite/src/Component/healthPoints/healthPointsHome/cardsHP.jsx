import React from 'react';
import { FaHospital, FaClinicMedical, FaUserInjured, FaClock } from 'react-icons/fa';
import { FiCalendar, FiPhone,  FiInfo,FiEye, FiBookOpen, } from 'react-icons/fi';
function CardsHP() {
  return (
    <div className="grid grid-cols-1 gap-5 p-8 md:grid-cols-2 lg:grid-cols-3">
      {/* Special Card for Motto */}
      <div className="max-w-full overflow-hidden text-white transition-all duration-300 ease-in-out transform bg-blue-700 rounded-lg shadow-md col-span-full hover:shadow-xl hover:scale-105">
        <div className="p-8 text-center">
          <h2 className="mb-4 text-3xl font-bold">Our Motto</h2>
          <p className="text-lg">
            "Promoting Health, Serving Humanity. We believe in providing quality healthcare services for everyone. Join us in our mission to make healthcare accessible and affordable for all."
          </p>
        </div>
      </div>

      {/* Special Card for Vision */}
      <div className="max-w-full overflow-hidden text-white transition-all duration-300 ease-in-out transform bg-green-700 rounded-lg shadow-md col-span-full hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-8">
          <FiEye className="mr-4 text-xl text-blue-100"  style={{ fontSize: '5rem' }}/>
          <div>
            <h2 className="mb-2 text-xl font-semibold">Our Vision</h2>
            <p className="text-lg text-blue-100">
              "To be the leading platform for healthcare services, where everyone can access quality care without barriers. We envision a world where healthcare is a right, not a privilege."
            </p>
          </div>
        </div>
      </div>

      {/* Special Card for Philosophy */}
      <div className="max-w-full overflow-hidden text-white transition-all duration-300 ease-in-out transform bg-indigo-700 rounded-lg shadow-md col-span-full hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-8">
          <FiBookOpen className="mr-4 text-xl text-blue-100"  style={{ fontSize: '5rem' }}/>
          <div>
            <h2 className="mb-2 text-xl font-semibold">Our Philosophy</h2>
            <p className="text-lg text-blue-100">
              "We believe in the power of healthcare to change lives. Our philosophy is centered around the idea that quality healthcare should be accessible to all, regardless of their circumstances. We strive to make this a reality every day."
            </p>
          </div>
        </div>
      </div>

      {/* Hospital Registration Card */}
      <div className="max-w-full overflow-hidden transition-all duration-300 ease-in-out transform bg-white rounded-lg shadow-md md:max-w-sm hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-4">
          <FaHospital className="mr-4 text-blue-700" style={{ fontSize: '10rem' }} />
          <div>
            <h2 className="mb-2 text-xl font-semibold">Hospital Registration</h2>
            <p className="text-gray-700">
              Register your hospital and join our network of healthcare providers. Get access to a wide range of services and tools designed to help you provide the best care for your patients.
            </p>
          </div>
        </div>
      </div>

      {/* Clinics Card */}
      <div className="max-w-full overflow-hidden transition-all duration-300 ease-in-out transform bg-white rounded-lg shadow-md md:max-w-sm hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-4">
          <FaClinicMedical className="mr-4 text-blue-700" style={{ fontSize: '10rem' }} />
          <div>
            <h2 className="mb-2 text-xl font-semibold">Clinics</h2>
            <p className="text-gray-700">
              Explore and find clinics offering specialized medical services. From general health check-ups to specialized treatments, find the right clinic for your healthcare needs.
            </p>
          </div>
        </div>
      </div>

      {/* Hospital Details Card */}
      <div className="max-w-full overflow-hidden transition-all duration-300 ease-in-out transform bg-white rounded-lg shadow-md md:max-w-sm hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-4">
          <FaUserInjured className="mr-4 text-blue-700" style={{ fontSize: '10rem' }} />
          <div>
            <h2 className="mb-2 text-xl font-semibold">Hospital Details</h2>
            <p className="text-gray-700">
              Access detailed information about hospitals, services, and specialties. Find the right hospital for your healthcare needs, understand the services they offer, and make informed decisions about your health.
            </p>
          </div>
        </div>
      </div>

      {/* Emergency Services Card */}
      <div className="max-w-full overflow-hidden transition-all duration-300 ease-in-out transform bg-white rounded-lg shadow-md md:max-w-sm hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-4">
          <FaClock className="mr-4 text-blue-700" style={{ fontSize: '10rem' }} />
          <div>
            <h2 className="mb-2 text-xl font-semibold">Emergency Services</h2>
            <p className="text-gray-700">
              Find hospitals offering 24/7 emergency services. Get immediate care for critical conditions and ensure you or your loved ones get timely and effective medical attention when it matters the most.
            </p>
          </div>
        </div>
      </div>

         {/* Improved text for Booking Appointments */}
      <div className="max-w-full overflow-hidden transition-all duration-300 ease-in-out transform bg-white rounded-lg shadow-md md:max-w-sm hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-4">
          <FiCalendar className="mr-4 text-blue-700" style={{ fontSize: '10rem' }} />
          <div>
            <h2 className="mb-2 text-xl font-semibold">Schedule Your Appointment</h2>
            <p className="text-gray-700">
              Secure your consultation with our experienced medical professionals. Choose a convenient time and date for your visit to ensure personalized care.
            </p>
            <div className="flex items-center mt-4 text-gray-500">
              <FiPhone className="mr-1" /> For this Download our App 
            </div>
            <b>Health junction</b>
          </div>
        </div>
      </div>

      {/* Improved text for Emergency Contacts/Info */}
      <div className="max-w-full overflow-hidden transition-all duration-300 ease-in-out transform bg-white rounded-lg shadow-md md:max-w-sm hover:shadow-xl hover:scale-105">
        <div className="flex items-center p-4">
          <FiInfo className="mr-4 text-blue-700" style={{ fontSize: '10rem' }} />
          <div>
            <h2 className="mb-2 text-xl font-semibold">Emergency Contacts & Information</h2>
            <p className="text-gray-700">
              Keep essential emergency contacts and information readily available for unforeseen circumstances. Be prepared and stay informed.
            </p>
            <div className="mt-4">
              <h3 className="mb-2 text-lg font-semibold">Emergency Information</h3>
              <ul className="text-gray-500 list-disc list-inside">
                <li>Rescue 1122:  1122</li>
                <li>Police: 15</li>
                <li>Fire Brigade: 16</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default CardsHP;
