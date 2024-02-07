import React from 'react'
import HPNavbar from '../hpNavbar';
import Footer from '../../footer';
import HPHomecards from './healthhadith';
import HPHomeCarousel from './carouselHP';
import CardsHP from './cardsHP';
function HealthPointHome() {
  return (
    <>
    <HPNavbar/>
    <HPHomecards/>
    <HPHomeCarousel/>
    <CardsHP/>
    <Footer/>
    </>
  )
}

export default HealthPointHome;