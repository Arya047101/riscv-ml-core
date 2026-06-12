import "./Description.css";

function Description() {
  return (
    <div className="description-container">
      <p className="typewriter">
        This project demonstrates handwritten digit
        recognition on a RISC-V based platform. Users
        can draw digits on the scratch pad, convert
        them into image data, and process them through
        a machine learning pipeline optimized for
        embedded systems. The objective is to showcase
        the integration of artificial intelligence and
        open-source RISC-V hardware for efficient edge
        computing applications.
      </p>
    </div>
  );
}

export default Description;