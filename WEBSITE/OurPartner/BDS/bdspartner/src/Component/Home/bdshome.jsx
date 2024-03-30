import React from 'react'
import Navbar from '../Navbar'
import Footer from '../Footer'
import BloodTypeChart2 from './charts2Donor'
import ContentSection from './cards'
function BDSHome() {
  return (
    <>
    <Navbar/>
  <BloodTypeChart2/>
    <ContentSection/>
    <Footer/>
    </>
  )
}

export default BDSHome