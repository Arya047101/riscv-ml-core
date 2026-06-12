import { useState } from "react";

import NavigationBar from "./Components/NavigationBar";
import ScratchPad from "./Components/ScratchPad";
import Description from "./Components/Description";
import Output from "./Components/Output";

import "./App.css";

function App() {

  const [prediction,
    setPrediction] = useState(null);

  const [loading,
    setLoading] = useState(false);

  return (
    <>
      <NavigationBar />

      <div className="main-layout">

        <ScratchPad
          setPrediction={setPrediction}
          setLoading={setLoading}
        />

        <div className="right-panel">

          <Description />

          <Output
            prediction={prediction}
            loading={loading}
          />

        </div>

      </div>
    </>
  );
}

export default App;