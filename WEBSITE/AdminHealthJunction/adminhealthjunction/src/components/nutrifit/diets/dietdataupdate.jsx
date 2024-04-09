import React, { useEffect, useState } from 'react';
import { doc, getDoc, updateDoc } from 'firebase/firestore';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { useHistory, useParams } from 'react-router-dom';
import { database, storage } from '../../../firebase';
// Import icons library here if not already imported

const DietUpdatePage = () => {
  const { id } = useParams();
  const history = useHistory();
  const [dietData, setDietData] = useState({});
  const [imageFile, setImageFile] = useState(null);
  const [titleImageFile, setTitleImageFile] = useState(null);
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
    const { name, value } = e.target;
    setDietData({ ...dietData, [name]: value });
  };

  const handleArrayInputChange = (e, index, arrayName) => {
    const { value } = e.target;
    const updatedArray = [...dietData[arrayName]];
    updatedArray[index] = value;
    setDietData({ ...dietData, [arrayName]: updatedArray });
  };

  const handleAddItem = (arrayName) => {
    setDietData({ ...dietData, [arrayName]: [...dietData[arrayName], ''] });
  };

  const handleRemoveItem = (index, arrayName) => {
    const updatedArray = [...dietData[arrayName]];
    updatedArray.splice(index, 1);
    setDietData({ ...dietData, [arrayName]: updatedArray });
  };

  const handleImageChange = (e, fieldName) => {
    if (fieldName === 'titleImageFile') {
      setTitleImageFile(e.target.files[0]);
    } else if (fieldName === 'imageFile') {
      setImageFile(e.target.files[0]);
    }
  };

  const handleUpdate = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      let updatedData = { ...dietData };
      if (titleImageFile) {
        const titleImageRef = ref(storage, `titleImages/${titleImageFile.name}`);
        await uploadBytesResumable(titleImageRef, titleImageFile);
        const titleImageUrl = await getDownloadURL(titleImageRef);
        updatedData = { ...updatedData, titleImageUrl };
      }
      if (imageFile) {
        const imageRef = ref(storage, `dietImages/${imageFile.name}`);
        await uploadBytesResumable(imageRef, imageFile);
        const imageUrl = await getDownloadURL(imageRef);
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
            {/* Add fields for updating diet information */}
            {/* Title Image */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Title Image:</label>
              <input
                type="file"
                name="titleImageFile"
                accept="image/*"
                onChange={(e) => handleImageChange(e, 'titleImageFile')}
                className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
              />
              {dietData.titleImageUrl && (
                <img
                  src={dietData.titleImageUrl}
                  alt="Preview"
                  className="block mt-2 rounded-md"
                  style={{ maxWidth: '200px' }}
                />
              )}
            </div>
            {/* Image */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Image:</label>
              <input
                type="file"
                name="imageFile"
                accept="image/*"
                onChange={(e) => handleImageChange(e, 'imageFile')}
                className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
              />
              {dietData.imageUrl && (
                <img
                  src={dietData.imageUrl}
                  alt="Preview"
                  className="block mt-2 rounded-md"
                  style={{ maxWidth: '200px' }}
                />
              )}
            </div>
            {/* Remaining fields for diet information */}
            {/* Name */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Name:</label>
              <input
                type="text"
                name="dietName"
                value={dietData.dietName || ''}
                onChange={handleInputChange}
                className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
              />
            </div>
            {/* Description */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Description:</label>
              <textarea
                rows="4"
                name="description"
                value={dietData.description || ''}
                onChange={handleInputChange}
                className="block w-full mt-1 border-gray-300 rounded-md form-textarea focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
              />
            </div>
            {/* Add similar sections for advantages, disadvantages, foodsToAvoid, and foodsToEat */}
            {/* Advantages */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Advantages:</label>
              {dietData.advantages &&
                dietData.advantages.map((advantage, index) => (
                  <div key={index} className="flex items-center">
                    <input
                      type="text"
                      value={advantage}
                      onChange={(e) => handleArrayInputChange(e, index, 'advantages')}
                      className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                    />
                    <button
                      type="button"
                      onClick={() => handleRemoveItem(index, 'advantages')}
                    >
                      {/* Icon for removing item */}
                    </button>
                  </div>
                ))}
              <button type="button" onClick={() => handleAddItem('advantages')}>
                {/* Icon for adding item */}
              </button>
            </div>
            {/* Disadvantages */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Disadvantages:</label>
              {dietData.disadvantages &&
                dietData.disadvantages.map((disadvantage, index) => (
                  <div key={index} className="flex items-center">
                    <input
                      type="text"
                      value={disadvantage}
                      onChange={(e) => handleArrayInputChange(e, index, 'disadvantages')}
                      className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                    />
                    <button
                      type="button"
                      onClick={() => handleRemoveItem(index, 'disadvantages')}
                    >
                      {/* Icon for removing item */}
                    </button>
                  </div>
                ))}
              <button type="button" onClick={() => handleAddItem('disadvantages')}>
                {/* Icon for adding item */}
              </button>
            </div>
            {/* Foods to Avoid */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Food to Avoid:</label>
              {dietData.foodsToAvoid &&
                dietData.foodsToAvoid.map((food, index) => (
                  <div key={index} className="flex items-center">
                    <input
                      type="text"
                      value={food}
                      onChange={(e) => handleArrayInputChange(e, index, 'foodsToAvoid')}
                      className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                    />
                    <button
                      type="button"
                      onClick={() => handleRemoveItem(index, 'foodsToAvoid')}
                    >
                      {/* Icon for removing item */}
                    </button>
                  </div>
                ))}
              <button type="button" onClick={() => handleAddItem('foodsToAvoid')}>
                {/* Icon for adding item */}
              </button>
            </div>
            {/* Foods to Eat */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Food to Eat:</label>
              {dietData.foodsToEat &&
                dietData.foodsToEat.map((food, index) => (
                  <div key={index} className="flex items-center">
                    <input
                      type="text"
                      value={food}
                      onChange={(e) => handleArrayInputChange(e, index, 'foodsToEat')}
                      className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                    />
                    <button
                      type="button"
                      onClick={() => handleRemoveItem(index, 'foodsToEat')}
                    >
                      {/* Icon for removing item */}
                    </button>
                  </div>
                ))}
              <button type="button" onClick={() => handleAddItem('foodsToEat')}>
                {/* Icon for adding item */}
              </button>
            </div>
            {/* Additional Information */}
            <div className="col-span-1">
              <label className="block mb-2 font-semibold">Additional Information:</label>
              <input
                type="text"
                name="additionalInfo"
                value={dietData.additionalInfo || ''}
                onChange={handleInputChange}
                className="block w-full mt-1 border-gray-300 rounded-md form-input focus:border-indigo-500 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
              />
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
};

export default DietUpdatePage;
