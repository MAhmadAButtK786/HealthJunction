import React, { useState } from 'react';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { storage } from '../../../firebase';

function ExcelUploadForm() {
  const [selectedFile, setSelectedFile] = useState(null);
  const [hospitalName, setHospitalName] = useState('');

  const handleFileChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };

  const handleHospitalNameChange = (e) => {
    setHospitalName(e.target.value);
  };

  const handleUpload = async () => {
    if (!selectedFile) {
      alert('Please select a file to upload.');
      return;
    }

    if (!hospitalName) {
      alert('Please enter a hospital name.');
      return;
    }

    const confirmUpload = window.confirm(`Are you sure you want to upload the file for ${hospitalName}?`);
    if (!confirmUpload) {
      return;
    }

    // Generate a unique ID for the file
    const id = `H${Date.now()}`;

    // Get the file name
    const fileName = selectedFile.name;

    // Modify the file name to include the unique ID and hospital name
    const modifiedFileName = `${id}_${hospitalName}_${fileName}`;

    // Create a reference to the file in Firebase Storage with the modified file name
    const storageRef = ref(storage, `HospitalExcelFiles/${modifiedFileName}`);

    // Upload the file to Firebase Storage
    const uploadTask = uploadBytesResumable(storageRef, selectedFile);

    // Listen for state changes, errors, and completion of the upload.
    uploadTask.on('state_changed', 
      (snapshot) => {
        // Handle the upload progress
      }, 
      (error) => {
        // Handle errors
        console.error('Error uploading file:', error);
      }, 
      () => {
        // Upload completed successfully, get the download URL
        getDownloadURL(uploadTask.snapshot.ref)
          .then((downloadURL) => {
            console.log('File uploaded successfully! Download URL:', downloadURL);
            // You can use the downloadURL as needed (e.g., display the file, save it in a database, etc.)
            // Redirect to another page
            window.location.href = '/your-next-page-url';
          })
          .catch((error) => {
            console.error('Error getting download URL:', error);
          });
      }
    );
  };

  return (
    <div className="space-y-4">
      <p>Please select an Excel file to upload:</p>
      <input
        type="text"
        placeholder="Enter hospital name"
        value={hospitalName}
        onChange={handleHospitalNameChange}
        className="p-2 border border-gray-400 rounded"
      />
      <input
        type="file"
        accept=".xlsx,.xls"
        onChange={handleFileChange}
        className="p-2 border border-gray-400 rounded"
      />
      <button onClick={handleUpload} className="px-4 py-2 text-white bg-blue-500 rounded-md">
        Upload
      </button>
    </div>
  );
}

export default ExcelUploadForm;
