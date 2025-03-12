# **FPGA-Based Digital Clock Stop Watch and Counter**

This project contains Verilog modules for implementing an FPGA-based **digital clock** and a **7-segment display counter** using **Xilinx Vivado**.  
The modules include a **digital clock, a 7-segment display counter,** and an **input-output test module**.

---

## **Modules Description**

### 1. **ssd_counter**  
Implements a **7-segment display counter**.  

#### **Functionality:**  
- Uses a **clock divider** to generate a **1-second pulse**.  
- Counts from **0 to 9** and displays corresponding digits on a **7-segment display**.  

#### **Ports:**  
- `clk` : System clock.  
- `reset` : Resets the counter.  
- `anode[7:0]` : Controls the **anode** of the display.  
- `segment[6:0]` : Controls the **segments** of the display.  

#### **Working Mechanism:**  
- Generates a **1-second clock pulse** using a **counter**.  
- Increments the count from **0 to 9**.  
- Displays the corresponding digit on a **7-segment display**.  

---

### 2. **Digital_clk**  
Implements a **digital clock** displaying **HH:MM:SS** on a **7-segment display**.  
Handles **hours, minutes, and seconds** with proper roll-over conditions.  

#### **Ports:**  
- `clk` : System clock.  
- `reset` : Resets the clock to **00:00:00**.  
- `anode[7:0]` : Controls **which digit is displayed**.  
- `segment[6:0]` : Controls the **displayed number**.  

#### **Functionality:**  
- Generates a **1-second clock pulse** using a **counter**.  
- Tracks **seconds, minutes, and hours**.  
- Rolls over time values appropriately (**seconds → minutes → hours**).  
- Displays time on a **multiplexed 7-segment display**.  
- Uses **anode control** to switch between digits.  

---

### 3. **IN_OUT_test**  
Simple **counter test module** that counts up to **15** and resets.  

#### **Ports:**  
- `in_clk` : Input clock signal.  
- `reset` : Resets the counter.  
- `count[15:0]` : **16-bit output counter**.  

#### **Functionality:**  
- Uses a **clock divider** to control **counting speed**.  
- Increments the count up to **15** and resets.  

---
### 4. **Stop_watch**
This module functions as a **digital stopwatch** with display multiplexing on a **7-segment display**.  

#### **Features:**
✅ Displays **milliseconds, seconds, minutes, and hours**  
✅ **Start/Stop** functionality  
✅ **Reset** capability  
✅ Uses **clock division** to generate a 1ms pulse  
✅ Multiplexed **7-segment display control**  


#### **Ports Description**
| **Port**      | **Direction** | **Description** |
|--------------|--------------|----------------|
| `clk`        | **Input**     | System clock input |
| `reset`      | **Input**     | Resets the stopwatch to `00:00:00:00` |
| `stop`       | **Input**     | Freezes the time when high (`1`) |
| `anode[7:0]` | **Output**    | Controls the active digit on the **7-segment display** |
| `segment[6:0]` | **Output**  | Controls the **7-segment display segments** |


#### **Working Mechanism**
###### **Clock Divider for Millisecond Pulse**
- The system clock is divided down to generate a **1ms pulse** using `millisec_counter`.  
- This pulse is used to **increment** the stopwatch time.

###### **Time Incrementation Logic**
- **Milliseconds** increase from `0 → 99`.  
- **Seconds** increase from `0 → 59`.  
- **Minutes** increase from `0 → 59`.  
- **Hours** increase from `0 → 99`.  
- The **stop** signal **pauses** the timer without resetting the values.

### **7-Segment Display Multiplexing**
- The display cycles through **8 digits** (`ms, sec, min, hr`).  
- The active digit is selected by controlling the **anode signals**.  
- The corresponding number is displayed using **7-segment encoding**.

---

## **7-Segment Display Encoding**
The module uses **common anode** encoding:

| **Digit** | **Segment Pattern (Active Low)** |
|----------|-------------------------------|
| `0` | `1000000` |
| `1` | `1111001` |
| `2` | `0100100` |
| `3` | `0110000` |
| `4` | `0011001` |
| `5` | `0010010` |
| `6` | `0000010` |
| `7` | `1111000` |
| `8` | `0000000` |
| `9` | `0010000` |

---

## **Tools & Requirements**  
- **FPGA Board** (e.g., Xilinx FPGA)  
- **Xilinx Vivado**  
- **Verilog HDL**  


