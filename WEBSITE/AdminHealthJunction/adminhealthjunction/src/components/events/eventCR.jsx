import React from 'react'
import EventNavbar from './eventnavbar'
import EventPage from './eventcrud'
import Footer from '../Footer'
function EventCR() {
  return (
    <div>
    <EventNavbar/>
      <EventPage/>
      <Footer/>
    </div>
  )
}

export default EventCR
