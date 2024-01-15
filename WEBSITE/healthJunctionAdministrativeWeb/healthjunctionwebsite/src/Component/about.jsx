import React from 'react';
import { motion } from 'framer-motion';
// ... (imports)

const AboutUs = () => {
  const data = [
    {
      title: 'Our Mission',
      content:
        "Simplify medical choices, connect with resources, and feel empowered about your well-being. We're your health compass, linking hospitals, clinics, labs, and charities. Navigate tests, care intricacies, and join communities. Your one-stop for informed action. Every click sparks a healthier tomorrow.",
    },
    {
      title: 'Our Philosophy',
      content:
        "Provide a clear path to navigate medical choices, access resources, and take control of your well-being. Connect hospitals, clinics, labs, and charities. Simplify your journey with insights into tests, expert navigation through care complexities, and a sense of community. Your hub for informed decisions, where knowledge empowers and interactions shape a healthier future.",
    },
   
    
  ];

  return (
    <div className="flex flex-wrap justify-around bg-gray-100 p-8">
      {data.map((item, index) => (
        <motion.div
          key={index}
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: index * 0.2 }}
          className="max-w-md rounded overflow-hidden shadow-lg m-4 bg-blue-700"
        >
          <div className="px-6 py-4">
            <div className="font-bold text-3xl mb-4 text-white"> {item.title}</div>
            <p className="text-white text-base">{item.content}</p>
          </div>
          {/* Additional elements can be added here */}
        </motion.div>
      ))}
    </div>
  );
};

export default AboutUs;
