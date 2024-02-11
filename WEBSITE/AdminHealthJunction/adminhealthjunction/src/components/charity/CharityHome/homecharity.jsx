import React from 'react'
import CharityNavbar from '../charityNavbar'
import Footer from '../../Footer';
import CHomecards from './homecards';
import Roundedpic from './Roundedpic';
import CStory from './story';
function Homecharity() {
  return (
    <div>
      <CharityNavbar/>
      <CHomecards/>
      <CStory />
      <Roundedpic/>
      <Footer/>
    </div>
  )
}

export default Homecharity;
