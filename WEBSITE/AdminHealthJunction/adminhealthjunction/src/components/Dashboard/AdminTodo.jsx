import React, { useState, useEffect } from 'react';
import { database } from '../../firebase';
import { collection, addDoc, getDocs, deleteDoc, doc, updateDoc } from 'firebase/firestore';
import { FaCheck, FaTrash, FaEdit, FaExclamationCircle, FaArrowUp, FaArrowDown } from 'react-icons/fa';

function TodoList() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState({ task: '', date: '', priority: '', category: '' });
  const [editMode, setEditMode] = useState(false);
  const [idToEdit, setIdToEdit] = useState(null);

  // Function to fetch tasks from Firestore
  const fetchTasks = async () => {
    const tasksCollection = collection(database, 'Admintodo');
    const tasksSnapshot = await getDocs(tasksCollection);
    const tasksData = tasksSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    setTasks(tasksData);
  };

  // Function to add a new task to Firestore
  const addTask = async (event) => {
    event.preventDefault();
    if (newTask.task.trim() === '') return;
    if (editMode) {
      const docRef = doc(database, 'Admintodo', idToEdit);
      await updateDoc(docRef, newTask);
      setEditMode(false);
      setIdToEdit(null);
    } else {
      const newTaskDocRef = await addDoc(collection(database, 'Admintodo'), newTask);
      setTasks(prevTasks => [...prevTasks, { id: newTaskDocRef.id, ...newTask }]);
    }
    setNewTask({ task: '', date: '', priority: '', category: '' });
    fetchTasks();
  };

  // Function to mark a task as done
  const markDone = async (taskId) => {
    await deleteDoc(doc(database, 'Admintodo', taskId));
    setTasks(prevTasks => prevTasks.filter(task => task.id !== taskId));
  };

  // Function to edit a task
  const editTask = (taskId, task) => {
    setNewTask(task);
    setEditMode(true);
    setIdToEdit(taskId);
  };

  useEffect(() => {
    fetchTasks();
  }, []);

  return (
    <div className="flex flex-col items-center justify-center">
      <div className="p-4 bg-white rounded shadow-md w-96">
        <h2 className="mb-4 text-xl font-semibold text-center text-blue-500">Todo List</h2>
        <form onSubmit={addTask} className="flex flex-col mb-4">
          <input
            type="text"
            className="mb-2 px-2 py-1 text-gray-800 bg-gray-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Add a new task..."
            value={newTask.task}
            onChange={(e) => setNewTask({ ...newTask, task: e.target.value })}
          />
          <input
            type="date"
            className="mb-2 px-2 py-1 text-gray-800 bg-gray-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-400"
            value={newTask.date}
            onChange={(e) => setNewTask({ ...newTask, date: e.target.value })}
          />
          <select
            className="mb-2 px-2 py-1 text-gray-800 bg-gray-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-400"
            value={newTask.priority}
            onChange={(e) => setNewTask({ ...newTask, priority: e.target.value })}
          >
            <option value="">Select Priority</option>
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
          </select>
          <input
            type="text"
            className="mb-2 px-2 py-1 text-gray-800 bg-gray-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Add a category..."
            value={newTask.category}
            onChange={(e) => setNewTask({ ...newTask, category: e.target.value })}
          />
          <button type="submit" className="px-4 py-1 text-white bg-blue-500 rounded hover:bg-blue-600">{editMode ? 'Update' : 'Add'}</button>
        </form>
        <ul>
          {tasks.map(task => (
            <li key={task.id} className="flex flex-col items-start justify-between py-2 border-b border-gray-200">
              <span className="text-gray-800">{task.task}</span>
              <span className="text-sm text-gray-500">{task.date}</span>
              <span className={`text-sm ${task.priority === 'High' ? 'text-red-500' : task.priority === 'Medium' ? 'text-yellow-500' : 'text-green-500'}`}>
                {task.priority === 'High' ? <FaExclamationCircle /> : task.priority === 'Medium' ? <FaArrowUp /> : <FaArrowDown />}
                {task.priority}
              </span>
              <span className="text-sm text-gray-500">{task.category}</span>
              <div className="mt-2">
                <button className="mr-2 text-yellow-500 hover:text-yellow-600" onClick={() => editTask(task.id, task)}><FaEdit /></button>
                <button className="mr-2 text-green-500 hover:text-green-600" onClick={() => markDone(task.id)}><FaCheck /></button>
                <button className="text-red-500 hover:text-red-600" onClick={() => markDone(task.id)}><FaTrash /></button>
              </div>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default TodoList;
