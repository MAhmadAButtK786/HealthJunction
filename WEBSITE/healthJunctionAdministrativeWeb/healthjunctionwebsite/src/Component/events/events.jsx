import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../firebase";
import "./EventPage.css";
const EventCard = ({ event }) => {
    return (
      <div className="max-w-md m-3 mx-auto overflow-hidden shadow-md rounded-xl md:max-w-2xl bg-blue-50">
        <div className="md:flex">
          <div className="md:flex-shrink-0">
            <img className="object-cover w-full h-48 md:w-48" src={event.imageUrl} alt="Event" />
          </div>
          <div className="p-8">
            <div className="text-sm font-semibold tracking-wide text-indigo-500 uppercase">{event.eventName}</div>
            <p className="mt-2 text-lg text-gray-500">{event.description}</p>
            <p className="mt-2 text-base text-gray-500">{event.date} - {event.time}</p>
          </div>
        </div>
      </div>
    );
  };
  
  

const EventPage = () => {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      const eventsCollection = collection(database, "Event");
      const eventsSnapshot = await getDocs(eventsCollection);
      const eventsData = eventsSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));
      setEvents(eventsData);
    };

    fetchEvents();
  }, []);

  return (
    <div className="event-page">
      <h1 className="pt-4 text-5xl font-bold text-center text-blue-600 event-page-title">Event Details</h1>
      <div className="event-cards-container">
        {events.map((event) => (
          <EventCard key={event.id} event={event} />
        ))}
      </div>
    </div>
  );
};

export default EventPage;
