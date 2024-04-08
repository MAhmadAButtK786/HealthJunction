import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { collection, addDoc } from 'firebase/firestore';
import { storage, database } from '../../../firebase';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { FiUploadCloud, FiPlusCircle, FiTrash2 } from 'react-icons/fi';

const DietInsertPage = () => {
  const [dietName, setDietName] = useState('');
  const [description, setDescription] = useState('');
  const [advantages, setAdvantages] = useState(['']);
  const [disadvantages, setDisadvantages] = useState(['']);
  const [foodsToEat, setFoodsToEat] = useState(['']);
  const [foodsToAvoid, setFoodsToAvoid] = useState(['']);
  const [additionalInfo, setAdditionalInfo] = useState('');
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
            foodsToEat,
            foodsToAvoid,
            additionalInfo,
            imageUrl: downloadURL,
          });
          alert('Data Saved');
          clearForm();
        });
      }
    } catch (error) {
      console.error('Error adding document: ', error);
    }
  };

  const clearForm = () => {
    setDietName('');
    setDescription('');
    setAdvantages(['']);
    setDisadvantages(['']);
    setFoodsToEat(['']);
    setFoodsToAvoid(['']);
    setAdditionalInfo('');
    setImageFile(null);
  };

  const handleAddItem = (setState) => {
    setState((prevState) => [...prevState, '']);
  };

  const handleRemoveItem = (index, setState) => {
    setState((prevState) => {
      const newState = [...prevState];
      newState.splice(index, 1);
      return newState;
    });
  };

  const handleChangeItem = (index, value, setState) => {
    setState((prevState) => {
      const newState = [...prevState];
      newState[index] = value;
      return newState;
    });
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <form className="w-full max-w-lg p-6 bg-white rounded-lg shadow-md">
        <h2 className="mb-6 text-3xl font-semibold text-gray-700">Insert Diet Plan</h2>
        <div className="grid grid-cols-1 gap-6">
          <div>
            <label htmlFor="dietName" className="block mb-1 text-sm font-medium text-gray-700">
              Diet Name
            </label>
            <input
              id="dietName"
              type="text"
              placeholder="Enter Diet Name"
              className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              value={dietName}
              onChange={(e) => setDietName(e.target.value)}
            />
          </div>
          <div>
            <label htmlFor="description" className="block mb-1 text-sm font-medium text-gray-700">
              Description
            </label>
            <textarea
              id="description"
              placeholder="Enter Description"
              className="w-full h-40 px-4 py-2 border border-gray-300 rounded-md resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />
          </div>
          {[
            { title: 'Advantages', state: advantages, setState: setAdvantages },
            { title: 'Disadvantages', state: disadvantages, setState: setDisadvantages },
            { title: 'Foods to Eat', state: foodsToEat, setState: setFoodsToEat },
            { title: 'Foods to Avoid', state: foodsToAvoid, setState: setFoodsToAvoid },
          ].map((section, sectionIndex) => (
            <div key={sectionIndex}>
              <label htmlFor={section.title} className="block mb-1 text-sm font-medium text-gray-700">
                {section.title}
              </label>
              {section.state.map((item, index) => (
                <div key={index} className="flex items-center mb-2">
                  <input
                    type="text"
                    placeholder={`Enter ${section.title}`}
                    className="flex-1 px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                    value={item}
                    onChange={(e) => handleChangeItem(index, e.target.value, section.setState)}
                  />
                  {index === section.state.length - 1 && (
                    <FiPlusCircle
                      className="w-6 h-6 ml-2 text-blue-500 cursor-pointer"
                      onClick={() => handleAddItem(section.setState)}
                    />
                  )}
                  {index !== section.state.length - 1 && (
                    <FiTrash2
                      className="w-6 h-6 ml-2 text-red-500 cursor-pointer"
                      onClick={() => handleRemoveItem(index, section.setState)}
                    />
                  )}
                </div>
              ))}
            </div>
          ))}
          <div>
            <label htmlFor="additionalInfo" className="block mb-1 text-sm font-medium text-gray-700">
              Information Link
            </label>
            <input
              id="additionalInfo"
              type="text"
              placeholder="Enter Information Link"
              className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              value={additionalInfo}
              onChange={(e) => setAdditionalInfo(e.target.value)}
            />
          </div>
          <div className="flex items-center space-x-4">
            <label htmlFor="file" className="block text-sm font-medium text-gray-700 cursor-pointer">
              <FiUploadCloud className="w-6 h-6 mr-2 text-blue-500" />
              Upload Image
            </label>
            <input
              required
              id="file"
              type="file"
              onChange={(e) => setImageFile(e.target.files[0])}
              style={{ display: 'none' }}
            />
            <span>{imageFile ? imageFile.name : 'No file chosen'}</span>
          </div>
          <div className="flex items-center space-x-4">
            <button
              type="submit"
              className="w-full p-2 text-white bg-blue-500 rounded-full hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400"
              onClick={handleSubmit}
            >
              Insert
            </button>
            <button
              className="w-full p-2 text-blue-500 border border-blue-500 rounded-full hover:text-blue-600 hover:border-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400"
              onClick={() => history.push('/nutrifit')}
            >
              Back
            </button>
          </div>
        </div>
      </form>
    </div>
  );
};

export default DietInsertPage;
