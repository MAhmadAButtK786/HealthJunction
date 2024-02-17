import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { doc, getDoc, updateDoc } from 'firebase/firestore';
import { database } from '../../firebase';

const UpdateEventPage = () => {
  const { eventId } = useParams(); // Get eventId from route params
  const [event, setEvent] = useState({});
  const [updatedEventName, setUpdatedEventName] = useState('');
  const [updatedDescription, setUpdatedDescription] = useState('');
  const [updatedDate, setUpdatedDate] = useState('');
  const [updatedTime, setUpdatedTime] = useState('');

  useEffect(() => {
    const fetchEventData = async () => {
      try {
        const eventDoc = doc(database, 'Event', eventId);
        const eventSnapshot = await getDoc(eventDoc);
        if (eventSnapshot.exists()) {
          setEvent(eventSnapshot.data());
          setUpdatedEventName(eventSnapshot.data().eventName);
          setUpdatedDescription(eventSnapshot.data().description);
          setUpdatedDate(eventSnapshot.data().date);
          setUpdatedTime(eventSnapshot.data().time);
        } else {
          console.log('Event not found');
        }
      } catch (error) {
        console.error('Error fetching event:', error);
      }
    };

    fetchEventData();
  }, [eventId]);

  const handleUpdateEvent = async (e) => {
    e.preventDefault();
    try {
      const eventDocRef = doc(database, 'Event', eventId);
      await updateDoc(eventDocRef, {
        eventName: updatedEventName,
        description: updatedDescription,
        date: updatedDate,
        time: updatedTime,
      });
      alert('Event updated successfully');
    } catch (error) {
      console.error('Error updating event:', error);
    }
  };

  return (
    <div>
      <h1>Update Event</h1>
      <form onSubmit={handleUpdateEvent}>
        <label>Event Name:</label>
        <input type="text" value={updatedEventName} onChange={(e) => setUpdatedEventName(e.target.value)} />
        <label>Description:</label>
        <textarea value={updatedDescription} onChange={(e) => setUpdatedDescription(e.target.value)} />
        <label>Date:</label>
        <input type="date" value={updatedDate} onChange={(e) => setUpdatedDate(e.target.value)} />
        <label>Time:</label>
        <input type="time" value={updatedTime} onChange={(e) => setUpdatedTime(e.target.value)} />
        <button type="submit">Update Event</button>
      </form>
    </div>
  );
};

export default UpdateEventPage;
