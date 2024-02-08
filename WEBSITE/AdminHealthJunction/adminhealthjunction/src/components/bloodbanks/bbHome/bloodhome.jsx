// Import necessary modules and data
import React from 'react';
import { Link } from 'react-router-dom';
import { motion } from 'framer-motion'; // Import framer-motion for animations
import bloodBankData from './bbhdata'; // Assuming you have data for administrative tasks

const AdminPanelHomePage = () => {
  return (
    <motion.div 
      className="min-h-screen p-8 bg-gradient-to-r from-blue-500 to-purple-500"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 1 }}
    >
      <header className="mb-8 text-center">
        <h1 className="text-6xl font-bold text-white">Admin Panel</h1>
        <p className="mt-2 text-xl text-white">Manage Blood Bank Operations</p>
      </header>

      <section className="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        {bloodBankData.map((item, index) => (
          <motion.div
            key={index}
            className="p-6 transition duration-300 bg-white rounded-md shadow-lg hover:shadow-xl"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <div className="mb-4 text-5xl text-red-500">{item.icon}</div>
            <h2 className="mb-2 text-2xl font-bold text-gray-800">{item.title}</h2>
            <p className="mb-4 text-gray-600">{item.description}</p>
            <Link to={item.link} className="text-white transition duration-300 transform bg-red-500 btn btn-lg hover:bg-red-400 hover:scale-105">
              {item.title}
            </Link>
          </motion.div>
        ))}
      </section>
    </motion.div>
  );
};

export default AdminPanelHomePage;
