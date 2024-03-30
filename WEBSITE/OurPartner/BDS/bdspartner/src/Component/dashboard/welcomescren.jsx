/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-unused-vars */
import React, { useState, useEffect } from 'react';
import { useHistory } from 'react-router-dom';
import { motion } from 'framer-motion';

const WelcomeScreen = () => {
  const history = useHistory();
  const [countdown, setCountdown] = useState(5);


  const verse = "And whoever saves one [life] - it is as if he had saved mankind entirely. - Quran 5:32";


  const goToHomePage = () => {
    history.push('/home'); 
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      goToHomePage();
    }, countdown * 1000); // Convert countdown to milliseconds
    return () => clearTimeout(timer); // Cleanup timer on unmount
  }, []); // Only run on component mount

  return (
    <div className="flex items-center justify-center w-full h-screen pl-6 dashboard bg-gradient-to-r from-teal-400 to-blue-500">
      <motion.div
        initial={{ opacity: 0, y: -50 }} // Initial animation state
        animate={{ opacity: 1, y: 0 }} // Animation when component mounts
        exit={{ opacity: 0, y: 50 }} // Animation when component unmounts
        transition={{ duration: 0.5 }} // Animation duration
        className="max-w-md p-12 text-center bg-white rounded-full shadow-md beautiful-message" // Increased padding
      >
        <h2 className="mb-8 text-3xl font-semibold text-teal-700">Welcome, Administrator!</h2>
        <p className="text-lg text-gray-700">
          {verse}
          <br />
          <br />
          You have administrative power. Use this platform to control, edit, and manage various aspects of the system.
        </p>
      </motion.div>

      {/* Circular HealthJunction Logo with more spacing */}
      <img
        src="images/hjlogo.png"
        alt="HealthJunction Logo"
        className="w-48 h-48 mx-auto rounded-full cursor-pointer -mb-21"
        onClick={goToHomePage}
      />

      {/* Countdown Timer with better positioning */}
      <div className="absolute mt-4 text-white bottom-4 right-4">{`Redirecting in ${countdown} seconds`}</div>
    </div>
  );
};

export default WelcomeScreen;
