import React, { useEffect, useState } from 'react';
import { doc, getDoc, updateDoc } from 'firebase/firestore';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { useHistory, useParams } from 'react-router-dom';
import { database, storage } from '../../../firebase';
import { FaUtensils, FaInfo, FaRegClock, FaRegTimesCircle, FaTimesCircle, FaHeart, FaImage, FaHeartbeat } from 'react-icons/fa';

function UpdateDietPage() {
  const { id } = useParams();
  const history = useHistory();
  const [dietData, setDietData] = useState({});
  const [imageFile, setImageFile] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchDietData = async () => {
      setLoading(true);
      try {
        const dietDoc = doc(database, 'diets', id);
        const dietSnapshot = await getDoc(dietDoc);
        if (dietSnapshot.exists()) {
          const data = dietSnapshot.data();
          setDietData(data);
        } else {
          console.log('No such document!');
        }
      } catch (error) {
        console.error('Error fetching diet:', error);
      }
      setLoading(false);
    };
    fetchDietData();
  }, [id]);

  const handleInputChange = (e) => {
    setDietData({ ...dietData, [e.target.name]: e.target.value });
  };

  const handleImageChange = (e) => {
    setImageFile(e.target.files[0]);
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      let updatedData = { ...dietData };
      if (imageFile) {
        const storageRef = ref(storage, `dietImages/${imageFile.name}`);
        await uploadBytesResumable(storageRef, imageFile);
        const imageUrl = await getDownloadURL(storageRef);
        updatedData = { ...updatedData, imageUrl };
      }
      const dietDoc = doc(database, 'diets', id);
      await updateDoc(dietDoc, updatedData);
      alert('Diet updated successfully');
      history.push('/nutrifit');
    } catch (error) {
      console.error('Error updating diet:', error);
      alert('Failed to update diet');
    }
    setLoading(false);
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div className="flex items-center justify-center min-h-screen p-6 bg-gradient-to-r from-pink-400 to-purple-500">
      <div className="w-full max-w-lg p-8 m-4 bg-white rounded-lg shadow-md">
        <h1 className="mb-4 text-3xl font-bold text-center">Update Diet</h1>
        <form onSubmit={handleUpdate}>
          <div className="grid grid-cols-1 gap-y-4">
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaUtensils className="inline mr-2 mb-1" />
                Diet Name:
                <input
                  type="text"
                  name="dietName"
                  value={dietData.dietName}
                  onChange={handleInputChange}
                  placeholder="Enter Diet Name"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaInfo className="inline mr-2 mb-1" />
                Description:
                <input
                  type="text"
                  name="description"
                  value={dietData.description}
                  onChange={handleInputChange}
                  placeholder="Enter Description"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaRegClock className="inline mr-2 mb-1" />
                Recommended Duration:
                <input
                  type="text"
                  name="recommendedDuration"
                  value={dietData.recommendedDuration}
                  onChange={handleInputChange}
                  placeholder="Enter Recommended Duration"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaRegTimesCircle className="inline mr-2 mb-1" />
                Meal Frequency:
                <input
                  type="text"
                  name="mealFrequency"
                  value={dietData.mealFrequency}
                  onChange={handleInputChange}
                  placeholder="Enter Meal Frequency"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaHeart className="inline mr-2 mb-1" />
                Foods to Eat:
                <input
                  type="text"
                  name="foodsToEat"
                  value={dietData.foodsToEat}
                  onChange={handleInputChange}
                  placeholder="Enter Foods to Eat"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaTimesCircle className="inline mr-2 mb-1" />
                Foods to Avoid:
                <input
                  type="text"
                  name="foodsToAvoid"
                  value={dietData.foodsToAvoid}
                  onChange={handleInputChange}
                  placeholder="Enter Foods to Avoid"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaHeart className="inline mr-2 mb-1" />
                Advantages:
                <input
                  type="text"
                  name="advantages"
                  value={dietData.advantages}
                  onChange={handleInputChange}
                  placeholder="Enter Advantages"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaHeartbeat className="inline mr-2 mb-1" />
                Disadvantages:
                <input
                  type="text"
                  name="disadvantages"
                  value={dietData.disadvantages}
                  onChange={handleInputChange}
                  placeholder="Enter Disadvantages"
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
            </div>
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">
                <FaImage className="inline mr-2 mb-1" />
                Image:
                <input
                  type="file"
                  name="imageFile"
                  accept="image/*"
                  onChange={handleImageChange}
                  className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                />
              </label>
              {dietData.imageUrl && (
                <img src={dietData.imageUrl} alt="Preview" className="block mt-2 rounded-md" style={{ maxWidth: '200px' }} />
              )}
            </div>
          </div>
          <button
            type="submit"
            className="w-full px-4 py-2 mt-4 text-white transition duration-300 bg-indigo-500 rounded-md hover:bg-indigo-600"
          >
            Update Diet
          </button>
        </form>
      </div>
    </div>
  );
}

export default UpdateDietPage;

