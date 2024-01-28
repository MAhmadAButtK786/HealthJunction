import React from "react";
import "./Rounded.css"; // Import a CSS file for your custom styles

function Roundedpic() {
  return (
    <>
      <div className="container">
        <p className="text-2xl text-purple-900 font-bold p-4 md:p-8 text-center">
          "Consider supporting an organization that aligns with your values and
          has a positive impact, deserving of your charitable contributions."
        </p>
      </div>
      <div className="flex flex-wrap justify-center gap-6 sm:gap-8 md:gap-10 lg:gap-12 py-4 sm:py-6 md:py-10 px-4 sm:px-6 md:px-10 lg:px-12">
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        {/* Repeat the above div structure for other images */}
      </div>
      <div className="flex flex-wrap justify-center gap-6 sm:gap-8 md:gap-10 lg:gap-12 py-4 sm:py-6 md:py-10 px-4 sm:px-6 md:px-10 lg:px-12">
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        <div className="flex-1 sm:w-1/2 md:w-1/3 lg:w-1/4 max-h-md transform hover:scale-105 transition-transform duration-300 ease-in-out">
          <img src="images/Blood.png" alt="" className="rounded-full object-cover w-full h-full" />
        </div>
        {/* Repeat the above div structure for other images */}
      </div>
    </>
  );
}

export default Roundedpic;
