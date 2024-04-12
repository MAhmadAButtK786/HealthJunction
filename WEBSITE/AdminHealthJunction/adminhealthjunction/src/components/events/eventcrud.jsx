import React, { useEffect, useState } from "react";
import { collection, getDocs, deleteDoc, doc } from "firebase/firestore";
import { database } from "../../firebase";
import { Link } from "react-router-dom";
import { CSSTransition, TransitionGroup } from "react-transition-group";
import "./EventPage.css";

const EventPage = () => {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      try {
        const eventCollection = collection(database, "Event");
        const eventAdminsCollection = collection(database, "EventAdmins");

        const eventSnapshot = await getDocs(eventCollection);
        const eventAdminsSnapshot = await getDocs(eventAdminsCollection);

        const eventData = eventSnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
          isOpen: false, // Adding isOpen property for toggle functionality
        }));

        const eventAdminsData = eventAdminsSnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
          isOpen: false, // Adding isOpen property for toggle functionality
        }));

        // Merge both arrays
        const mergedEvents = [...eventData, ...eventAdminsData];

        setEvents(mergedEvents);
      } catch (error) {
        console.error("Error fetching events:", error);
      }
    };

    fetchEvents();
  }, []);

  const handleDelete = async (eventId) => {
    try {
      await deleteDoc(doc(database, "Event", eventId));
      await deleteDoc(doc(database, "EventAdmins", eventId));
      setEvents((prevEvents) =>
        prevEvents.filter((event) => event.id !== eventId)
      );
      alert("Event deleted successfully");
    } catch (error) {
      console.error("Error deleting event:", error);
      alert("Failed to delete event");
    }
  };

  const toggleEvent = (id) => {
    setEvents((prevEvents) =>
      prevEvents.map((event) =>
        event.id === id ? { ...event, isOpen: !event.isOpen } : event
      )
    );
  };

  return (
    <div className="event-page">
      <h1 className="event-page-title">Event Details</h1>
      <div className="button-container">
        <Link to="/eventuploader">
          <button className="insert-button">Insert Event</button>
        </Link>
      </div>
      <TransitionGroup component="div">
        {events.map((event) => (
          <CSSTransition key={event.id} classNames="fade" timeout={300}>
            <div className="event-card">
              <div className="event-card-header" onClick={() => toggleEvent(event.id)}>
                <h2 className="event-card-title">{event.eventName}</h2>
                <button className="toggle-button">{event.isOpen ? 'Close' : 'Open'}</button>
              </div>
              {event.isOpen && (
                <div className="event-card-body">
                  <p>Description: {event.description}</p>
                  <p>Date: {event.date}</p>
                  <p>Time: {event.time}</p>
                  <p>Location: <a href={`https://www.google.com/maps?q=${encodeURIComponent(event.location)}`} target="_blank" rel="noopener noreferrer">{event.location}</a></p>
                  <p>Image: <img src={event.imageUrl} alt="Event" className="event-image" /></p>
                  <div className="button-container">
                    <button className="delete-button" onClick={() => handleDelete(event.id)}>Delete</button>
                    <Link to={`/updateEventPage/${event.id}`}>
                      <button className="update-button">Update</button>
                    </Link>
                  </div>
                </div>
              )}
            </div>
          </CSSTransition>
        ))}
      </TransitionGroup>
    </div>
  );
};

export default EventPage;
