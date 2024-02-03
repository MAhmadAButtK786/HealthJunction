import React from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";

function PartnerDetails() {
  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1 }}>
      <div className="pt-4">
        <h1 className="text-4xl font-bold text-center text-red-600 ">
          We are Proud To announce our Partner
        </h1>
      </div>

      <section className="bg-white dark:bg-gray-900">
        <div className="grid max-w-screen-xl px-4 py-8 mx-auto lg:gap-8 xl:gap-0 lg:py-16 lg:grid-cols-12 sm:grid-cols-1 md:grid-cols-2">
          <div className="mx-auto lg:mt-0 lg:col-span-3 lg:flex lg:items-center sm:order-1 md:order-2">
            <img
              src="images/Logos/BDS.jpeg"
              alt="Blood Donor Society"
              className="object-cover w-full h-auto rounded-lg lg:rounded-r-lg lg:w-auto lg:h-auto sm:w-full sm:h-48 md:w-full md:h-64"
            />
          </div>
          <div className="mx-auto lg:col-span-7 lg:mx-0 sm:order-2 md:order-1">
            <h1 className="max-w-2xl mb-4 text-4xl font-extrabold leading-none tracking-tight text-red-600 md:text-5xl xl:text-6xl dark:text-white">
              Blood Donor Society
            </h1>
            <p className="max-w-2xl mb-6 font-light text-black lg:mb-8 md:text-lg lg:text-xl dark:text-white">
              Blood Donor Society (BDS), born from the altruistic spirit of UET
              KSK, is a charitable organization dedicated to providing free
              blood donations. Committed to the cause of saving lives, BDS
              actively promotes voluntary blood donation through awareness
              campaigns and workshops. Their impactful work not only addresses
              the immediate need for blood but also fosters a sense of
              responsibility within the community, embodying the essence of
              selfless service.
            </p>
            <Link
              to="#"
              className="inline-flex items-center justify-center px-5 py-3 mr-3 text-base font-medium text-center text-white bg-red-700 rounded-lg hover:bg-red-800 focus:ring-4 focus:ring-red-300 dark:focus:ring-red-900"
            >
              Get started
              <svg
                className="w-5 h-5 ml-2 -mr-1"
                fill="currentColor"
                viewBox="0 0 20 20"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fillRule="evenodd"
                  d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
                  clipRule="evenodd"
                />
              </svg>
            </Link>
            <Link
              to="#"
              className="inline-flex items-center justify-center px-5 py-3 text-base font-medium text-center text-gray-900 border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 dark:text-white dark:border-gray-700 dark:hover:bg-gray-700 dark:focus:ring-gray-800"
            >
              Speak to Organization
            </Link>
          </div>
        </div>
      </section>
    </motion.div>
  );
}

export default PartnerDetails;
