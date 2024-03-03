// App.js
import React from 'react';
import Navbar from './Navbar';
import Sidebar from './Sidebar';
 import MainContent from './maincontext';
import TodoList from './AdminTodo';
import BloodTypeChart from './charts';
function Dashboard() {
  return (
    <div className="flex  bg-blue-200"> 
      <Sidebar />
      <div className="flex flex-col w-full">
        <Navbar />
        <MainContent />
        <TodoList/>
       <BloodTypeChart/>
      </div>
    </div>
  );
}

export default Dashboard;
