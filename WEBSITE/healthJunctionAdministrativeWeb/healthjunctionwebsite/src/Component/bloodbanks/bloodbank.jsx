import React from 'react'
import BBNavbar from './BBNavbar'
import BloodBankHomePage from './bbHome/bloodhome'
import Footer from '../footer'
export default function bloodbank() {
  return (
    <div>
      <BBNavbar/>
      <BloodBankHomePage/>
      <Footer/>
    </div>
  )
}
