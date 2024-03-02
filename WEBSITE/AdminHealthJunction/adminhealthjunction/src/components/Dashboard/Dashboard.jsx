// App.js
import React from 'react';
import Navbar from './Navbar';
import Sidebar from './Sidebar';
import MainContent from './maincontext';
import TodoList from './AdminTodo';
function Dashboard() {
  return (
    <div className="flex h-screen bg-blue-200"> 
      <Sidebar />
      <div className="flex flex-col w-full">
        <Navbar />
        <MainContent />
        <TodoList/>
      </div>
    </div>
  );
}

export default Dashboard;
