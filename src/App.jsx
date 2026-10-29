import React, { useState } from "react";
import instance from "./axios";

const App = () => {
  const [apiData, setapiData] = useState({});

  const fetchData = async (url) => {
    try {
      const res = await instance.get(url);
      setapiData(res.data);
    } catch (e) {
      console.log(e);
    }
  };

  return (
    <div>
      <button onClick={() => fetchData("/api")}>Fetch Api</button>
      <button onClick={() => fetchData("/api/v1")}>Fetch Api V1</button>
      <p>{JSON.stringify(apiData)}</p>
    </div>
  );
};

export default App;
