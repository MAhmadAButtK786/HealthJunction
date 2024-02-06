import React, { useState, useEffect } from 'react';
import firebase from 'firebase'; // assuming you've set up Firebase in your React project

function Allied() {
  const [searchTerm, setSearchTerm] = useState('');
  const [tests, setTests] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchController, setSearchController] = useState('');

  useEffect(() => {
    const fetchData = async () => {
      const snapshot = await firebase.firestore().collection('Allied Lab').orderBy("Code").get();
      const data = snapshot.docs.map(doc => doc.data());
      setTests(data);
      setIsLoading(false);
    };

    fetchData();
  }, []);

  const performSearch = () => {
    setSearchTerm(searchController.toLowerCase().trim());
  };

  return (
    <div>
      <div>
        <h1>Allied Lahore Lab</h1>
        <input
          type="text"
          value={searchController}
          onChange={e => setSearchController(e.target.value)}
          placeholder="Search..."
        />
        <button onClick={performSearch}>Search</button>
      </div>
      {isLoading ? (
        <p>Loading...</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Test Name</th>
              <th>Code</th>
              <th>Price</th>
              <th>Sample Required</th>
              <th>Reporting Time</th>
            </tr>
          </thead>
          <tbody>
            {tests.map(test => (
              (searchTerm === '' || test['Test Name'].toLowerCase().includes(searchTerm)) && (
                <tr key={test['Code']}>
                  <td>{test['Test Name']}</td>
                  <td>{test['Code']}</td>
                  <td>{test['Price']}</td>
                  <td>{test['Sample Required']}</td>
                  <td>{test['Reporting Time']}</td>
                </tr>
              )
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}

export default Allied;
