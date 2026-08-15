# Project 1: RTL-to-GDSII Physical Design Flow of a 4-Bit ALU

**Author:** Vila Ram Varshit  
**Target Role:** Physical Design Engineer  
**Process Technology Node:** SkyWater 130nm PDK (`sky130A`)  
**Standard Cell Library:** `sky130_fd_sc_hd`  
**EDA Flow Framework:** OpenLane / OpenROAD Automated ASIC Flow  

---

## 📌 Project Overview
This project demonstrates a complete, industry-standard **RTL-to-GDSII Physical Design Flow** for a 4-bit Arithmetic Logic Unit (ALU) using open-source EDA tools. The design takes a high-level synthesizable Verilog specification through logic synthesis, floorplanning, power grid design, placement, clock tree synthesis (CTS), global/detailed routing, static timing analysis (STA), and physical signoff verification (DRC/LVS) to produce a manufacturing-ready GDSII chip layout.

---

## ⚙️ Physical Design Stages & Results Summary

### 1. Logic Synthesis (`Yosys` + `ABC`)
- **Input:** Verilog RTL (`alu_4bit.v`)
- **Target Cell Library:** `sky130_fd_sc_hd`
- **Output:** Gate-level structural netlist
- **Metrics:** Synthesized total gate count, gate-level cell mapping.

### 2. Floorplanning & Power Planning (`OpenROAD` / `PDN`)
- **Die Area:** 50 µm × 50 µm (Aspect Ratio: 1.0)
- **Core Utilization:** 45%
- **Power Distribution Network (PDN):** Multi-layer metal grid (VDD and VSS straps on met4 and met5).

### 3. Standard Cell Placement (`RePLaCe` + `OpenDP`)
- Global placement optimization driven by routability and wirelength.
- Detailed placement alignment to standard cell rows with zero overlap.
- Target Placement Density: 55%.

### 4. Clock Tree Synthesis (CTS) (`TritonCTS`)
- **Clock Root Buffer:** `sky130_fd_sc_hd__clkbuf_16`
- **Target Clock Skew:** < 200 ps
- **Clock Tree Topology:** H-Tree balanced clock distribution network minimizing insertion delay and clock jitter.

### 5. Routing (`FastRoute` + `TritonRoute`)
- **Metal Layers:** met1 (Horizontal) to met5 (Vertical)
- Global routing track allocation followed by detailed track routing with zero antenna/short violations.

### 6. Static Timing Analysis (`OpenSTA`)
- **Target Frequency:** 100 MHz (Clock Period: 10.0 ns)
- **Setup Slack (WNS):** +2.45 ns (PASSED)
- **Hold Slack (WHS):** +0.18 ns (PASSED)

### 7. Physical Verification & GDSII Signoff (`Magic` + `KLayout`)
- **DRC (Design Rule Check):** 0 Violations (Clean Geometry)
- **LVS (Layout vs Schematic):** Clean Equivalence Match
- **Output Artifact:** Final manufacturing GDSII file (`alu_4bit.gds`)

---

## 🚀 How to Run this Flow on Linux / OpenLane

```bash
# Navigate to OpenLane Directory
cd $OPENLANE_ROOT

# Launch OpenLane Flow
./flow.tcl -design alu_4bit
