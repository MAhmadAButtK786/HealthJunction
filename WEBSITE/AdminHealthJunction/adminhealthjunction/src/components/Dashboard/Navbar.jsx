import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSignOutAlt } from '@fortawesome/free-solid-svg-icons';
import { useHistory } from 'react-router-dom';
import { auth } from '../../firebase'; // Import your Firebase authentication instance

const Navbar = () => {
  const history = useHistory();

  const handleLogout = async () => {
    try {
      // Sign out the user from Firebase
      await auth.signOut();
      console.log('User logged out');
      
      // Redirect to the login page after logout
      history.push('/');
    } catch (error) {
      console.error('Error logging out:', error.message);
    }
  };

  return (
    <div className="p-4 bg-blue-500 flex justify-between">
      <h1 className="text-3xl font-semibold text-white">Health Junction Admin Panel</h1>
      <button onClick={handleLogout} className="bg-blue-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded flex items-center">
        <FontAwesomeIcon icon={faSignOutAlt} className="mr-2" />
        Logout
      </button>
    </div>
  );
};

export default Navbar;
