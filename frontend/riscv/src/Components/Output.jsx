import "./Output.css";

function Output({
  prediction,
  loading
}) {

  return (

    <div className="output-card">

      <div className="output-label">
        Predicted Digit
      </div>

      <div className="output-value">

        {loading
          ? "..."
          : prediction ?? "-"}

      </div>

    </div>

  );
}

export default Output;