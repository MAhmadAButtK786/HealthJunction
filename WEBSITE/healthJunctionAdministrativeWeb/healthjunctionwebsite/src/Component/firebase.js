/* eslint-disable no-unused-vars */
// firebase.js
import { initializeApp } from "firebase/app";
import { getFirestore } from 'firebase/firestore';
import { getStorage } from "firebase/storage";
import { getAuth, GoogleAuthProvider, sendPasswordResetEmail as sendPasswordResetEmailFirebase } from "firebase/auth";


const firebaseConfig = {
  apiKey: "AIzaSyDElkWJzEFuz_N6tfXlL7WPv7sAWdwwcos",
  authDomain: "health-junction-675ff.firebaseapp.com",
  projectId: "health-junction-675ff",
  storageBucket: "health-junction-675ff.appspot.com",
  messagingSenderId: "293812165856",
  appId: "1:293812165856:web:d0a2e1cfe1f1cbba1bc485",
  measurementId: "G-RLDCY49C88"
};

const app = initializeApp(firebaseConfig);
const database = getFirestore(app);
const storage = getStorage(app);
const auth = getAuth(app);
const googleProvider = new GoogleAuthProvider();

const sendPasswordResetEmail = async (email) => {
  return sendPasswordResetEmailFirebase(auth, email);
};

export { app, database, storage, auth, googleProvider, sendPasswordResetEmail };