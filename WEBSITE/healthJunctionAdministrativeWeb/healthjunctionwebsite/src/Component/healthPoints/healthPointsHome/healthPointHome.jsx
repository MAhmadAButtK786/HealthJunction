import React from 'react'
import HPNavbar from '../hpNavbar';
import Footer from '../../footer';
import HPHomecards from './healthhadith';
import HPHomeCarousel from './carouselHP';
function HealthPointHome() {
  return (
    <>
    <HPNavbar/>
    <HPHomecards/>
    <HPHomeCarousel/>
    <Footer/>
    </>
  )
}

export default HealthPointHome;