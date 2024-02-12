// Home.js
import React from "react";
import Navbar from "../navbar";
import Footer from "../footer";
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
