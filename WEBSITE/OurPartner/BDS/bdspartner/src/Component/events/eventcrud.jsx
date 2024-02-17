import React, { useEffect, useState } from "react";
import { collection, getDocs, doc, deleteDoc } from "firebase/firestore";
import { database } from "../../firebase";
import { Link } from "react-router-dom";
import { CSSTransition, TransitionGroup } from "react-transition-group";
import "./EventPage.css";

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

  const handleDelete = async (eventId) => {
    try {
      await deleteDoc(doc(database, "Event", eventId)); // Fixed the deleteDoc invocation
      setEvents((prevEvents) =>
        prevEvents.filter((event) => event.id !== eventId)
      );
      alert("Event deleted successfully");
    } catch (error) {
      console.error("Error deleting event:", error);
      alert("Failed to delete event");
    }
  };

  return (
    <div className="event-page">
      <h1 className="event-page-title">Event Details</h1>
      <table className="event-table">
        <thead>
          <tr>
            <th>Event Name</th>
            <th>Description</th>
            <th>Date</th>
            <th>Time</th>
            <th>Image</th>
            <th>Action</th>
          </tr>
        </thead>
        <TransitionGroup component="tbody">
          {events.map((event) => (
            <CSSTransition key={event.id} classNames="fade" timeout={300}>
              <tr>
                <td>{event.eventName}</td>
                <td>{event.description}</td>
                <td>{event.date}</td>
                <td>{event.time}</td>
                <td>
                  <img
                    src={event.imageUrl}
                    alt="Event"
                    className="event-image"
                  />
                </td>
                <td>
                  <button
                    className="delete-button"
                    onClick={() => handleDelete(event.id)}
                  >
                    Delete
                  </button>
                  <Link to={`/updateEventPage/${event.id}`}>
                    <button   className="update-button">Update</button>
                  </Link>
                </td>
              </tr>
            </CSSTransition>
          ))}
        </TransitionGroup>
      </table>
    </div>
  );
};

export default EventPage;
