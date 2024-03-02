// App.js
import React from 'react';
import Navbar from './Navbar';
import Sidebar from './Sidebar';
import MainContent from './maincontext';

function Dashboard() {
  return (
    <div className="flex h-screen">
      <Sidebar />
      <div className="flex flex-col w-full">
        <Navbar />
        <MainContent />
      </div>
    </div>
  );
}

export default Dashboard;
