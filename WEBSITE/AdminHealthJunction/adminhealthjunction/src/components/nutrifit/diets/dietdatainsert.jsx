import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { collection, addDoc } from 'firebase/firestore';
import { storage, database } from '../../../firebase'; 
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';

const DietInsertPage = () => {
  const [dietName, setDietName] = useState('');
  const [description, setDescription] = useState('');
  const [advantages, setAdvantages] = useState('');
  const [disadvantages, setDisadvantages] = useState('');
  const [recommendedDuration, setRecommendedDuration] = useState('');
  const [mealFrequency, setMealFrequency] = useState('');
  const [foodsToEat, setFoodsToEat] = useState('');
  const [foodsToAvoid, setFoodsToAvoid] = useState('');
  const [imageFile, setImageFile] = useState(null);
  const history = useHistory();

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      if (imageFile) {
        const storageRef = ref(storage, `dietImages/${imageFile.name}`);
        await uploadBytesResumable(storageRef, imageFile).then(async () => {
          const downloadURL = await getDownloadURL(storageRef);
          await addDoc(collection(database, 'diets'), {
            dietName,
            description,
            advantages,
            disadvantages,
            recommendedDuration,
            mealFrequency,
            foodsToEat,
            foodsToAvoid,
            imageUrl: downloadURL,
          });
          alert('Data Saved');
          setDietName('');
          setDescription('');
          setAdvantages('');
          setDisadvantages('');
          setRecommendedDuration('');
          setMealFrequency('');
          setFoodsToEat('');
          setFoodsToAvoid('');
          setImageFile(null);
        });
      }
    } catch (error) {
      console.error('Error adding document: ', error);
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <form className="flex flex-col items-center justify-center w-11/12 gap-4 p-6 bg-white rounded-lg shadow-md md:w-4/12">
        <h2 className="text-2xl font-semibold text-gray-700">Insert Diet Plan</h2>
        <input
          type="text"
          placeholder="Diet Name"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={dietName}
          onChange={(e) => setDietName(e.target.value)}
        />
        <textarea
          placeholder="Description"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        ></textarea>
        <textarea
          placeholder="Advantages"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={advantages}
          onChange={(e) => setAdvantages(e.target.value)}
        ></textarea>
        <textarea
          placeholder="Disadvantages"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={disadvantages}
          onChange={(e) => setDisadvantages(e.target.value)}
        ></textarea>
        <input
          type="text"
          placeholder="Recommended Duration"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={recommendedDuration}
          onChange={(e) => setRecommendedDuration(e.target.value)}
        />
        <input
          type="text"
          placeholder="Meal Frequency"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={mealFrequency}
          onChange={(e) => setMealFrequency(e.target.value)}
        />
        <textarea
          placeholder="Foods to Eat"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={foodsToEat}
          onChange={(e) => setFoodsToEat(e.target.value)}
        ></textarea>
        <textarea
          placeholder="Foods to Avoid"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={foodsToAvoid}
          onChange={(e) => setFoodsToAvoid(e.target.value)}
        ></textarea>
        <input
          required
          style={{ display: 'none' }}
          type="file"
          id="file"
          onChange={(e) => {
            const file = e.target.files[0];
            setImageFile(file);
          }}
        />
        <label htmlFor="file" className="flex items-center gap-2 text-blue-500 cursor-pointer">
          <i className="fa fa-image" aria-hidden="true"></i>
          <span>{imageFile ? imageFile.name : 'Add an Image'}</span>
        </label>
        <button
          type="submit"
          className="w-full p-2 text-white bg-blue-500 rounded-full hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400"
          onClick={handleSubmit}
        >
          Insert
        </button>
      </form>
      <button
        className="mt-4 text-blue-500 underline hover:text-blue-600"
        onClick={() => history.push('/nutrifit')}
      >
        Back
      </button>
    </div>
  );
};

export default DietInsertPage;
