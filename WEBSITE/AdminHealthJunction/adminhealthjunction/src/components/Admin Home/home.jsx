// Home.js
import React from "react";
import Navbar from "../Navbar";
import Footer from "../Footer";
import Cards from "./Cards";
import CAHomecards from "./ayatcontent";
import HomeCarousel from "./carouselImage";
const Home = () => {
  return (
    <div>
      <Navbar />
      <CAHomecards/>
      <HomeCarousel/>
     <Cards/>
      <Footer/>
    </div>
  );
};

export default Home;
