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
      <div className="container px-4 py-8 mx-auto">
  <h1 className="mb-4 text-4xl font-bold text-center text-blue-600">Welcome to the Administration Panel</h1>
  <p className="text-lg text-center text-gray-700">Manage all administrative tasks from here</p>
</div>

      <HomeCarousel/>
     <Cards/>
      <Footer/>
    </div>
  );
};

export default Home;
