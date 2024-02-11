/* eslint-disable no-unused-vars */
// firebase.js
import { initializeApp, getApp, getApps } from "firebase/app";
import { getFirestore } from 'firebase/firestore';
import { getStorage } from "firebase/storage";
import { getAuth, GoogleAuthProvider, sendPasswordResetEmail as sendPasswordResetEmailFirebase } from "firebase/auth"; // Rename to avoid conflicts


const firebaseConfig = {
  apiKey: "AIzaSyDElkWJzEFuz_N6tfXlL7WPv7sAWdwwcos",
  authDomain: "health-junction-675ff.firebaseapp.com",
  projectId: "health-junction-675ff",
  storageBucket: "health-junction-675ff.appspot.com",
  messagingSenderId: "293812165856",
  appId: "1:293812165856:web:71c6e9d97a352ae11bc485",
  measurementId: "G-GJ84BD7RCH"
};

// Initialize Firebase
// Initialize Firebase
const app = !getApps().length ? initializeApp(firebaseConfig) : getApp();
const database = getFirestore(app);
const storage = getStorage(app);
const auth = getAuth(app);
const googleProvider = new GoogleAuthProvider();

// Export the sendPasswordResetEmail function
const sendPasswordResetEmail = async (email) => {
  return sendPasswordResetEmailFirebase(auth, email);
};

export { app, database, storage, auth, googleProvider, sendPasswordResetEmail };
