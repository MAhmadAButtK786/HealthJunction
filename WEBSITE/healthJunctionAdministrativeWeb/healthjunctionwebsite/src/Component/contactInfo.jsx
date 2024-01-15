import React from "react";

const ContactInfo = () => {
  return (
    <div className="bg-gray-100 p-6">
      <h1 className="text-4xl font-bold text-center mb-4 text-indigo-900">
        Contact Us
      </h1>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
        {/* Email Section */}
        <div className="bg-white p-6 rounded-lg shadow-md">
          <h2 className="text-xl font-semibold mb-2 text-indigo-700">Emails:</h2>
          <ul className="list-disc pl-4 text-indigo-600">
            <li className="text-indigo-600">mail1@gmail.com</li>
            <li className="text-indigo-600">mail2@gmail.com</li>
            <li className="text-indigo-600">mail3@gmail.com</li>
          </ul>
        </div>

        {/* Phone Number Section */}
        <div className="bg-white p-6 rounded-lg shadow-md">
          <h2 className="text-xl font-semibold mb-2 text-indigo-700">Phone Numbers:</h2>
          <ul className="list-disc pl-4">
            <li className="text-indigo-600">+92-0000000000</li>
            <li className="text-indigo-600">+92-0000000001</li>
            <li className="text-indigo-600">+92-0000000002</li>
          </ul>
        </div>
      </div>

      {/* Address Section */}
      <div className="bg-white p-6 rounded-lg shadow-md">
        <h2 className="text-xl font-semibold mb-2 text-indigo-700">Address:</h2>
        <ul className="list-disc pl-4">
          <li className="text-indigo-600">
            123 Main Street, Cityville, Country
          </li>
          <li className="text-indigo-600">
            456 Secondary Street, Cityville, Country
          </li>
        </ul>
      </div>
    </div>
  );
};

export default ContactInfo;
