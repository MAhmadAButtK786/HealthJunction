// Importing data from an external file
import bloodBankData from './bbhdata';
import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion'; // Import framer-motion for animations

const BloodBankHomePage = () => {
  return (
    <motion.div 
      className=" min-h-screen p-8 bg-gradient-to-r from-blue-500 to-purple-500"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 1 }}
    >
      <header className="text-center mb-8">
        <h1 className="text-6xl font-bold text-white">Health Junction Blood Bank</h1>
        <p className="mt-2 text-xl text-white">Your Source for Safe and Reliable Blood Donations</p>
      </header>

      <section className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {bloodBankData.map((item, index) => (
          <motion.div
            key={index}
            className="p-6 rounded-md shadow-lg bg-white transition duration-300 hover:shadow-xl"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <div className="text-5xl mb-4 text-red-500">{item.icon}</div>
            <h2 className="text-2xl font-bold mb-2 text-gray-800">{item.title}</h2>
            <p className="mb-4 text-gray-600">{item.description}</p>
            <Link to={item.link} className="btn btn-lg bg-red-500 hover:bg-red-400 text-white transition duration-300 transform hover:scale-105">
              {item.title}
            </Link>
          </motion.div>
        ))}
      </section>
    </motion.div>
  );
};

export default BloodBankHomePage;
