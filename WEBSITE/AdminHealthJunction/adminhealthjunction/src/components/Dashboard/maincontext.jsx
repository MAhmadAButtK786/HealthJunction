// CardPage.js
import React from 'react';
import { collection, getDocs } from 'firebase/firestore';
import { database } from '../../firebase';
import { FaUser,FaHospital, FaUserInjured, FaHandHoldingHeart, FaMicroscope, FaClinicMedical,FaHandsHelping } from 'react-icons/fa'; // Importing icons from react-icons/fa 

// Fetch data from Firestore
const fetchData = async (field) => {
  try {
    const querySnapshot = await getDocs(collection(database, field));
    return querySnapshot.size; // returns the number of documents
  } catch (error) {
    console.error(`Error fetching ${field} data:`, error);
    return 0;
  }
};

// Fetch data for each field
const fetchAllData = async () => {
  const fields = [
    { name: 'Users', correctedName: 'Users', icon: <FaUser size={24} color='blue' /> },
    { name: 'PHC Hospitals', correctedName: 'PHC Hospitals', icon: <FaHospital size={24}  color='blue'/> },
    { name: 'PHC Labs', correctedName: 'Punjab Register Lab', icon: <FaMicroscope size={24} color='blue'/> },
    { name: 'Private Blood Banks', correctedName: 'Private Blood Banks', icon: <FaClinicMedical size={24} color='blue'/> },
    { name: 'Public Blood Banks', correctedName: 'Public Blood Banks', icon: <FaClinicMedical size={24} color='blue'/> },
    { name: 'Recipients', correctedName: 'Recepients', icon: <FaUserInjured size={24} color='blue'/> },
    { name: 'Donors', correctedName: 'Donors', icon: <FaHandHoldingHeart size={24} color='blue'/> },
    { name: 'Charitable Organization', correctedName: 'NGOs', icon: <FaHandsHelping size={24} color='blue'/> },
  ];
  const data = {};
  for (let field of fields) {
    data[field.name] = { count: await fetchData(field.correctedName), icon: field.icon };
  }
  return data;
};

// Card component
const Card = ({ title, count, icon }) => (
  <div className="flex flex-col items-center justify-center w-full p-1 m-2 text-blue-700 transition-shadow duration-300 bg-white rounded-lg shadow-md md:w-1/5 card hover:shadow-xl">
    {icon}
    <h2 className="mt-2 text-lg font-semibold">{title}</h2>
    <p className="text-sm">{count}</p>
  </div>
);

// CardPage component
const MainContent = () => {
  const [data, setData] = React.useState(null);

  React.useEffect(() => {
    fetchAllData().then(setData);
  }, []);

  return (
    <div className="flex flex-wrap justify-center p-4">
      {data && Object.entries(data).map(([title, { count, icon }], index) => (
        <Card key={title} title={title} count={count} icon={icon} />
      ))}
    </div>
  );
};

export default MainContent;
