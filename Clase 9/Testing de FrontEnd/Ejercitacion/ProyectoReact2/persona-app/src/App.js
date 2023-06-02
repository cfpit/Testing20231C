// import logo from './logo.svg';
// import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;


import React, { useState, useEffect } from 'react';

function App() {
  const [persons, setPersons] = useState([]);

  useEffect(() => {
    fetch('/persons.json')
      .then(response => response.json())
      .then(data => setPersons(data.persons))
      .catch(error => console.log(error));
  }, []);

  return (
    <div>
      <h1>Personas</h1>
      <ul>
        {persons.map(person => (
          <li key={person.id}>
            {person.nombre} {person.apellido} - Edad: {person.edad}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
