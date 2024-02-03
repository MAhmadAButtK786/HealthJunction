import React from 'react'

function PartnerDetails() {
  return (
    <>
      <div className='p-4'>
        <h1 className='text-2xl text-center text-red-600 font-bold mb-4'>
          We are Proud To announce Blood Donor Society as our Partner
        </h1>
      </div>

      <div className='grid grid-cols-1 sm:grid-cols-2 gap-1 items-center justify-center pl-60'>
        <img className='w-40 h-40 object-cover mb-4 rounded-full' src="images/Logos/BDS.jpeg" alt="Blood Donor Society Logo" />
        <div className='text-center'>
          <p className='text-md leading-snug text-gray-800 font-semibold pr-40'>
            "Blood Donor Society is a non-profit organization dedicated to providing safe and adequate blood supply to those in need. Our mission is to save lives and improve health through the power of generosity."
          </p>
        </div>
      </div>
    </>
  )
}

export default PartnerDetails
