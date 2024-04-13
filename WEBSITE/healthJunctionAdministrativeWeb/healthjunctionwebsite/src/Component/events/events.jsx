import React, { useEffect, useState } from "react";
import { collection, getDocs } from "firebase/firestore";
import { database } from "../firebase";
import "./EventPage.css";

const EventCard = ({ event }) => {
  const [descriptionExpanded, setDescriptionExpanded] = useState(false);
  const [imageZoomed, setImageZoomed] = useState(false);

  const handleLocationClick = () => {
    window.open(`https://www.google.com/maps?q=${encodeURIComponent(event.location)}`, "_blank");
  };

  const toggleDescription = () => {
    setDescriptionExpanded(!descriptionExpanded);
  };

  const toggleImageZoom = () => {
    setImageZoomed(!imageZoomed);
  };

  return (
    <div className="max-w-xl m-3 mx-auto overflow-hidden shadow-md rounded-xl md:max-w-2xl bg-blue-50">
      <div className="md:flex">
        <div className="md:flex-shrink-0">
          <img
            className={`object-cover w-full h-48 md:w-48 cursor-pointer ${imageZoomed ? "zoomed-in" : "zoomed-out"}`}
            src={event.imageUrl}
            alt="Event"
            onClick={toggleImageZoom}
          />
        </div>
        <div className="p-8">
          <div className="text-2xl font-bold tracking-wide text-indigo-700 uppercase ">{event.eventName}</div>
          <div className={`mt-2 text-xl text-black-700 font-bold ${descriptionExpanded ? "" : "truncate"}`} onClick={toggleDescription}>
            Event Description
          </div>
          {descriptionExpanded && (
            <div className="mt-2 text-lg text-green-700">{event.description}</div>
          )}
          <p className="mt-2 text-lg text-gray-500">Date: {event.date}</p>
          <p className="mt-2 text-lg text-gray-500">Time: {event.time}</p>
          {event.location && (
            <p className="mt-2 text-xl font-bold text-green-500 cursor-pointer" onClick={handleLocationClick}>
              Location: {event.location} (Click to <br /> open in Google Maps)
            </p>
          )}
        </div>
      </div>
    </div>
  );
};

const EventPage = () => {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      const eventCollection = collection(database, "Event");
      const eventAdminsCollection = collection(database, "EventAdmins");

      const eventSnapshot = await getDocs(eventCollection);
      const eventAdminsSnapshot = await getDocs(eventAdminsCollection);

      const eventData = eventSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      const eventAdminsData = eventAdminsSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      const mergedEvents = [...eventData, ...eventAdminsData];
      setEvents(mergedEvents);
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
