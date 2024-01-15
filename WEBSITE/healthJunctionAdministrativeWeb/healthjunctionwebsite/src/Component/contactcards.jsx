import React from "react";

const Contactcards = () => {
  return (
    <>
      {/* First Row */}
      <div className="sm:flex sm:justify-center mb-8 ">
        {/* Card 1 */}
        <div className="flex flex-col rounded-lg bg-white shadow-lg mx-4 overflow-hidden transform transition-transform hover:scale-105">
          <a href="#!">
            <img
              className="rounded-t-lg w-full h-40 object-cover"
              src="images/Icons Health.JPG"
              alt="Health Points"
            />
          </a>
          <div className="p-4">
            <h5 className="mb-2 text-xl font-medium leading-tight dark:text-neutral-50 text-blue-700">
              Health Points
            </h5>
            <p className="mb-4 text-base text-neutral-600 dark:text-neutral-200">
            Hospitals and Clinics can register themselves by providing details of there facilities and vice versa.
            </p>
          </div>
        </div>

        {/* Card 2 */}
        <div className="flex flex-col rounded-lg bg-white shadow-lg mx-4 overflow-hidden transform transition-transform hover:scale-105">
          <a href="#!">
            <img
              className="rounded-t-lg w-full h-40 object-cover"
              src="images/Patient3.jpg"
              alt="Patient"
            />
          </a>
          <div className="p-4">
            <h5 className="mb-2 text-xl font-medium leading-tight text-blue-400 dark:text-neutral-50">
              Patient
            </h5>
            <p className="mb-4 text-base text-neutral-600 dark:text-neutral-200">
            Users can book appointments with doctors and see the hospital and clinic details. 
            </p>
          </div>
        </div>

        {/* Card 3 */}
        <div className="flex flex-col rounded-lg bg-white shadow-lg mx-4 overflow-hidden transform transition-transform hover:scale-105">
          <a href="#!">
            <img
              className="rounded-t-lg w-full h-40 object-cover"
              src="images/dr2.jpg"
              alt="Patient"
            />
          </a>
          <div className="p-4">
            <h5 className="mb-2 text-xl font-medium leading-tight text-red-700 dark:text-neutral-50">
              Blood Banks
            </h5>
            <p className="mb-4 text-base text-neutral-600 dark:text-neutral-200">
            Users can register as a donor and recipient, also see details of private and public blood banks.
            </p>
          </div>
        </div>


      {/* Second Row */}
      <div className="flex flex-col rounded-lg bg-white shadow-lg mx-4 overflow-hidden transform transition-transform hover:scale-105">
          <a href="#!">
            <img
              className="rounded-t-lg w-full h-40 object-cover"
              src="images/Charity.jpg"
              alt="Patient"
            />
          </a>
          <div className="p-4">
            <h5 className="mb-2 text-xl font-medium leading-tight text-purple-700 dark:text-neutral-50">
              Charity
            </h5>
            <p className="mb-4 text-base text-neutral-600 dark:text-neutral-200">
            Users can see details of charitable organizations they want to donate to.
            </p>
          </div>
        </div>

        {/* Card 5 */}
        <div className="flex flex-col rounded-lg bg-white shadow-lg mx-4 overflow-hidden transform transition-transform hover:scale-105">
          <a href="#!">
            <img
              className="rounded-t-lg w-full h-40 object-cover"
              src="images/Labor.png"
              alt="Labs"
            />
          </a>
          <div className="p-4">
            <h5 className="mb-2 text-xl font-medium leading-tight text-grey-900 dark:text-neutral-50">
              Laboratories
            </h5>
            <p className="mb-4 text-base text-neutral-600 dark:text-neutral-200">
            Users can see details of both private and public laboratories like there pricing.
            </p>
          </div>
        </div>

        {/* Card 6 */}
        <div className="flex flex-col rounded-lg bg-white shadow-lg mx-4 overflow-hidden transform transition-transform hover:scale-105">
          <a href="#!">
            <img
              className="rounded-t-lg w-full h-40 object-cover"
              src="images/medicine copy.jpg"
              alt="Medicine"
            />
          </a>
          <div className="p-4">
            <h5 className="mb-2 text-xl font-medium leading-tight text-green-700 dark:text-neutral-50">
              Medicine
            </h5>
            <p className="mb-4 text-base text-neutral-600 dark:text-neutral-200">
            Users can buy medicine through the app which delivers medicine to your doorstep.
            </p>
          </div>
        </div>

      </div>
    </>
  );
};

export default Contactcards;
