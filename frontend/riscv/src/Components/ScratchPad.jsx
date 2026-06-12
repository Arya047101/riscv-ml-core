import { ReactSketchCanvas } from "react-sketch-canvas";
import { useRef, useState } from "react";
import "./ScratchPad.css";

function ScratchPad({ setPrediction, setLoading }) {
  const canvasRef = useRef(null);

  const [message, setMessage] = useState("");

  const saveDrawing = async () => {
    try {

      setLoading(true);

      const image =
        await canvasRef.current.exportImage("png");

      const response = await fetch(
        "http://localhost:5001/api/convert",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ image }),
        }
      );

      const data = await response.json();

      if (data.success) {

        setMessage(
          `Prediction generated successfully`
        );

        setPrediction(data.prediction);

      } else {

        setMessage("Prediction failed");

      }

    } catch (error) {

      console.error(error);

      setMessage("Backend connection failed");

    } finally {

      setLoading(false);

    }
  };

  const clearCanvas = async () => {

    await canvasRef.current.clearCanvas();

    setMessage("");

    setPrediction(null);

  };

  return (
    <div className="scratchpad-container">

      <h2>Workspace</h2>

      <div className="canvas-wrapper">

        <ReactSketchCanvas
          ref={canvasRef}
          strokeWidth={4}
          strokeColor="black"
          width="500px"
          height="500px"
        />

      </div>

      <div className="button-group">

        <button
          className="generate-btn"
          onClick={saveDrawing}
        >
          Predict
        </button>

        <button
          className="clear-btn"
          onClick={clearCanvas}
        >
          Clear
        </button>

      </div>

      {message && (
        <p className="status-message">
          {message}
        </p>
      )}

    </div>
  );
}

export default ScratchPad;