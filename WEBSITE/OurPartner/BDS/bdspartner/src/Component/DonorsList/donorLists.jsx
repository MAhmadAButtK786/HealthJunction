import React, { useEffect, useState } from "react";
import { collection, getDocs, query, where, deleteDoc } from "firebase/firestore";
import { database } from "../../firebase";
import { useHistory } from "react-router-dom";import { Link } from "react-router-dom/cjs/react-router-dom.min";
;

function DonorLists() {
  const [donorsData, setDonorsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [filters, setFilters] = useState({
    age: "",
    province: "",
    city: "",
    bloodGroup: "",
  });

  useEffect(() => {
    getData();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const getData = async () => {
    let filteredQuery = collection(database, "BDS Donors");

    if (searchTerm !== "") {
      filteredQuery = query(filteredQuery, where("FullName", "==", searchTerm));
    } else {
      if (filters.age !== "") {
        filteredQuery = query(
          filteredQuery,
          where("Age", "==", parseInt(filters.age))
        );
      }
      if (filters.province !== "") {
        filteredQuery = query(
          filteredQuery,
          where("Province", "==", filters.province)
        );
      }
      if (filters.city !== "") {
        filteredQuery = query(filteredQuery, where("City", "==", filters.city));
      }
      if (filters.bloodGroup !== "") {
        filteredQuery = query(
          filteredQuery,
          where("BloodType", "==", filters.bloodGroup)
        );
      }
    }

    const querySnapshot = await getDocs(filteredQuery);
    const data = querySnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    setDonorsData(data);
  };

  const handleSearch = () => {
    getData();
  };

  const handleSearchInputChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters((prevFilters) => ({
      ...prevFilters,
      [name]: value,
    }));
  };
  const handleDelete = async (recipient) => {
    try {
      const filteredQuery = query(
        collection(database, "BDS Donors"),
        where("FullName", "==", recipient.FullName), // Assuming FullName is unique
        where("Age", "==", recipient.Age),
        where("BloodType", "==", recipient.BloodType),
        where("City", "==", recipient.City),
        where("Email", "==", recipient.Email),
        where("Phone", "==", recipient.Phone),
        where("Province", "==", recipient.Province)
      );
      
      const querySnapshot = await getDocs(filteredQuery);
      querySnapshot.forEach(async (doc) => {
        await deleteDoc(doc.ref);
      });

      // Refresh data after deletion
      getData();
    } catch (error) {
      console.error("Error deleting recipient: ", error);
    }
  };
  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
      <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-red-600">Registered Donors in our Platform</h1>
        </div>
        <div className="flex flex-col items-center justify-center mb-4 md:flex-row">
          <input
            type="text"
            value={searchTerm}
            onChange={handleSearchInputChange}
            placeholder="Search by Name"
            className="w-full px-4 py-2 mb-2 mr-0 border border-gray-300 rounded-md md:w-64 md:mb-0 md:mr-2"
          />
          <button
            onClick={handleSearch}
            className="w-full px-4 py-2 text-white bg-red-500 rounded-md md:w-auto"
          >
            Search
          </button>
        </div>
        <div className="flex flex-col items-center justify-center space-y-2 md:flex-row md:space-y-0 md:space-x-4">
          <input
            type="number"
            name="age"
            value={filters.age}
            onChange={handleFilterChange}
            placeholder="Age"
            className="w-full px-4 py-2 mb-2 border border-gray-300 rounded-md md:w-24 md:mb-0"
          />
          <select
            name="province"
            value={filters.province}
            onChange={handleFilterChange}
            className="w-full px-4 py-2 mb-2 border border-gray-300 rounded-md md:w-32 md:mb-0"
          >
            <option value="">Select Province</option>
            <option value="Punjab">Punjab</option>
            <option value="Sindh">Sindh</option>
            <option value="Khyber Pakhtunkhwa">Khyber Pakhtunkhwa</option>
            <option value="Balochistan">Balochistan</option>
            <option value="Gilgit-Baltistan">Gilgit-Baltistan</option>
            <option value="Azad Jammu and Kashmir">
              Azad Jammu and Kashmir
            </option>
            <option value="Islamabad Capital Territory">
              Islamabad Capital Territory
            </option>
          </select>
          <input
            type="text"
            name="city"
            value={filters.city}
            onChange={handleFilterChange}
            placeholder="City"
            className="w-full px-4 py-2 mb-2 border border-gray-300 rounded-md md:w-32 md:mb-0"
          />
          <select
            name="bloodGroup"
            value={filters.bloodGroup}
            onChange={handleFilterChange}
            className="w-full px-4 py-2 mb-2 border border-gray-300 rounded-md md:w-24 md:mb-0"
          >
            <option value="">Select Blood Group</option>
            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>
            <option value="NI">NI</option>
          </select>
        </div>
        <div className='overflow-x-auto'>
  <table className='w-full mt-5 text-center border border-red-400'>
    <thead className='h-10 bg-red-700 border border-red-400 '>
      <tr>
        <th className='px-4 py-2 text-white'>Full Name</th>
        <th className='px-4 py-2 text-white'>Age</th>
        <th className='px-4 py-2 text-white'>Blood Type</th>
        <th className='px-4 py-2 text-white'>City</th>
        <th className='px-4 py-2 text-white'>Email</th>
        <th className='px-4 py-2 text-white'>Phone</th>
        <th className='px-4 py-2 text-white'>Province</th>
        <th className='px-4 py-2 text-white'>Action</th>
        <th className='px-4 py-2 text-white'>Action</th>
      </tr>
    </thead>
    <tbody>
      {donorsData.map(donor => (
        <tr key={donor.id} className='h-12 bg-white border-b border-gray-400'>
          <td className='px-4 py-2'>{donor.FullName}</td>
          <td className='px-4 py-2'>{donor.Age}</td>
          <td className='px-4 py-2'>{donor.BloodType}</td>
          <td className='px-4 py-2'>{donor.City}</td>
          <td className='px-4 py-2'>
            <a href={`mailto:${donor.Email}`} className="text-blue-500 underline">{donor.Email}</a>
          </td>
          <td className='px-4 py-2'>{donor.Phone}</td>
          <td className='px-4 py-2'>{donor.Province}</td>
          <td className='px-4 py-2'> <button onClick={() => handleDelete(donor)} className="px-3 py-1 text-white bg-red-500 rounded-md">Delete</button></td>
          <td className='px-4 py-2'> <Link to= {`/updateDonorPage/${donor.id}`}> <button  className="px-3 py-1 text-white bg-green-500 rounded-md">Update</button></Link></td>
        </tr>
      ))}
    </tbody>
  </table>
</div>
      </div>
    </div>
  );
}

export default DonorLists;
