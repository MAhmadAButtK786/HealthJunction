import React from "react";
import { Link } from "react-router-dom";
import { motion } from "framer-motion";

function BDSDetails() {
  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1 }}>
      <div className="pt-4">
        <h1 className="text-4xl font-bold text-center text-red-600 ">
          In the Collaboration with Health Junction
        </h1>
      </div>

      <section className="text-gray-600 body-font">
      <div className="container mx-auto flex px-5 py-24 md:flex-row flex-col items-center">
        <div className="lg:max-w-lg lg:w-full md:w-1/2 w-5/6 mb-10 md:mb-0">
          <img className="object-cover object-center rounded" alt="BDS" src="images/Logos/BDS.jpeg" />
        </div>
        <div className="lg:flex-grow md:w-1/2 lg:pl-24 md:pl-16 flex flex-col md:items-start md:text-left items-center text-center">
          <h1 className="title-font sm:text-4xl text-3xl mb-4 font-bold text-red-600">
         Blood Donor Society
            <br className="hidden lg:inline-block" />
            <h3 className="text-xl text-center">Join to Save Life</h3>
          </h1>
          <p className="mb-8 leading-relaxed">
          Blood Donor Society (BDS), born from the altruistic spirit of UET
              KSK, is a charitable organization dedicated to providing free
              blood donations. Committed to the cause of saving lives, BDS
              actively promotes voluntary blood donation through awareness
              campaigns and workshops. Their impactful work not only addresses
              the immediate need for blood but also fosters a sense of
              responsibility within the community, embodying the essence of
              selfless service.
          </p>

        </div>
      </div>
    </section>
    </motion.div>
  );
}

export default BDSDetails;
