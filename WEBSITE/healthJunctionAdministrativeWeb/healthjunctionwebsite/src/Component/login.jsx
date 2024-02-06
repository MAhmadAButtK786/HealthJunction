import React, { useState } from 'react';
import { getAuth, signInWithEmailAndPassword, signInWithPopup, GoogleAuthProvider } from 'firebase/auth';
import { useHistory, Link } from 'react-router-dom';
import { IoMdMail, IoMdLock } from 'react-icons/io';

const LoginPage = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const auth = getAuth();
  const googleProvider = new GoogleAuthProvider();
  const history = useHistory();

  const handleLogin = async (e) => {
    e.preventDefault();

    try {
      setLoading(true);
      const result = await signInWithEmailAndPassword(auth, email, password);
      const user = result.user;
      sessionStorage.setItem('username', user.email);
      setLoading(false);
      history.push('/home');
      alert('Successfully logged in with credentials!');
    } catch (error) {
      setLoading(false);
      alert('Something went wrong with Signing In: ' + error.message);
    }
  };

  const handleGoogleSignIn = async () => {
    try {
      setLoading(true);
      const result = await signInWithPopup(auth, googleProvider);
      const user = result.user;
      sessionStorage.setItem('username', user.email);
      setLoading(false);
      history.push('/home');
      alert('Successfully signed up with Google!');
    } catch (error) {
      setLoading(false);
      alert('Google Sign In Error: ' + error.message);
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
            value={email}
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
        <button
          type="button"
          className={`w-full py-2 rounded-md ${
            loading ? 'bg-gray-500 cursor-not-allowed' : 'bg-gray-700 hover:bg-red-600'
          } text-white focus:outline-none mb-4 flex justify-center items-center`}
          onClick={handleGoogleSignIn}
          disabled={loading}
        >
         <img src="images/Logos/google icon.png" alt=""  width={50} height={50} className="p-3"/>
          {loading ? 'Logging In with Google...' : 'Sign in with Google'}
        </button>
        <div className="text-sm text-black">
          Don't have an account?
          <Link to="/register" className="text-blue-500">
            Register
          </Link>
        </div>
        <div className="mt-2 text-sm">
          <Link to="/forgetPassword" className="text-blue-500">
            Forgot Password?
          </Link>
        </div>
      </form>
    </div>
  );
};
export default LoginPage;
