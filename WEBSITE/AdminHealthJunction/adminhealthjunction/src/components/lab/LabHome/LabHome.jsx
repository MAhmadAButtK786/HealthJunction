import React from 'react'
import LabNavbar from '../labNavbar';
import LabHomeContent from './LabHomeContent';
import LabDataHome from './LabSupporter';
import Footer from '../../Footer';
function LabsHome() {
  return (
    <>
    <LabNavbar/>
<LabHomeContent/>
<LabDataHome/>
<Footer/>
    </>
  )
}

export default LabsHome;