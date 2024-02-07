// Contact.js
import React from 'react';
import Navbar from '../components/Navbar';
import Footer from '../components/Footer';
import AboutUs from './about';
import Contactcards from './contactcards';
import ContactInfo from './contactInfo';
const Contact = () => {
  return (
  <>
  <Navbar/>
  <AboutUs/>
 <Contactcards/>
 <ContactInfo/>
  <Footer/>
  </>
  );
};

export default Contact;
