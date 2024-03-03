// BloodTypeChart.js
import React, { useState, useEffect } from 'react';
import { PieChart, Pie, Cell, Tooltip, BarChart, Bar, XAxis, YAxis, CartesianGrid, Legend } from 'recharts';
import { collection, getDocs } from 'firebase/firestore';
import { database } from '../../firebase'; // Update this with your firebase configuration file path

function BloodTypeChart() {
  const [data, setData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const collectionRef = collection(database, 'Recepients'); // Replace 'Recipients' with your collection name
      const snapshot = await getDocs(collectionRef);
      const docs = snapshot.docs.map(doc => doc.data());
      setData(docs);
    };

    fetchData();
  }, []);

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#AF19FF', '#FF1975', '#19E6FF', '#99FF19', '#666666'];
  const bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'NI'];
  const provinces = ['Punjab', 'Sindh', 'Khyber Pakhtunkhwa', 'Balochistan', 'Gilgit-Baltistan', 'Azad Jammu and Kashmir', 'Islamabad Capital Territory'];

  // Data for Pie Chart
  const pieChartData = provinces.map(province => ({
    name: province,
    value: data.filter(item => item.Province === province).length
  }));

  // Data for Bar Graph
  const barChartData = bloodGroups.map(group => ({
    name: group,
    count: data.filter(item => item.BloodType === group).length
  }));

  return (
    <div style={{ display: 'flex', justifyContent: 'space-around' }}>
      <div style={{ padding: '20px', margin: '20px', backgroundColor: '#f5f5f5', borderRadius: '15px' }}>
        <h2>Pie Chart - Recipients by Province</h2>
        <PieChart width={400} height={400}>
          <Pie
            data={pieChartData}
            cx={200}
            cy={200}
            labelLine={false}
            outerRadius={80}
            fill="#8884d8"
            dataKey="value"
          >
            {pieChartData.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
            ))}
          </Pie>
          <Tooltip formatter={(value, name) => [value, name]} />
        </PieChart>
      </div>

      <div style={{ padding: '20px', margin: '20px', backgroundColor: '#f5f5f5', borderRadius: '15px' }}>
        <h2>Bar Graph - Blood Types</h2>
        <BarChart width={400} height={400} data={barChartData}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="count" fill="#8884d8" />
        </BarChart>
      </div>
    </div>
  );
}

export default BloodTypeChart;
