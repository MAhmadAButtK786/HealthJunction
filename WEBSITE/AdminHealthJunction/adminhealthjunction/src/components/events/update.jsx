import React, { useEffect, useState } from 'react';
import { doc, getDoc, updateDoc } from 'firebase/firestore'; // Import Firestore modules
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage'; // Import Storage modules
import { useHistory, useParams } from 'react-router-dom'; // Import necessary hooks from react-router-dom
import { database, storage } from '../../firebase'; // Import Firebase configurations

const UpdateEventPage = () => {
  const { id } = useParams(); // Get the ID from URL parameters
  const history = useHistory(); // Initialize useHistory hook for navigation
  const [eventData, setEventData] = useState({ // Initialize state variables
    eventName: '',
    description: '',
    date: '',
    time: '',
    imageUrl: ''
  });
  const [imageFile, setImageFile] = useState(null); // State variable for storing image file
  const [loading, setLoading] = useState(false); // State variable for loading indicator

  // Fetch event data from Firestore based on the provided ID when the component mounts
  useEffect(() => {
    const fetchEvent = async () => {
      setLoading(true); // Set loading indicator to true
      try {
        const eventDoc = doc(database, 'Event', id); // Get reference to the event document
        const eventSnapshot = await getDoc(eventDoc); // Get snapshot of the event document
        if (eventSnapshot.exists()) {
          setEventData({ id: eventSnapshot.id, ...eventSnapshot.data() }); // Set event data in state
        } else {
          console.log('No such document!');
        }
      } catch (error) {
        console.error('Error fetching event:', error);
      }
      setLoading(false); // Set loading indicator to false
    };

    fetchEvent(); // Call fetchEvent function
  }, [id]); // Run useEffect whenever ID changes

  // Event handler for updating event data
  const handleUpdate = async (e) => {
    e.preventDefault(); // Prevent default form submission behavior
    setLoading(true);
    try {
      if (imageFile) { 
        const storageRef = ref(storage, `eventImages/${imageFile.name}`); 
        await uploadBytesResumable(storageRef, imageFile); 
        const imageUrl = await getDownloadURL(storageRef); 
        await updateEventData({ ...eventData, imageUrl }); 
      } else {
        await updateEventData(eventData); 
      }
      alert('Event updated successfully'); // Show success message
      history.push('/event'); 
    } catch (error) {
      console.error('Error updating event:', error);
      alert('Failed to update event'); // Show error message
    }
    setLoading(false); // Set loading indicator to false
  };

  // Helper function to update event data in Firestore
  const updateEventData = async (data) => {
    const eventDoc = doc(database, 'Event', id); // Get reference to the event document
    await updateDoc(eventDoc, data); // Update event document with new data
    setEventData(data); // Update local state with new event data
  };

  // Event handler for handling changes in form fields
  const handleChange = (e) => {
    setEventData({ ...eventData, [e.target.name]: e.target.value }); // Update corresponding state variable
  };

  // Event handler for handling changes in image file input
  const handleImageChange = (e) => {
    setImageFile(e.target.files[0]); // Update image file state variable
  };

  // Show loading indicator if data is still loading
  if (loading) return <div>Loading...</div>;

  // Render form for updating event data
  return (
    <div className='flex flex-col items-center justify-center h-screen'>
      <form className='flex flex-col items-center justify-center w-full max-w-md gap-4 px-10 py-5 bg-gray-400' onSubmit={handleUpdate}>
        <h2 className='text-xl font-bold'>Edit Details</h2>
        <input 
          type="text" 
          placeholder='Enter Event Name' 
          className='w-full px-4 py-2 border border-gray-300 rounded-md outline-none' 
          value={eventData.eventName}
          name="eventName"
          onChange={handleChange}
        />
        <textarea 
          placeholder='Enter Description' 
          className='w-full px-4 py-2 border border-gray-300 rounded-md outline-none' 
          value={eventData.description}
          name="description"
          onChange={handleChange}
        />
        <input 
          type="date" 
          placeholder='Enter Date' 
          className='w-full px-4 py-2 border border-gray-300 rounded-md outline-none' 
          value={eventData.date}
          name="date"
          onChange={handleChange}
        />
        <input 
          type="time" 
          placeholder='Enter Time' 
          className='w-full px-4 py-2 border border-gray-300 rounded-md outline-none' 
          value={eventData.time}
          name="time"
          onChange={handleChange}
        />
        <input 
          type="file" 
          onChange={handleImageChange}
        />
        {imageFile && <img src={URL.createObjectURL(imageFile)} alt="Preview" style={{ width: '100px' }} />}
        <div className="flex justify-between w-full">
          <button 
            type='submit'
            className='w-full p-2 text-white bg-blue-500 rounded-full'
          >Update</button>
          <button 
            type='button'
            className='w-full p-2 text-white bg-gray-500 rounded-full'
            onClick={() => history.goBack()}
          >Back</button>
        </div>
      </form>
    </div>
  );
};

export default UpdateEventPage;
