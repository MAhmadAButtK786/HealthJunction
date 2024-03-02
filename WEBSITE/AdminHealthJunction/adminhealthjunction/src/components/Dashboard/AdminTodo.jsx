import React, { useState, useEffect } from 'react';
import { database } from '../../firebase';
import { collection, addDoc, getDocs, deleteDoc, doc, updateDoc } from 'firebase/firestore';
import { FaCheck, FaTrash, FaEdit } from 'react-icons/fa';

function TodoList() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState('');
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
    if (newTask.trim() === '') return;
    if (editMode) {
      const docRef = doc(database, 'Admintodo', idToEdit);
      await updateDoc(docRef, { task: newTask });
      setEditMode(false);
      setIdToEdit(null);
    } else {
      const newTaskDocRef = await addDoc(collection(database, 'Admintodo'), { task: newTask });
      setTasks(prevTasks => [...prevTasks, { id: newTaskDocRef.id, task: newTask }]);
    }
    setNewTask('');
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
    <div className="flex flex-col items-center justify-center ">
      <div className="p-4 bg-white rounded shadow-md w-80">
        <h2 className="mb-4 text-xl font-semibold text-center text-blue-500">Todo List</h2>
        <form onSubmit={addTask} className="flex mb-4">
          <input
            type="text"
            className="flex-grow px-2 py-1 mr-2 text-gray-800 bg-gray-200 rounded focus:outline-none focus:ring-2 focus:ring-blue-400"
            placeholder="Add a new task..."
            value={newTask}
            onChange={(e) => setNewTask(e.target.value)}
          />
          <button type="submit" className="px-4 py-1 text-white bg-blue-500 rounded hover:bg-blue-600">{editMode ? 'Update' : 'Add'}</button>
        </form>
        <ul>
          {tasks.map(task => (
            <li key={task.id} className="flex items-center justify-between py-2 border-b border-gray-200">
              <span className="text-gray-800">{task.task}</span>
              <div>
                <button className="mr-2 text-yellow-500 hover:text-yellow-600" onClick={() => editTask(task.id, task.task)}><FaEdit /></button>
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
