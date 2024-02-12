import React from 'react'
import Navbar from '../Navbar'
import Footer from '../Footer'
import BDSDetails from './Introduction'
import ContentSection from './cards'
function BDSHome() {
  return (
    <>
    <Navbar/>
    <BDSDetails/>
    <ContentSection/>
    <Footer/>
    </>
  )
}

export default BDSHome