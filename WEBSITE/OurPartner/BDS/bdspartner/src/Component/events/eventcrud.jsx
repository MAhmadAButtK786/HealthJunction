import React, { useEffect, useState } from 'react';
import { collection, getDocs, deleteDoc } from 'firebase/firestore';
import { database } from '../../firebase';
import {Link} from "react-router-dom";
import { CSSTransition, TransitionGroup } from 'react-transition-group';
import './EventPage.css'; // Import CSS file for styling

const EventPage = () => {
  const [events, setEvents] = useState([]);

  useEffect(() => {
    const fetchEvents = async () => {
      const eventsCollection = collection(database, 'Event');
      const eventsSnapshot = await getDocs(eventsCollection);
      const eventsData = eventsSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
      setEvents(eventsData);
    };

    fetchEvents();
  }, []);

  const handleDelete = async (eventId) => {
    try {
      await deleteDoc(collection(database, 'Event', eventId));
      setEvents(prevEvents => prevEvents.filter(event => event.id !== eventId));
      alert('Event deleted successfully');
    } catch (error) {
      console.error('Error deleting event:', error);
      alert('Failed to delete event');
    }
  };

  return (
    <div>
      <h1>Event Details</h1>
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
          {events.map(event => (
            <CSSTransition key={event.id} classNames="fade" timeout={300}>
              <tr>
                <td>{event.eventName}</td>
                <td>{event.description}</td>
                <td>{event.date}</td>
                <td>{event.time}</td>
                <td><img src={event.imageUrl} alt="Event" style={{ maxWidth: '200px' }} /></td>
                <td>
                  <button onClick={() => handleDelete(event.id)}>Delete</button>
                  {/* Add update button here */}
                 <Link to="/updateEventPage">
                 <button>Update</button>
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
