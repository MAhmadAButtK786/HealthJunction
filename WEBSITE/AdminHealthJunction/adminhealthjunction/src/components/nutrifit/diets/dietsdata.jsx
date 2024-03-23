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
import "./DietDetailsPage.css";

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
    <div className="container mx-auto px-4 py-8">
      <h1 className="header">Diet Plans</h1>
      <div className="search-bar">
        <input
          type="text"
          placeholder="Search Diet"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="search-input"
        />
        <button onClick={handleSearch} className="search-button">
          Search
        </button>
        <button onClick={resetSearch} className="reset-button">
          Reset
        </button>
      </div>
      <button onClick={() => history.push("/diet")} className="insert-button">
        Insert Diet
      </button>
      <div className="diet-grid">
        {diets.map((diet) => (
          <div key={diet.id} className="diet-card">
            <div
              className={`diet-header bg-${getRandomColor()}`}
              onClick={() => toggleExpand(diet.id)}
            >
              <div className="diet-title">
                <h3 className="diet-name">{diet.dietName}</h3>
                <p className="expand-icon">
                  {expandedDietIds.includes(diet.id) ? (
                    <FaAngleUp />
                  ) : (
                    <FaAngleDown />
                  )}
                </p>
              </div>
              {expandedDietIds.includes(diet.id) && (
                <div className="diet-details">
                  <p>Description: {diet.description}</p>
                  <p>Advantages: {diet.advantages}</p>
                  <p>Disadvantages: {diet.disadvantages}</p>
                  <p>Recommended Duration: {diet.recommendedDuration}</p>
                  <p>Meal Frequency: {diet.mealFrequency}</p>
                  <p>Foods to Eat: {diet.foodsToEat}</p>
                  <p>Foods to Avoid: {diet.foodsToAvoid}</p>
                  {diet.imageUrl && (
                    <img
                      src={diet.imageUrl}
                      alt={diet.dietName}
                      className="diet-image"
                    />
                  )}
                </div>
              )}
            </div>
            <div className="diet-actions">
              <button
                onClick={() => handleUpdate(diet.id)}
                className="edit-button"
              >
                <FaEdit />
              </button>
              <button
                onClick={() => handleDelete(diet.id)}
                className="delete-button"
              >
                <FaTrash />
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default DietDetailsPage;
