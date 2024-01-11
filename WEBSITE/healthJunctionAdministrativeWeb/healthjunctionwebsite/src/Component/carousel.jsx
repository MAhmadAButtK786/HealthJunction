import React from "react";

const Carousel = () => {
  return (
    <>
      {/* component */}
      <div
        id="services"
        className="section relative pt-20 pb-8 md:pt-16 md:pb-0 bg-white"
      >
        <div className="container xl:max-w-6xl mx-auto px-4">
          {/* Heading start */}
          <header className="text-center mx-auto mb-12 lg:px-20">
            <h2 className="text-2xl leading-normal mb-2 font-bold text-black">
              What We Provide
            </h2>
            <svg
              version="1.1"
              xmlns="http://www.w3.org/2000/svg"
              xmlnsXlink="http://www.w3.org/1999/xlink"
              x="0px"
              y="0px"
              viewBox="0 0 100 60"
              style={{ margin: "0 auto", height: 35 }}
              xmlSpace="preserve"
            >
              <circle
                cx="50.1"
                cy="30.4"
                r={5}
                className="stroke-primary"
                style={{
                  fill: "transparent",
                  strokeWidth: 2,
                  strokeMiterlimit: 10,
                }}
              />
              <line
                x1="55.1"
                y1="30.4"
                x2={100}
                y2="30.4"
                className="stroke-primary"
                style={{ strokeWidth: 2, strokeMiterlimit: 10 }}
              />
              <line
                x1="45.1"
                y1="30.4"
                x2={0}
                y2="30.4"
                className="stroke-primary"
                style={{ strokeWidth: 2, strokeMiterlimit: 10 }}
              />
            </svg>
            <p className="text-gray-500 leading-relaxed font-light text-xl mx-auto pb-2">
              Wellness and Medical Care Save Lives.
            </p>
          </header>
          {/* End heading */}
          {/* row */}
          <div className="flex flex-wrap flex-row -mx-4 text-center">
            <div
              className="flex-shrink px-4 max-w-full w-full sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="py-8 px-12 mb-12 bg-gray-50 border-b border-gray-100 transform transition duration-300 ease-in-out hover:-translate-y-2">
                <div className="inline-block text-gray-900 mb-4">
                  {/* icon */}
                  <i
                    className="fas fa-hospital"
                    style={{ fontSize: '2rem', color: 'blue' }}
                  ></i>
                </div>
                <h3 className="text-lg leading-normal mb-2 font-semibold text-black">
                  Health Points
                </h3>
                <p className="text-gray-500">
                  Hospitals and Clinics can register themselves by providing details of there facilities and vice versa.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink px-4 max-w-full w-full sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              data-wow-delay=".1s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationDelay: "0.1s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="py-8 px-12 mb-12 bg-gray-50 border-b border-gray-100 transform transition duration-300 ease-in-out hover:-translate-y-2">
                <div className="inline-block text-gray-900 mb-4">
                  {/* icon */}
                  <i
                    className="fas fa-user-md"
                    style={{ fontSize: '2rem', color: 'currentColor' }}
                  ></i>
                </div>
                <h3 className="text-lg leading-normal mb-2 font-semibold text-black">
                  Patients
                </h3>
                <p className="text-gray-500">
                  Users can book appointments with doctors and see the hospital and clinic details. 
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink px-4 max-w-full w-full sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              data-wow-delay=".3s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationDelay: "0.3s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="py-8 px-12 mb-12 bg-gray-50 border-b border-gray-100 transform transition duration-300 ease-in-out hover:-translate-y-2">
                <div className="inline-block text-gray-900 mb-4">
                  {/* icon */}
                  <i
                    className="fas fa-tint"
                    style={{ fontSize: '2rem', color: 'red' }}
                  ></i>
                </div>
                <h3 className="text-lg leading-normal mb-2 font-semibold text-black">
                  Blood Banks
                </h3>
                <p className="text-gray-500">
                  Users can register as a donor and recipient, also see details of private and public blood banks.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink px-4 max-w-full w-full sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="py-8 px-12 mb-12 bg-gray-50 border-b border-gray-100 transform transition duration-300 ease-in-out hover:-translate-y-2">
                <div className="inline-block text-gray-900 mb-4">
                  {/* icon */}
                  <i
                    className="fas fa-hands-helping"
                    style={{ fontSize: '2rem', color: 'purple' }}
                  ></i>
                </div>
                <h3 className="text-lg leading-normal mb-2 font-semibold text-black">
                  Charity
                </h3>
                <p className="text-gray-500">
                  Users can see details of charitable organizations they want to donate to.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink px-4 max-w-full w-full sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              data-wow-delay=".1s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationDelay: "0.1s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="py-8 px-12 mb-12 bg-gray-50 border-b border-gray-100 transform transition duration-300 ease-in-out hover:-translate-y-2">
                <div className="inline-block text-gray-900 mb-4">
                  {/* icon */}
                  <i
                    className="fas fa-flask"
                    style={{ fontSize: '2rem', color: 'grey-900' }}
                  ></i>
                </div>
                <h3 className="text-lg leading-normal mb-2 font-semibold text-black">
                  Laboratories
                </h3>
                <p className="text-gray-500">
                  Users can see details of both private and public laboratories like there pricing.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink px-4 max-w-full w-full sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              data-wow-delay=".3s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationDelay: "0.3s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="py-8 px-12 mb-12 bg-gray-50 border-b border-gray-100 transform transition duration-300 ease-in-out hover:-translate-y-2">
                <div className="inline-block text-gray-900 mb-4">
                  {/* icon */}
                  <i
                    className="fas fa-pills"
                    style={{ fontSize: '2rem', color: 'green' }}
                  ></i>
                </div>
                <h3 className="text-lg leading-normal mb-2 font-semibold text-black">
                  Medicine
                </h3>
                <p className="text-gray-500">
                  Users can buy medicine through the app which delivers medicine to your doorstep.
                </p>
              </div>
              {/* end service block */}
            </div>
          </div>
          {/* end row */}
        </div>
      </div>
    </>
  );
};

export default Carousel;
