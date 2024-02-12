/* eslint-disable no-unused-vars */
import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { IoMdMail, IoMdLock } from 'react-icons/io';
import { auth, database } from "../firebase";
import { query, collection, where, getDocs } from 'firebase/firestore';
import { signInWithEmailAndPassword } from 'firebase/auth';

const LoginBDS = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const history = useHistory();

  const handleLogin = async (e) => {
    e.preventDefault();

    try {
      setLoading(true);
      // Check if the user exists in Firestore
      const userQuery = query(collection(database, 'BDS'), where('Username', '==', username));
      const querySnapshot = await getDocs(userQuery);

      if (!querySnapshot.empty) {
        // User exists, check password
        querySnapshot.forEach((doc) => {
          const userData = doc.data();
          if (userData.Password === password) {
            // Password is correct, proceed with authentication
            setLoading(false);
            history.push('/home');
            alert('Successfully logged in!');
          } else {
            // Password is incorrect
            setLoading(false);
            alert('Incorrect password!');
          }
        });
      } else {
        // User doesn't exist
        setLoading(false);
        alert('User not found. Please check your credentials.');
      }
    } catch (error) {
      setLoading(false);
      alert('Something went wrong with Signing In: ' + error.message);
    }
  };
  return (
    <div className="flex flex-col items-center justify-center min-h-screen text-white bg-red-500">
      <div className="text-4xl font-bold mb-9">In The Collaboration with Health Junction</div>
      <div className="mb-6 text-2xl font-bold">Blood Donor Society</div>
      <form className="w-full p-8 bg-white rounded-md shadow-md md:w-4/12">
        <h2 className="mb-4 text-2xl font-bold text-blue-600">Login as BDS Administrator </h2>
        <label htmlFor="" className='font-bold text-black'>Enter Administrative Username</label>
        <div className="flex items-center mb-4">
          <IoMdMail className="w-6 h-6 mr-2 text-gray-500" />
          <input
            type="email"
            placeholder="Enter Username"
            className="w-full px-4 py-2 text-black border border-blue-500 rounded-md focus:outline-none focus:border-white"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </div>
        <label htmlFor="" className='font-bold text-black pr-50'>Enter Your Password</label>
        <div className="flex items-center mb-6">
          <IoMdLock className="w-6 h-6 mr-2 text-gray-500" />
          <input
            type="password"
            placeholder="Enter Password"
            className="w-full px-4 py-2 text-black border border-blue-500 rounded-md focus:outline-none focus:border-white"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>
        <button
          type="submit"
          className={`w-full py-2 rounded-md ${
            loading ? 'bg-gray-500 cursor-not-allowed' : 'bg-blue-700 hover:bg-blue-800'
          } text-white focus:outline-none mb-4`}
          onClick={handleLogin}
          disabled={loading}
        >
          {loading ? 'Logging In...' : 'Login'}
        </button>
      </form>
    </div>
  );
};

export default LoginBDS;
