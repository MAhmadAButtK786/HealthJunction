/* eslint-disable no-unused-vars */
import React, { useEffect, useState } from "react";
import { collection, getDocs, query, where, deleteDoc } from "firebase/firestore";
import { database } from "../../firebase";
import { useHistory, Link } from "react-router-dom";
import { FaEdit, FaTrash, FaPlus } from "react-icons/fa";

function TeamMemberList() {
  const [teamMembersData, setTeamMembersData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [filters, setFilters] = useState({
    age: "",
    province: "",
    city: "",
    bloodGroup: "",
  });

  const history = useHistory(); // Initialize useHistory hook

  useEffect(() => {
    getData();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const getData = async () => {
    let filteredQuery = collection(database, "BDSteam");

    if (searchTerm !== "") {
      filteredQuery = query(filteredQuery, where("fullName", "==", searchTerm));
    } else {
      if (filters.age !== "") {
        filteredQuery = query(
          filteredQuery,
          where("age", "==", parseInt(filters.age))
        );
      }
      if (filters.province !== "") {
        filteredQuery = query(
          filteredQuery,
          where("province", "==", filters.province)
        );
      }
      if (filters.city !== "") {
        filteredQuery = query(filteredQuery, where("city", "==", filters.city));
      }
      if (filters.bloodGroup !== "") {
        filteredQuery = query(
          filteredQuery,
          where("bloodGroup", "==", filters.bloodGroup)
        );
      }
    }

    const querySnapshot = await getDocs(filteredQuery);
    const data = querySnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }));
    setTeamMembersData(data);
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

  const handleDelete = async (teamMember) => {
    const isConfirmed = window.confirm("Are you sure you want to delete this team member?");
    
    if (!isConfirmed) {
      return; // Cancel deletion if not confirmed
    }
  
    try {
      const filteredQuery = query(
        collection(database, "BDSteam"),
        where("fullName", "==", teamMember.fullName), // Assuming fullName is unique
        where("age", "==", teamMember.age),
        where("bloodGroup", "==", teamMember.bloodGroup),
        where("city", "==", teamMember.city),
        where("email", "==", teamMember.email),
        where("phone", "==", teamMember.phone),
        where("province", "==", teamMember.province)
      );
      
      const querySnapshot = await getDocs(filteredQuery);
      querySnapshot.forEach(async (doc) => {
        await deleteDoc(doc.ref);
      });
  
      // Refresh data after deletion
      getData();
    } catch (error) {
      console.error("Error deleting team member: ", error);
    }
  };
  

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="text-center pb-7">
          <h1 className="text-5xl font-bold text-red-600">Registered Team Members</h1>
        </div>
        <div>
            <Link to="/insertteammember">
              <button className="flex items-center px-4 py-2 text-white bg-green-500 rounded-md hover:bg-green-600">
                <FaPlus className="mr-2" />
                Insert Team Member
              </button>
            </Link>
          </div>
          <br />
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center space-x-4">
            <input
              type="text"
              value={searchTerm}
              onChange={handleSearchInputChange}
              placeholder="Search by Name"
              className="w-1/3 px-4 py-2 border border-gray-300 rounded-md"
            />
            <input
              type="number"
              name="age"
              value={filters.age}
              onChange={handleFilterChange}
              placeholder="Age"
              className="w-1/12 px-4 py-2 border border-gray-300 rounded-md"
            />
            <select
              name="province"
              value={filters.province}
              onChange={handleFilterChange}
              className="w-1/6 px-4 py-2 border border-gray-300 rounded-md"
            >
                
             <option value="">Province</option>
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
              className="w-1/6 px-4 py-2 border border-gray-300 rounded-md"
            />
            <select
              name="bloodGroup"
              value={filters.bloodGroup}
              onChange={handleFilterChange}
              className="w-1/6 px-4 py-2 border border-gray-300 rounded-md"
            >
              
<option value="">Blood Group</option>
            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>
            <option value="Not Specified">Not Specified</option>
             
            </select>
            <button
              onClick={handleSearch}
              className="px-6 py-3 text-white bg-red-500 rounded-md hover:bg-red-600"
            >
              Search
            </button>
          </div>
         
        </div>
        <hr className="mb-4 border-t border-gray-300" />
        <div className="overflow-x-auto">
          <table className="w-full mt-5 text-center border border-red-400">
            <thead className="text-white bg-red-700">
              <tr>
                <th className="px-2 py-2 sm:px-4">Full Name</th>
                <th className="px-2 py-2 sm:px-4">Father Name</th>
                <th className="px-2 py-2 sm:px-4">Age</th>
                <th className="px-2 py-2 sm:px-4">BG</th>
                <th className="px-2 py-2 sm:px-4">Address</th>
                <th className="px-2 py-2 sm:px-4">City</th>
                <th className="px-2 py-2 sm:px-4">Province</th>
                <th className="px-2 py-2 sm:px-4">Email</th>
                <th className="px-2 py-2 sm:px-4">Phone</th>
                <th className="px-2 py-2 sm:px-4">Bio</th>
                <th className="px-2 py-2 sm:px-4">Actions</th>
              </tr>
            </thead>
            <tbody>
              {teamMembersData.map((teamMember, index) => (
                <tr key={teamMember.id} className={index % 2 === 0 ? "bg-gray-100" : "bg-white"}>
                  <td className="px-2 py-2 sm:px-4">{teamMember.fullName}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.fatherName}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.age}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.bloodGroup}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.address}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.city}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.province}</td>
                  <td className="px-2 py-2 sm:px-4">
                    <a href={`mailto:${teamMember.email}`} className="text-blue-500 underline">{teamMember.email}</a>
                  </td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.phone}</td>
                  <td className="px-2 py-2 sm:px-4">{teamMember.bio}</td>
                  <td className="px-2 py-2 sm:px-4">
                    <div className="flex items-center justify-center">
                      <Link to={`/updateteammemberpage/${teamMember.id}`}>
                        <FaEdit className="mr-2 text-blue-500 cursor-pointer hover:text-blue-600" />
                      </Link>
                      <FaTrash
                        className="text-red-500 cursor-pointer hover:text-red-600"
                        onClick={() => handleDelete(teamMember)}
                      />
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default TeamMemberList;
