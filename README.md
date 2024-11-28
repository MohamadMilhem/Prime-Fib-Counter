# Prime-Fib-Counter

## Objective
The goal of this project is to design a special counter capable of counting two distinct sequences:
1. **Prime Numbers Sequence**
2. **Fibonacci Sequence**

The counter can operate in both up and down modes and should handle the first 11 numbers of either sequence, depending on input controls.

---

## Project Description

### Task Overview
- **Design Philosophy**:  
  A structural circuit is constructed using **T-Flip Flops** and combination logic to achieve the following functionalities:
  - Select between Prime Numbers and Fibonacci sequence using an input.
  - Count in either up or down direction using another input.
  - Include:
    - **Reset Input** (asynchronous): Resets the counter.
    - **Enable Input** (synchronous): Enables or disables counting.

- **Verification**:  
  A Verilog **testbench** was written to simulate and verify the design, ensuring proper functionality under various scenarios. The testbench also reports any errors.

- **Peer Evaluation**:  
  The design was tested against testbenches created by other students to validate robustness.

---

## Design Features

### Inputs
- **Select Input**: Chooses between Prime Numbers or Fibonacci sequence.
- **Direction Input**: Chooses between counting up or down.
- **Reset Input**: Asynchronous reset to initialize the counter.
- **Enable Input**: Synchronous input to enable/disable counting.

### Outputs
- The current value of the counter, representing numbers in the selected sequence.

### Functional Highlights
1. Handles both sequences up to the first 11 numbers.
2. Simulates up and down counting with synchronous and asynchronous controls.
3. Ensures modular design using **T-Flip Flops** and combination logic.

---

## Key Components

### Verilog Code
- A well-structured Verilog file that implements:
  - Counter logic.
  - Modular design principles.
  - Asynchronous and synchronous control mechanisms.
  
### Testbench
- A detailed Verilog testbench designed to:
  - Test the counter functionality.
  - Validate behavior for all inputs.
  - Report any errors in design performance.

---

## Results
- Simulation verified the counter operates as expected:
  - Counts Prime Numbers and Fibonacci sequences accurately.
  - Handles reset and enable conditions.
  - Counts in both up and down modes.

---

## Conclusion and Future Work
- **Conclusion**:  
  The project successfully achieved its objective of designing a special counter with dual-sequence functionality and up/down counting modes.

- **Future Work**:
  - Expand the counter to handle additional sequences or larger ranges.
  - Improve efficiency of combination logic for sequence generation.
  - Implement hardware testing using FPGA.

---

## Instructions for Use
1. Clone this repository.
2. Open the Verilog code file in your preferred simulator (e.g., ModelSim, Vivado).
3. Run the testbench to simulate the design.
4. Observe and validate results for Prime and Fibonacci sequence counting in both directions.

---

## License
This project is for educational purposes. Any form of plagiarism or unauthorized use is strictly prohibited.

---
