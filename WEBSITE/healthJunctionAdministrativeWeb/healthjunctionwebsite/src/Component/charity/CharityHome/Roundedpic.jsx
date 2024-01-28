import React from "react";
import "./Rounded.css"; // Import a CSS file for your custom styles

function Roundedpic() {
  return (
    <>
      <div className="container">
        <p className="p-4 text-2xl font-bold text-center text-purple-900 md:p-8">
          "Consider supporting an organization that aligns with your values and
          has a positive impact, deserving of your charitable contributions."
        </p>
      </div>
      <div className="flex flex-wrap justify-center gap-6 px-4 py-4 sm:gap-8 md:gap-10 lg:gap-12 sm:py-6 md:py-10 sm:px-6 md:px-10 lg:px-12">
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Logos/Aga Khan Foundation.png" alt="Aga Khan Foundation" className="object-cover w-full h-full rounded-full" />
        </div>
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Logos/Akhuwat Foundation.jpg" alt="Akhuwat Foundation" className="object-cover w-full h-full rounded-full" />
        </div>
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Logos/Al-Khidmat Foundation Pakistan.png" alt="Al-Khidmat Foundation Pakistan" className="object-cover w-full h-full rounded-full" />
        </div>
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Logos/Aurat Foundation.png" alt="Aurat Foundation" className="object-cover w-full h-full rounded-full" />
        </div>
        {/* Repeat the above div structure for other images */}
      </div>
      <div className="flex flex-wrap justify-center gap-6 px-4 py-4 sm:gap-8 md:gap-10 lg:gap-12 sm:py-6 md:py-10 sm:px-6 md:px-10 lg:px-12">
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Logos/ansar.png" alt="" className="object-cover w-full h-full rounded-full" />
        </div>
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Logos/chippa.png" alt="" className="object-cover w-full h-full rounded-full" />
        </div>
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Blood.png" alt="" className="object-cover w-full h-full rounded-full" />
        </div>
        <div className="flex-1 transition-transform duration-300 ease-in-out transform sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md hover:scale-105">
          <img src="images/Blood.png" alt="" className="object-cover w-full h-full rounded-full" />
        </div>
        {/* Repeat the above div structure for other images */}
      </div>
    </>
  );
}

export default Roundedpic;
