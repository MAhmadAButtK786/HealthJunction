// BloodTypeChart.js
import React, { useState, useEffect } from 'react';
import { PieChart, Pie, Cell, Tooltip, BarChart, Bar, XAxis, YAxis, CartesianGrid, Legend } from 'recharts';
import { collection, getDocs } from 'firebase/firestore';
import { database } from '../../firebase'; // Update this with your firebase configuration file path

function BloodTypeChart2() {
  const [recipientData, setRecipientData] = useState([]);
  const [donorData, setDonorData] = useState([]);

  useEffect(() => {
    const fetchRecipientData = async () => {
      const collectionRef = collection(database, 'Recepients');
      const snapshot = await getDocs(collectionRef);
      const docs = snapshot.docs.map(doc => doc.data());
      setRecipientData(docs);
    };

    const fetchDonorData = async () => {
      const collectionRef = collection(database, 'Donors');
      const snapshot = await getDocs(collectionRef);
      const docs = snapshot.docs.map(doc => doc.data());
      setDonorData(docs);
    };

    fetchRecipientData();
    fetchDonorData();
  }, []);

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#AF19FF', '#FF1975', '#19E6FF', '#99FF19', '#666666'];
  const bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'NI'];
  const provinces = ['Punjab', 'Sindh', 'Khyber Pakhtunkhwa', 'Balochistan', 'Gilgit-Baltistan', 'Azad Jammu and Kashmir', 'Islamabad Capital Territory'];

  // Data for Recipient Pie Chart
  const recipientPieChartData = provinces.map(province => ({
    name: province,
    value: recipientData.filter(item => item.Province === province).length
  }));

  // Data for Donor Pie Chart
  const donorPieChartData = provinces.map(province => ({
    name: province,
    value: donorData.filter(item => item.Province === province).length
  }));

  // Data for Recipient Bar Graph
  const recipientBarChartData = bloodGroups.map(group => ({
    name: group,
    count: recipientData.filter(item => item.BloodType === group).length
  }));

  // Data for Donor Bar Graph
  const donorBarChartData = bloodGroups.map(group => ({
    name: group,
    count: donorData.filter(item => item.BloodType === group).length
  }));

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-around' }}>
        <div style={{ padding: '20px', margin: '20px', backgroundColor: '#f5f5f5', borderRadius: '15px' }}>
          <h2>Recipient Pie Chart - Recipients by Province</h2>
          <PieChart width={400} height={400}>
            <Pie
              data={recipientPieChartData}
              cx={200}
              cy={200}
              labelLine={false}
              outerRadius={80}
              fill="#8884d8"
              dataKey="value"
            >
              {recipientPieChartData.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
              ))}
            </Pie>
            <Tooltip formatter={(value, name) => [value, name]} />
          </PieChart>
        </div>

        <div style={{ padding: '20px', margin: '20px', backgroundColor: '#f5f5f5', borderRadius: '15px' }}>
          <h2>Donor Pie Chart - Donors by Province</h2>
          <PieChart width={400} height={400}>
            <Pie
              data={donorPieChartData}
              cx={200}
              cy={200}
              labelLine={false}
              outerRadius={80}
              fill="#8884d8"
              dataKey="value"
            >
              {donorPieChartData.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
              ))}
            </Pie>
            <Tooltip formatter={(value, name) => [value, name]} />
          </PieChart>
        </div>
      </div>

      <div style={{ display: 'flex', justifyContent: 'space-around' }}>
        <div style={{ padding: '20px', margin: '20px', backgroundColor: '#f5f5f5', borderRadius: '15px' }}>
          <h2>Recipient Bar Graph - Blood Types</h2>
          <BarChart width={400} height={400} data={recipientBarChartData}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Bar dataKey="count" fill="#8884d8" />
          </BarChart>
        </div>

        <div style={{ padding: '20px', margin: '20px', backgroundColor: '#f5f5f5', borderRadius: '15px' }}>
          <h2>Donor Bar Graph - Blood Types</h2>
          <BarChart width={400} height={400} data={donorBarChartData}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="name" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Bar dataKey="count" fill="#8884d8" />
          </BarChart>
        </div>
      </div>
    </div>
  );
}

export default BloodTypeChart2;
