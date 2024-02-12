import React from "react";

const Cards = () => {
  return (
    <>
      {/* component */}
      <div
        id="services"
        className="relative pt-20 pb-8 bg-white section md:pt-16 md:pb-0"
      >
        <div className="container px-4 mx-auto xl:max-w-6xl">
          {/* Heading start */}
          <header className="mx-auto mb-5 text-center lg:px-20">
            <h2 className="mb-2 text-2xl font-bold leading-normal text-blue-700">
              What you can do as an Administrator
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
            <p className="mx-auto text-xl font-light leading-relaxed text-gray-700 ">
              <h3>Have Control on</h3>
            </p>
          </header>
          {/* End heading */}
          {/* row */}
          <div className="flex flex-row flex-wrap -mx-4 text-center">
            <div
              className="flex-shrink w-full max-w-full px-4 sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="px-12 py-8 mb-12 transition duration-300 ease-in-out transform border-b border-gray-100 bg-gray-50 hover:-translate-y-2">
                <div className="inline-block mb-4 text-gray-900">
                  {/* icon */}
                  <i
                    className="fas fa-hospital"
                    style={{ fontSize: "2rem", color: "blue" }}
                  ></i>
                </div>
                <h3 className="mb-2 text-lg font-semibold leading-normal text-black">
                  Health Points
                </h3>
                <p className="text-gray-500">
                  Verify and manage hospital eligibility, oversee clinics, patients, and
                  users for registration purposes.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink w-full max-w-full px-4 sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
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
              <div className="px-12 py-8 mb-12 transition duration-300 ease-in-out transform border-b border-gray-100 bg-gray-50 hover:-translate-y-2">
                <div className="inline-block mb-4 text-gray-900">
                  {/* icon */}
                  <i
                    className="fas fa-user-md"
                    style={{ fontSize: "2rem", color: "currentColor" }}
                  ></i>
                </div>
                <h3 className="mb-2 text-lg font-semibold leading-normal text-black">
                  Patients
                </h3>
                <p className="text-gray-500">
                  Manage and oversee user appointments, access detailed hospital and clinic
                  information as an administrator.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink w-full max-w-full px-4 sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
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
              <div className="px-12 py-8 mb-12 transition duration-300 ease-in-out transform border-b border-gray-100 bg-gray-50 hover:-translate-y-2">
                <div className="inline-block mb-4 text-gray-900">
                  {/* icon */}
                  <i
                    className="fas fa-tint"
                    style={{ fontSize: "2rem", color: "red" }}
                  ></i>
                </div>
                <h3 className="mb-2 text-lg font-semibold leading-normal text-black">
                  Blood Banks
                </h3>
                <p className="text-gray-500">
                  Oversee and Manage donor and recipient registration and
                  details of private and public blood banks.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink w-full max-w-full px-4 sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
              data-wow-duration="1s"
              style={{
                visibility: "visible",
                animationDuration: "1s",
                animationName: "fadeInUp",
              }}
            >
              {/* service block */}
              <div className="px-12 py-8 mb-12 transition duration-300 ease-in-out transform border-b border-gray-100 bg-gray-50 hover:-translate-y-2">
                <div className="inline-block mb-4 text-gray-900">
                  {/* icon */}
                  <i
                    className="fas fa-hands-helping"
                    style={{ fontSize: "2rem", color: "purple" }}
                  ></i>
                </div>
                <h3 className="mb-2 text-lg font-semibold leading-normal text-black">
                  Charity
                </h3>
                <p className="text-gray-500">
                  Provide users with detailed information about charitable
                  organizations, empowering informed decisions.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink w-full max-w-full px-4 sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
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
              <div className="px-12 py-8 mb-12 transition duration-300 ease-in-out transform border-b border-gray-100 bg-gray-50 hover:-translate-y-2">
                <div className="inline-block mb-4 text-gray-900">
                  {/* icon */}
                  <i
                    className="fas fa-flask"
                    style={{ fontSize: "2rem", color: "grey-900" }}
                  ></i>
                </div>
                <h3 className="mb-2 text-lg font-semibold leading-normal text-black">
                  Laboratories
                </h3>
                <p className="text-gray-500">
                  Supervise inventory, manage supplier relationships, coordinate
                  delivery logistics, and provide customer support.
                </p>
              </div>
              {/* end service block */}
            </div>
            <div
              className="flex-shrink w-full max-w-full px-4 sm:w-1/2 lg:w-1/3 lg:px-6 wow fadeInUp"
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
              <div className="px-12 py-8 mb-12 transition duration-300 ease-in-out transform border-b border-gray-100 bg-gray-50 hover:-translate-y-2">
                <div className="inline-block mb-4 text-gray-900">
                  {/* icon */}
                  <i
                    className="fas fa-pills"
                    style={{ fontSize: "2rem", color: "green" }}
                  ></i>
                </div>
                <h3 className="mb-2 text-lg font-semibold leading-normal text-black">
                  Medicine
                </h3>
                <p className="text-gray-500">
                Supervise inventory, manage supplier relationships, coordinate delivery logistics, and provide customer support.
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

export default Cards;
