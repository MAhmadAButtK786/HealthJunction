/* eslint-disable no-unused-vars */
import React, { useState } from "react";
import { useHistory } from "react-router-dom";
import { collection, addDoc } from "firebase/firestore";
import { storage, database } from "../../firebase";
import { ref, uploadBytesResumable, getDownloadURL } from "firebase/storage";

const Page = () => {
  const [eventName, setEventName] = useState("");
  const [description, setDescription] = useState("");
  const [date, setDate] = useState("");
  const [time, setTime] = useState("");
  const [imageFile, setImageFile] = useState(null);
  const [imageUrl, setImageUrl] = useState("");
  const history = useHistory();

  const saveData = async (e) => {
    e.preventDefault();

    if (imageFile) {
      const storageRef = ref(storage, `eventImages/${imageFile.name}`);
      await uploadBytesResumable(storageRef, imageFile).then(async () => {
        const imageUrl = await getDownloadURL(storageRef);
        await addDoc(collection(database, "Event"), {
          eventName: eventName,
          description: description,
          date: date,
          time: time,
          imageUrl: imageUrl, // Save the image URL
        })
          .then(() => {
            alert("Data Saved");
            setEventName("");
            setDescription("");
            setDate("");
            setTime("");
            setImageFile(null);
            setImageUrl("");
          })
          .catch((err) => {
            console.log(err);
          });
      });
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <form className="flex flex-col items-center justify-center w-11/12 gap-4 p-6 bg-white rounded-lg shadow-md md:w-4/12">
        <h2 className="text-2xl font-semibold text-gray-700">Add Event Details</h2>
        <input
          type="text"
          placeholder="Enter Event Name"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={eventName}
          onChange={(e) => setEventName(e.target.value)}
        />
        <textarea
          placeholder="Enter Description"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        ></textarea>
        <input
          type="date"
          placeholder="Enter Date"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={date}
          onChange={(e) => setDate(e.target.value)}
        />
        <input
          type="time"
          placeholder="Enter Time"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"
          value={time}
          onChange={(e) => setTime(e.target.value)}
        />
        <input
          required
          style={{ display: "none" }}
          type="file"
          id="file"
          onChange={(e) => {
            const file = e.target.files[0];
            setImageFile(file);
          }}
        />
        <label htmlFor="file" className="flex items-center gap-2 text-blue-500 cursor-pointer">
          <i class="fa fa-image" aria-hidden="true"></i>
          <span>{imageFile ? imageFile.name : 'Add an Image'}</span>
        </label>
        <button
          type="submit"
          className="w-full p-2 text-white bg-blue-500 rounded-full hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400"
          onClick={saveData}
        >
          Insert
        </button>
      </form>
      <button
        className="mt-4 text-blue-500 underline hover:text-blue-600"
        onClick={() => history.push("/event")}
      >
        Back
      </button>
    </div>
  );
};

export default Page;
