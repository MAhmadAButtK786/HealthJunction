// App.js
import React from 'react';
import Navbar from './Navbar';
import Sidebar from './Sidebar';
 import MainContent from './maincontext';
import TodoList from './AdminTodo';

import BloodTypeChart2 from './charts2Donor';
function Dashboard() {
  return (
    <div className="flex  bg-blue-200"> 
      <Sidebar />
      <div className="flex flex-col w-full">
        <Navbar />
        <MainContent />
        <TodoList/>
\
       <BloodTypeChart2/>
      </div>
    </div>
  );
}

export default Dashboard;
