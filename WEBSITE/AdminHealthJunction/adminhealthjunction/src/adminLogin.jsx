/* eslint-disable no-unused-vars */
import React, { useState } from 'react';
import { getAuth, signInWithEmailAndPassword, signInWithPopup, GoogleAuthProvider } from 'firebase/auth';
import { useHistory } from 'react-router-dom';
import { IoMdMail, IoMdLock } from 'react-icons/io';
import { getFirestore, collection, query, where, getDocs } from 'firebase/firestore';

const LoginPage = () => {
  const [username, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const auth = getAuth();
 
  const history = useHistory();
  const db = getFirestore();

  const handleLogin = async (e) => {
    e.preventDefault();

    try {
      setLoading(true);

      // Check if the user exists in Firestore
      const userQuery = query(collection(db, 'Admin'), where('Username', '==', username));
      const querySnapshot = await getDocs(userQuery);

      if (!querySnapshot.empty) {
        // User exists, proceed with authentication
        const result = await signInWithEmailAndPassword(auth,username, password);
        const user = result.user;
        sessionStorage.setItem('username', user.email);
        setLoading(false);
        history.push('/home');
        alert('Successfully logged in with credentials!');
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
    <div className="flex flex-col items-center justify-center min-h-screen text-white bg-blue-500">
      <div className="mb-6 text-4xl font-bold">Health Junction</div>
      <form className="w-full p-8 bg-white rounded-md shadow-md md:w-4/12">
        <h2 className="mb-4 text-2xl font-bold">Login</h2>
        <label htmlFor=""className='font-bold text-black'>Enter Your Email</label>
        <div className="flex items-center mb-4">
          <IoMdMail className="w-6 h-6 mr-2 text-gray-500" />
          <input
            type="email"
            placeholder="Enter Email"
            className="w-full px-4 py-2 text-black border border-blue-500 rounded-md focus:outline-none focus:border-white"
            value={username}
            onChange={(e) => setEmail(e.target.value)}
          />
        </div>
        <label htmlFor=""className='font-bold text-black pr-50'>Enter Your Password</label>
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
export default LoginPage;
