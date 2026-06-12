const express = require("express");
const fs = require("fs");
const path = require("path");
const cors = require("cors");
const { execSync } = require("child_process");

const app = express();

app.use(cors());

app.use(
  express.json({
    limit: "50mb",
  })
);

// Create png folder
fs.mkdirSync(
  path.join(__dirname, "png"),
  { recursive: true }
);

app.post("/api/convert", (req, res) => {

  try {

    console.log("\n============================");
    console.log("NEW REQUEST RECEIVED");
    console.log("============================");

    //----------------------------------
    // Save PNG
    //----------------------------------

    const { image } = req.body;

    if (!image) {
      throw new Error("No image received");
    }

    const base64 = image.replace(
      /^data:image\/png;base64,/,
      ""
    );

    const pngPath = path.join(
      __dirname,
      "png",
      "drawing.png"
    );

    fs.writeFileSync(
      pngPath,
      base64,
      "base64"
    );

    console.log("✓ PNG saved");
    console.log("Location:", pngPath);

    //----------------------------------
    // Run convert.py
    //----------------------------------

    console.log("\nRunning convert.py...");

    const pythonOutput = execSync(
      "python3 convert.py",
      {
        cwd: __dirname,
        encoding: "utf8"
      }
    );

    console.log("✓ Python completed");
    console.log(pythonOutput);

    //----------------------------------
    // Check output.hex
    //----------------------------------

    const hexPath = path.join(
      __dirname,
      "../ai-models",
      "output.hex"
    );

    if (!fs.existsSync(hexPath)) {
      throw new Error(
        `output.hex not found at ${hexPath}`
      );
    }

    console.log("✓ output.hex found");

    //----------------------------------
    // Compile Verilog
    //----------------------------------

    console.log("\nCompiling Verilog...");

    const compileOutput = execSync(
      "iverilog -o sim accelerator_tb.v",
      {
        cwd: path.join(
          __dirname,
          "../ai-models"
        ),
        encoding: "utf8"
      }
    );

    console.log("✓ Compilation successful");

    if (compileOutput) {
      console.log(compileOutput);
    }

    //----------------------------------
    // Run Simulation
    //----------------------------------

    console.log("\nRunning simulation...");

    const simOutput = execSync(
      "vvp sim",
      {
        cwd: path.join(
          __dirname,
          "../ai-models"
        ),
        encoding: "utf8"
      }
    );

    console.log("✓ Simulation finished");

    if (simOutput) {
      console.log(simOutput);
    }

    //----------------------------------
    // Check prediction file
    //----------------------------------

    const predictionPath =
      path.join(
        __dirname,
        "../ai-models",
        "prediction.txt"
      );

    if (!fs.existsSync(predictionPath)) {
      throw new Error(
        `prediction.txt not found at ${predictionPath}`
      );
    }

    console.log("✓ prediction.txt found");

    //----------------------------------
    // Read prediction
    //----------------------------------

    const prediction =
      fs.readFileSync(
        predictionPath,
        "utf8"
      ).trim();

    console.log(
      "Prediction:",
      prediction
    );

    //----------------------------------
    // Success Response
    //----------------------------------

    res.json({
      success: true,
      prediction
    });

  } catch (error) {

    console.log("\n============================");
    console.log("PIPELINE FAILED");
    console.log("============================");

    console.error(error);

    res.status(500).json({
      success: false,
      error: error.message,
      fullError: error.toString()
    });

  }

});

app.listen(5001, () => {

  console.log(
    "Server running on http://localhost:5001"
  );

});