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
    <div className="flex flex-col items-center justify-center h-screen">
      <form className="flex flex-col items-center justify-center w-4/12 gap-4 px-10 py-5 bg-gray-400">
        <h2 className="text-xl font-bold ">Add Event Details</h2>
        <input
          type="text"
          placeholder="Enter Event Name"
          className="w-full px-4 py-1 border-none outline-none"
          value={eventName}
          onChange={(e) => setEventName(e.target.value)}
        />
        <textarea
          placeholder="Enter Description"
          className="w-full px-4 py-1 border-none outline-none"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        ></textarea>
        <input
          type="date"
          placeholder="Enter Date"
          className="w-full px-4 py-1 border-none outline-none"
          value={date}
          onChange={(e) => setDate(e.target.value)}
        />
        <input
          type="time"
          placeholder="Enter Time"
          className="w-full px-4 py-1 border-none outline-none"
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
       <label htmlFor="file" className="flex items-center gap-2 cursor-pointer">
  <i class="fa fa-image" aria-hidden="true"></i>
  <span>{imageFile ? imageFile.name : 'Add an Image'}</span>
</label>

        <button
          type="submit"
          className="w-full p-2 text-white bg-blue-500 rounded-full"
          onClick={saveData}
        >
          Insert
        </button>
      </form>
      <button
        className="text-blue-400 underline"
        onClick={() => history.push("/home")}
      >
        Back
      </button>
    </div>
  );
};

export default Page;
