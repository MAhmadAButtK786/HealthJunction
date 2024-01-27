// Home.js
import React from "react";
import Navbar from "../navbar";
import Footer from "../footer";
import Carousel from "./carousel";
import CAHomecards from "./ayatcontent";
const Home = () => {
  return (
    <div>
      <Navbar />
      <CAHomecards/>
     <Carousel/>
      <Footer/>
    </div>
  );
};

export default Home;
