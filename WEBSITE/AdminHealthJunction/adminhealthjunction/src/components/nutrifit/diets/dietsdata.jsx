import React, { useState, useEffect } from "react";
import { useHistory } from "react-router-dom";
import {
  collection,
  getDocs,
  doc,
  deleteDoc,
  query,
  where,
} from "firebase/firestore";
import { database } from "../../../firebase";
import { FaEdit, FaTrash, FaAngleDown, FaAngleUp } from "react-icons/fa";

const DietDetailsPage = () => {
  const [diets, setDiets] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [expandedDietIds, setExpandedDietIds] = useState([]);
  const history = useHistory();

  useEffect(() => {
    const fetchDiets = async () => {
      try {
        const dietsCollection = collection(database, "diets");
        const dietsSnapshot = await getDocs(dietsCollection);
        const dietsData = dietsSnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setDiets(dietsData);
      } catch (error) {
        console.error("Error fetching diets:", error);
      }
    };

    fetchDiets();
  }, []);

  const handleDelete = async (dietId) => {
    try {
      await deleteDoc(doc(database, "diets", dietId));
      setDiets((prevDiets) => prevDiets.filter((diet) => diet.id !== dietId));
      alert("Diet plan deleted successfully");
    } catch (error) {
      console.error("Error deleting diet plan:", error);
      alert("Failed to delete diet plan");
    }
  };
  const handleAdditionalInfoClick = (url) => {
    window.open(url, "_blank");
  };
  const handleUpdate = (dietId) => {
    history.push(`/updatedietpage/${dietId}`);
  };

  const handleSearch = async () => {
    try {
      const q = query(
        collection(database, "diets"),
        where("dietName", "==", searchTerm)
      );
      const querySnapshot = await getDocs(q);
      const searchedDiets = querySnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));
      setDiets(searchedDiets);
    } catch (error) {
      console.error("Error searching diets:", error);
    }
  };

  const resetSearch = async () => {
    setSearchTerm("");
    const fetchDiets = async () => {
      try {
        const dietsCollection = collection(database, "diets");
        const dietsSnapshot = await getDocs(dietsCollection);
        const dietsData = dietsSnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setDiets(dietsData);
      } catch (error) {
        console.error("Error fetching diets:", error);
      }
    };

    fetchDiets();
  };

  const getRandomColor = () => {
    const colors = [
      "#FFCDD2",
      "#F8BBD0",
      "#E1BEE7",
      "#D1C4E9",
      "#BBDEFB",
      "#B3E5FC",
      "#B2EBF2",
      "#C8E6C9",
      "#DCEDC8",
      "#FFF9C4",
    ];
    return colors[Math.floor(Math.random() * colors.length)];
  };

  const toggleExpand = (dietId) => {
    setExpandedDietIds((prevExpandedDietIds) => {
      if (prevExpandedDietIds.includes(dietId)) {
        // If the clicked diet is already expanded, remove it from the array
        return prevExpandedDietIds.filter((id) => id !== dietId);
      } else {
        // Otherwise, add the clicked diet to the array
        return [...prevExpandedDietIds, dietId];
      }
    });
  };

  return (
    <div className="container px-4 py-8 mx-auto">
      <h1 className="mb-4 text-3xl font-bold text-purple-700">Diet Plans</h1>
      <div className="flex flex-col items-stretch mb-4 space-y-2 sm:flex-row sm:space-y-0 sm:space-x-4">
        <input
          type="text"
          placeholder="Search Diet"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="flex-grow px-4 py-2 mb-2 border border-gray-300 rounded-md sm:mb-0"
        />
        <button
          onClick={handleSearch}
          className="px-4 py-2 text-white bg-blue-500 rounded-md"
        >
          Search
        </button>
        <button
          onClick={resetSearch}
          className="px-4 py-2 text-gray-700 bg-gray-300 rounded-md"
        >
          Reset
        </button>
      </div>
      <button
        onClick={() => history.push("/diet")}
        className="px-4 py-2 mb-4 text-white bg-green-500 rounded-md"
      >
        Insert Diet
      </button>
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {diets.map((diet) => (
          <div key={diet.id} className="p-4 bg-gray-100 rounded-lg shadow-md">
            <div
              className={`flex justify-between items-center bg-${getRandomColor()} text-white px-4 py-2 rounded-t-md cursor-pointer`}
              onClick={() => toggleExpand(diet.id)}
            >
              <h3 className="text-xl font-bold text-purple-700">
                {diet.dietName}
              </h3>
              <p className="text-xl">
                {expandedDietIds.includes(diet.id) ? (
                  <FaAngleUp color="purple" />
                ) : (
                  <FaAngleDown color="purple" />
                )}
              </p>
            </div>
            {expandedDietIds.includes(diet.id) && (
              <div className="mt-4">
                <p>
                  <strong>Description:</strong> {diet.description}
                </p>
                <p>
                  <strong>Advantages:</strong>
                </p>
                <ul>
                  {diet.advantages.map((advantage, index) => (
                    <li key={index}>{advantage}</li>
                  ))}
                </ul>
                <p>
                  <strong>Disadvantages:</strong>
                </p>
                <ul>
                  {diet.disadvantages.map((disadvantage, index) => (
                    <li key={index}>{disadvantage}</li>
                  ))}
                </ul>
                <br />
                <button
                    className="px-3 py-1 text-purple-700 underline transition duration-300 bg-purple-100 rounded-md shadow-md hover:bg-purple-200"
                  onClick={() => handleAdditionalInfoClick(diet.additionalInfo)}
                >
                  Additional Information
                </button>
                <br />
                <br />
                <p>
                  <strong>Foods to Eat:</strong>
                </p>
                <ul>
                  {diet.foodsToEat.map((food, index) => (
                    <li key={index}>{food}</li>
                  ))}
                </ul>
                <p>
                  <strong>Foods to Avoid:</strong>
                </p>
                <ul>
                  {diet.foodsToAvoid.map((food, index) => (
                    <li key={index}>{food}</li>
                  ))}
                </ul>
                {diet.imageUrl && (
                  <img
                    src={diet.imageUrl}
                    alt={diet.dietName}
                    className="w-full h-auto mt-4 rounded-md"
                  />
                )}
              </div>
            )}
            <div className="flex justify-between mt-4">
              <button
                onClick={() => handleUpdate(diet.id)}
                className="flex items-center px-4 py-2 text-white bg-blue-500 rounded-md"
              >
                <FaEdit className="mr-2" />
                <span>Edit</span>
              </button>
              <button
                onClick={() => handleDelete(diet.id)}
                className="flex items-center px-4 py-2 text-white bg-red-500 rounded-md"
              >
                <FaTrash className="mr-2" />
                <span>Delete</span>
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default DietDetailsPage;
