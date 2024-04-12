import React, { useEffect, useState } from 'react';
import { doc, getDoc, updateDoc } from 'firebase/firestore'; 
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage'; 
import { useHistory, useParams } from 'react-router-dom'; 
import { database, storage } from '../../firebase'; 

const UpdateEventPage = () => {
  const { id } = useParams(); 
  const history = useHistory(); 
  const [eventData, setEventData] = useState({
    eventName: '',
    description: '',
    date: '',
    time: '',
    imageUrl: '',
    location: ''
  });
  const [imageFile, setImageFile] = useState(null); 
  const [loading, setLoading] = useState(false); 
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchEvent = async () => {
      setLoading(true); 
      try {
        const eventDoc = doc(database, 'Event', id); 
        const eventAdminsDoc = doc(database, 'EventAdmins', id); 
        const eventSnapshot = await getDoc(eventDoc); 
        const eventAdminsSnapshot = await getDoc(eventAdminsDoc); 
        
        if (eventSnapshot.exists()) {
          const eventData = eventSnapshot.data();
          setEventData({
            id: eventSnapshot.id,
            eventName: eventData.eventName || '',
            description: eventData.description || '',
            date: eventData.date || '',
            time: eventData.time || '',
            imageUrl: eventData.imageUrl || '',
            location: eventData.location || ''
          });
        } else if (eventAdminsSnapshot.exists()) {
          const eventAdminsData = eventAdminsSnapshot.data();
          setEventData({
            id: eventAdminsSnapshot.id,
            eventName: eventAdminsData.eventName || '',
            description: eventAdminsData.description || '',
            date: eventAdminsData.date || '',
            time: eventAdminsData.time || '',
            imageUrl: eventAdminsData.imageUrl || '',
            location: eventAdminsData.location || ''
          });
        } else {
          console.log('No such document in either collection!');
        }
      } catch (error) {
        console.error('Error fetching event:', error);
      }
      setLoading(false); 
    };
  
    fetchEvent(); 
  }, [id]);
  

  const handleUpdate = async (e) => {
    e.preventDefault(); 
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

      const eventDoc = doc(database, 'Event', id); 
      await updateDoc(eventDoc, eventData); 

      const eventAdminsDoc = doc(database, 'EventAdmins', id); 
      await updateDoc(eventAdminsDoc, eventData); 

      alert('Event updated successfully'); 
      history.push('/event'); 
    } catch (error) {
      console.error('Error updating event:', error);
      alert('Failed to update event');
    } finally {
      setLoading(false); 
    }
  };

  const updateEventData = async (data) => {
    const eventDoc = doc(database, 'Event', id); 
    await updateDoc(eventDoc, data); 
    setEventData(data); 
  };

  const handleChange = (e) => {
    setEventData({ ...eventData, [e.target.name]: e.target.value }); 
  };

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    setImageFile(file);
    setEventData({ ...eventData, imageUrl: URL.createObjectURL(file) });
  };

  if (loading) return <div>Loading...</div>;

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
          type="text" 
          placeholder='Enter Location' 
          className='w-full px-4 py-2 border border-gray-300 rounded-md outline-none' 
          value={eventData.location}
          name="location"
          onChange={handleChange}
        />
        <input 
          type="file" 
          onChange={handleImageChange}
        />
        {eventData.imageUrl && <img src={eventData.imageUrl} alt="Preview" style={{ width: '100px' }} />}
        {error && <div className="error-message">{error}</div>} {/* Display error message */}
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
