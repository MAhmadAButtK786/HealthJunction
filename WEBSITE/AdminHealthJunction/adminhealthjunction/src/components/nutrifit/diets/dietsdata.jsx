import React, { useState, useEffect } from "react";
import { useHistory } from "react-router-dom";
import { collection, getDocs, doc, deleteDoc, query, where } from "firebase/firestore"; // Replace with database from firebase.js
import { database } from "../../../firebase"; // Import database from firebase.js

const DietDetailsPage = () => {
  const [diets, setDiets] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
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
      setDiets((prevDiets) =>
        prevDiets.filter((diet) => diet.id !== dietId)
      );
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
      const q = query(collection(database, "diets"), where("dietName", "==", searchTerm));
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

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Diet Plans</h1>
      <div className="flex items-center mb-6">
        <input
          type="text"
          placeholder="Search Diet"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="border border-gray-300 px-4 py-2 rounded-md mr-4"
        />
        <button onClick={handleSearch} className="bg-blue-500 text-white px-4 py-2 rounded-md mr-2">Search</button>
        <button onClick={resetSearch} className="bg-gray-300 px-4 py-2 rounded-md">Reset</button>
      </div>
      <button onClick={() => history.push("/diet")} className="bg-green-500 text-white px-4 py-2 rounded-md mb-6">Insert Diet</button>
      <table className="w-full">
        <thead>
          <tr>
            <th className="py-2">Diet Name</th>
            <th className="py-2">Description</th>
            <th className="py-2">Advantages</th>
            <th className="py-2">Disadvantages</th>
            <th className="py-2">Recommended Duration</th>
            <th className="py-2">Meal Frequency</th>
            <th className="py-2">Foods to Eat</th>
            <th className="py-2">Foods to Avoid</th>
            <th className="py-2">Image</th> 
            <th className="py-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {diets.map((diet) => (
            <tr key={diet.id}>
              <td className="py-4">{diet.dietName}</td>
              <td className="py-4">{diet.description}</td>
              <td className="py-4">{diet.advantages}</td>
              <td className="py-4">{diet.disadvantages}</td>
              <td className="py-4">{diet.recommendedDuration}</td>
              <td className="py-4">{diet.mealFrequency}</td>
              <td className="py-4">{diet.foodsToEat}</td>
              <td className="py-4">{diet.foodsToAvoid}</td>
              <td className="py-4">
                {diet.imageUrl && <img src={diet.imageUrl} alt={diet.dietName} className="w-16 h-16 rounded-full" />}
              </td>
              <td className="py-4">
                <button onClick={() => handleUpdate(diet.id)} className="bg-blue-500 text-white px-3 py-1 rounded-md mr-2">Update</button>
                <button onClick={() => handleDelete(diet.id)} className="bg-red-500 text-white px-3 py-1 rounded-md">Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default DietDetailsPage;
