# RISC-V-Processor-with-ML-Accelerator

> A hardware-software co-design project implementing multiple **RISC-V processor architectures** integrated with a **custom Machine Learning Accelerator** for **MNIST handwritten digit recognition**, optimized for FPGA deployment.

<p align="center">
  <img src="docs/images/system-overview.png" width="700" alt="System Architecture">
</p>

---

## Overview

This project explores hardware acceleration for machine learning by integrating a custom ML accelerator with progressively optimized RISC-V processors.

Instead of performing neural network inference entirely on the CPU, computationally intensive operations such as matrix multiplication and activation are offloaded to dedicated hardware, improving execution speed and hardware efficiency.

The project is developed incrementally, allowing comparison between different processor architectures while evaluating their impact on performance, area, and power.

---

## Features

- Custom RV32I RISC-V Processor
- Single-Cycle implementation
- Multi-Cycle implementation
- Five-Stage Pipelined implementation
- Hardware ML Accelerator for MNIST inference
- Processor ↔ Accelerator Interface
- FPGA Deployment
- Software vs Hardware Performance Comparison
- Web-based Demonstration Platform

---

## System Architecture

```
                   +----------------------+
                   |   Instruction Memory |
                   +----------+-----------+
                              |
                              v
                    +-------------------+
                    |   RISC-V Processor |
                    +---------+----------+
                              |
          +-------------------+-------------------+
          |                                       |
          v                                       v
+--------------------+                 +--------------------+
|    Data Memory     |                 | Interface Controller|
+--------------------+                 +----------+----------+
                                                  |
                                                  v
                                     +--------------------------+
                                     |   ML Accelerator         |
                                     |--------------------------|
                                     | Matrix Multiplication    |
                                     | Bias Addition            |
                                     | Activation Function      |
                                     | Prediction Logic         |
                                     +------------+-------------+
                                                  |
                          +-----------------------+----------------------+
                          |                                              |
                          v                                              v
                Weight & Bias Memory                          Input Image Memory
```

---

## Project Structure

```text
.
├── rtl/
│   ├── single_cycle/
│   ├── multi_cycle/
│   ├── pipeline/
│   ├── accelerator/
│   ├── interface/
│   └── common/
│
├── software/
│   ├── training/
│   ├── preprocessing/
│   └── weight_export/
│
├── simulations/
│
├── fpga/
│
├── docs/
│
├── web_demo/
│
├── testbench/
│
└── README.md
```

---

# Processor Roadmap

| Architecture | Status | Description |
|--------------|--------|-------------|
| Single Cycle | ⬜ | Baseline RV32I implementation |
| Multi Cycle | ⬜ | Reduced hardware usage through shared datapath |
| Five-Stage Pipeline | ⬜ | Improved throughput |
| Hazard Detection | ⬜ | Data and control hazard handling |
| Data Forwarding | ⬜ | Pipeline optimization |
| Branch Prediction *(Optional)* | ⬜ | Control hazard optimization |
| Cache *(Optional)* | ⬜ | Memory performance improvement |

---

# Machine Learning Accelerator

The accelerator performs inference for handwritten digit recognition.

### Pipeline

```
Input Image
      │
      ▼
Matrix Multiplication
      │
      ▼
Bias Addition
      │
      ▼
Activation Function
      │
      ▼
Prediction
```

### Core Components

| Module | Function |
|---------|----------|
| Matrix Multiplier | Computes neuron outputs |
| MAC Units | Parallel multiply-accumulate operations |
| Bias Unit | Adds trained bias values |
| Activation Unit | Applies activation function |
| Prediction Unit | Produces final digit |

---

# Workflow

```text
MNIST Dataset
      │
      ▼
Model Training (Python)
      │
      ▼
Export Weights & Biases
      │
      ▼
Memory Initialization Files
      │
      ▼
Hardware Accelerator
      │
      ▼
Processor Integration
      │
      ▼
FPGA Deployment
```

---

# Development Phases

| Phase | Objective |
|--------|-----------|
| 1 | Single-Cycle Processor |
| 2 | Multi-Cycle Processor |
| 3 | Pipelined Processor |
| 4 | Train ML Model |
| 5 | Design ML Accelerator |
| 6 | Processor-Accelerator Integration |
| 7 | FPGA Implementation |
| 8 | Web Demonstration |

---

# Tech Stack

| Category | Tools |
|----------|-------|
| Hardware Design | Verilog / SystemVerilog |
| Processor ISA | RV32I |
| FPGA | *[Board Name]* |
| Simulation | *[Simulator]* |
| ML Training | Python |
| Libraries | NumPy, TensorFlow / PyTorch *(choose one)* |
| Frontend | *[Framework]* |

---

# Performance Metrics

### Processor

- Execution Time
- Clock Frequency
- CPI
- Resource Utilization

### Accelerator

- Inference Latency
- Throughput
- Logic Utilization
- Memory Utilization

### Machine Learning

- MNIST Accuracy
- Prediction Accuracy

### Overall System

- End-to-End Latency
- FPGA Resource Usage
- Software vs Hardware Speedup

---

# Results

| Metric | Software | Hardware |
|---------|----------|----------|
| Inference Time | TBD | TBD |
| Speedup | — | TBD |
| Accuracy | TBD | TBD |
| LUT Usage | — | TBD |
| FF Usage | — | TBD |
| DSP Usage | — | TBD |
| BRAM Usage | — | TBD |
| Max Frequency | — | TBD |

---

# FPGA Demonstration

The final system demonstrates:

- RISC-V program execution
- ML accelerator inference
- Real-time digit prediction
- Resource utilization
- Execution latency comparison

> **Demo:** *[Insert video or GIF]*

---

# Future Improvements

- Branch Prediction
- Cache Support
- Quantized Neural Networks
- SIMD Instructions
- Larger Neural Networks
- Custom RISC-V Extensions
- Additional FPGA Optimizations

---

# Documentation

| Document | Link |
|----------|------|
| Architecture | *Coming Soon* |
| ISA Documentation | *Coming Soon* |
| Accelerator Design | *Coming Soon* |
| FPGA Reports | *Coming Soon* |
| Performance Analysis | *Coming Soon* |

---

# Contributors

| Name | Role |
|------|------|
| *Your Name* | Hardware Design |
| *Contributor* | ML Pipeline |
| *Contributor* | FPGA & Verification |

---

# License

This project is licensed under the **MIT License**.

See the `LICENSE` file for details.

---

## Acknowledgements

- RISC-V Foundation
- MNIST Dataset
- FPGA Vendor Documentation
- Open-source hardware community