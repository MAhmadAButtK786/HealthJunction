/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-unused-vars */
import React, { useEffect, useState } from "react";
import { collection, getDocs, query, where, orderBy } from "firebase/firestore";
import { database } from "../../firebase";

function PublicBBL() {
  const [donorsData, setDonorsData] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [searchSector, setSearchSector] = useState("");
  const [filters, setFilters] = useState({
    sector: "",
    name: "",
  });

  useEffect(() => {
    getData();
  }, []);

  const getData = async () => {
    let filteredQuery = collection(database, "Public Blood Banks");

    if (searchTerm !== "") {
      const searchTermLower = searchTerm.toLowerCase();
      console.log("searchTermLower:", searchTermLower);
      filteredQuery = query(
        filteredQuery,
        where("NameLowerCase", "array-contains-any", [searchTermLower])
      );
    } else {
      if (filters.sector !== "") {
        filteredQuery = query(
          filteredQuery,
          where("Sector", "==", filters.sector)
        );
      }
      if (filters.name !== "") {
        const nameLower = filters.name.toLowerCase();
        console.log("nameLower:", nameLower);
        filteredQuery = query(
          filteredQuery,
          where("NameLowerCase", "array-contains-any", [nameLower])
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

  const handleSectorInputChange = (e) => {
    setSearchSector(e.target.value);
    setFilters((prevFilters) => ({
      ...prevFilters,
      sector: e.target.value,
    }));
  };

  const handleNameInputChange = (e) => {
    const name = e.target.value;
    setSearchTerm(name);
    // Convert name to lowercase for case-insensitive search
    setFilters((prevFilters) => ({
      ...prevFilters,
      name: name,
    }));
  };

  return (
    <div className="w-full px-4 pt-10 mx-auto">
      <div className="max-w-6xl mx-auto mb-4">
        <div className="pb-5 text-center">
          <h1 className="text-5xl font-bold text-red-600">Public Blood Banks</h1>
        </div>
        <div className="flex justify-center mb-4">
          <input
            type="text"
            value={searchTerm}
            onChange={handleNameInputChange}
            placeholder="Search by Name"
            className="w-64 px-4 py-2 mr-2 border border-gray-300 rounded-md"
          />

          <button
            onClick={handleSearch}
            className="px-4 py-2 ml-2 text-white bg-red-700 rounded-md"
          >
            Search
          </button>
        </div>
        <div className="">
          <table className="w-full mt-5 text-center border border-red-500">
            <thead className="h-10 bg-red-700 border-b border-red-500">
              <tr>
                <th className="px-4 py-2 text-white">Name</th>
                <th className="px-4 py-2 text-white">Address</th>
                <th className="px-4 py-2 text-white">License Number</th>
                <th className="px-4 py-2 text-white">Sector</th>
              </tr>
            </thead>
            <tbody>
              {donorsData.map((donor) => (
                <tr
                  key={donor.id}
                  className="h-12 bg-white border-b border-gray-400"
                >
                  <td className="px-4 py-2">{donor.Name}</td>
                  <td className="px-4 py-2 text-blue-600 underline">
                    <a
                      href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
                        donor.Address
                      )}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      {donor.Address}
                    </a>
                  </td>
                  <td className="px-4 py-2">{donor["License Number"]}</td>
                  <td className="px-4 py-2">{donor.Secter}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default PublicBBL;
