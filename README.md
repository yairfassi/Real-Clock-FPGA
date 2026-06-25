# Real Clock Project (VHDL Real-Time Clock)

This project implements a modular digital real-time clock designed in VHDL, targeted and fully deployed on the **Digilent Basys 3 FPGA Trainer Board**. The system tracks and displays hours, minutes, and seconds while allowing the user to manually set and load time components independently using onboard peripherals.

## Target Hardware: Digilent Basys 3
The project is built to take full advantage of the Basys 3 FPGA architecture, utilizing its onboard 100MHz oscillator, slide switches, pushbuttons, and 7-segment display structures.

* **Official Documentation:** For detailed hardware specifications, pin mappings, and schematics, refer to the [Digilent Basys 3 Reference Manual](https://digilent.com/reference/programmable-logic/basys-3/reference-manual).

### Hardware Overview
http://googleusercontent.com/image_collection/image_retrieval/10664050825916896134

---

## Project Demonstration (Video)
See the real-time clock in action! The video below demonstrates the hardware configuration, the manual time-setting mechanism using the switches, and peripheral interaction.

<video src="clock.mp4" controls width="100%" poster="https://digilent.com/reference/_media/programmable-logic/basys-3/basys3-0.png">
  Your browser does not support the video tag. You can watch it directly here: [Download clock.mp4](./clock.mp4)
</video>

---

## Key Features
* **Dual-Display Architecture:** Minutes and seconds are rendered dynamically using the built-in 4-digit On-board Seven Segment Display (SSD) of the Basys 3. Hours are displayed on an external peripheral module via a PMOD-SSD component connected to the board's expansion ports.
* **Manual Time Adjustment (Load Mechanism):** Users can adjust hours, minutes, or seconds individually using the Basys 3 slide switches (`DATA_IN`) and hardware input flags.
* **Accelerated Test Mode:** Features a dedicated simulation/test flag that bypasses the massive frequency division factors, enabling rapid verification of counter roll-overs without waiting for real-world time to elapse.
* **Display Multiplexing:** Implements an internal refresh timer (~4ms per digit) to smoothly cycle the anodes/cathodes, avoiding visual flickering while severely reducing the required FPGA I/O pin count.

---

## System Architecture & File Structure

The project follows a clean, hierarchical design:

### 1. Top-Level Entity
* **`real_clock.vhd`**: The root module that integrates the functional logic (`CLOCK_BASE`), the addressing mechanics (`TIME_SEL`), and the shared hardware display interface.

### 2. Timebase & Core Logic Modules
* **`clock_base.vhd`**: Houses the hardware prescalers (frequency dividers) and synchronous up-counters for seconds (0-59), minutes (0-59), and hours (0-23). It handles conditional overrides when a `LOAD` operation takes place.
* **`time_sel` (Internal Sub-component):** Decodes the 2-bit address lines (`ADDRS`) to isolate which specific time metric (seconds, minutes, or hours) is targeted for configuration.

### 3. Display Drivers & Decoders
* **`ssgInterface.vhd`**: Acts as a comprehensive display manager, grouping the internal board display drivers and peripheral PMOD drivers into a unified bus map.
* **`ssg.vhd`**: Drives the onboard common-anode 7-segment array. It cycles an indexing counter to multiplex the tens and ones digits of both minutes and seconds.
* **`binToSSG.vhd`**: A 6-bit binary decoder mapping integers up to 59 to their corresponding segment patterns for **Common Anode** displays.
* **`pmod_ssd.vhd`**: Controls the external PMOD-SSD module to render hours, switching back and forth between the tens and units places of the current hour.
* **`binToSSG_SSD.vhd`**: A binary-to-7-segment decoder tailored for the PMOD accessory, utilizing **Common Cathode** logic.

### 4. Hardware Constraints
* **`real_clock.xdc`**: The Xilinx Design Constraints file mapping the structural VHDL port declarations directly to the physical Basys 3 pin package, configuring I/O standards (`LVCMOS33`), and defining the master system clock period (100MHz / 10ns constraint).

---

## I/O Port Specifications

Below is the pin specification layout mapping directly to the Top-Level (`REAL_CLOCK`) entity and Basys 3 board components:

| Port Name | Direction | Data Width | Description |
| :--- | :---: | :---: | :--- |
| `CLK` | Input | 1 bit | Master board clock input (100MHz oscillator source on pin W5) |
| `RESET` | Input | 1 bit | Synchronous global reset signal, Active-High. |
| `TESTMODE` | Input | 1 bit | Fast-forward flag: `1` accelerates clock intervals for testing; `0` targets exact 1-second cycles. |
| `LOAD` | Input | 1 bit | Strobe signal to commit manual input values into the internal registers. |
| `ADDRS` | Input | 2 bits | Destination selection: `00` = Seconds, `01` = Minutes, `10` = Hours. |
| `DATA_IN` | Input | 6 bits | Binary input bus wired to physical toggle switches for setting values. |
| `LED_OUT` | Output | 8 bits | Segment enable patterns (`A` through `G` + Decimal Point) for the on-board display. |
| `ANODE_ACTIVATE` | Output | 4 bits | Active-Low digit selectors used to strobe each of the 4 on-board displays. |
| `LED_OUT_SSD` | Output | 7 bits | Segment lines routed directly to the external PMOD-SSD hours pins. |
| `CATHODE_ACTIVATE_SSD`| Output | 1 bit | Toggles control between the right and left digit spaces on the PMOD module. |

---

## Operating Instructions

1. **System Reset:** Toggle the designated `RESET` switch or button on your Basys 3 board to high (`1`) and return it to low (`0`). This synchronizes the system state back to `00:00:00`.
2. **Setting Time Manually (Load Execution):**
   * Adjust the 2-bit `ADDRS` switches to select the unit you want to update (e.g., `01` to modify minutes).
   * Convert your intended target value into binary using the 6 slide switches tied to `DATA_IN` (e.g., for the 15th minute, flip the switches to represent binary `001111`).
   * Trigger the `LOAD` switch/push-button to instantly override and latch the value into the system memory.

---

## Simulation and Compilation Notes

* **Simulation Routine (ModelSim / Vivado Simulator):** Before initiating a behavioral simulation wave test, make sure to force the `TESTMODE` signal to `1`. Doing so shrinks the prescaler limits drastically, causing counters to roll over in mere nanoseconds rather than requiring lengthy, memory-intensive real-time simulations.
* **Synthesis & Deployment:** This source codebase has been fully tested using the **Xilinx Vivado Design Suite**. Include all VHDL source modules along with the `real_clock.xdc` file in your project directory to run Synthesis, Implementation, and generate the target device `.bit` file for the Basys 3 Board.

---
**Developed By:** Yair Fassi.
