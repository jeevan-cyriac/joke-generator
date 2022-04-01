import React, { useEffect, useState } from "react";
import "./styles.css";

export default function App() {
  const [joke, setJoke] = useState("...loading next joke");

  const generateJoke = async () => {
    const config = {
      headers: {
        accept: "application/json"
      }
    };
    const res = await fetch("https://icanhazdadjoke.com/", config);
    const data = await res.json();
    setJoke(data.joke);
  };

  useEffect(() => {
    generateJoke();
  }, []);

  return (
    <div className="App">
      <div className="container">
        <h3>Hey there!</h3>
        <div id="container">
          <img src="laughing.png" alt="" />
        </div>
        <div id="joke" className="joke">
          {joke}
        </div>
        <button id="jokeBtn" className="btn" onClick={generateJoke}>
          Get new joke
        </button>
      </div>
    </div>
  );
}
