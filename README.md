# 4-bit Magnitude Comparator Verification Project

A comprehensive SystemVerilog verification environment for a 4-bit Magnitude Comparator, simulated on **EDA Playground** using the **Aldec Riviera Pro** toolchain.

## 🚀 Project Overview

This project verifies a 4-bit magnitude comparator that compares two 4-bit inputs (`a`, `b`) and produces three mutually exclusive outputs:

- `gt` → High when `a > b`
- `lt` → High when `a < b`
- `eq` → High when `a == b`

The verification environment follows a constrained-random methodology combined with assertion-based verification and functional coverage to ensure complete correctness across all 256 input combinations.

### 🔗 Run on EDA Playground
👉 *https://www.edaplayground.com/x/Shdg*  

---

## 🛠️ Verification Architecture

The testbench follows a modern SystemVerilog verification strategy:

- **Transaction-Based Randomization**  
  A class-based generator creates randomized 4-bit values for `a` and `b` using `rand` variables and constraints.

- **One-Hot Output Validation**  
  The testbench ensures only one of `gt`, `lt`, or `eq` is asserted at any given time.

- **Functional Coverage**
  - Coverpoints for full 4-bit input range (0–15)
  - Output state coverage (`gt`, `lt`, `eq`)
  - Cross coverage of `a × b` (256 total combinations)

- **Self-Checking Scoreboard**
  - Compares DUT outputs against expected mathematical comparison.
  - Reports mismatches immediately using `$error`.

- **SystemVerilog Assertions (SVA)**
  - `assert((gt + lt + eq) == 1)` → Validates one-hot behavior.
  - Property-based checks ensure correct comparison logic.

---

## 📁 File Structure

- `rtl.sv`: 4-bit comparator RTL using `always_comb` logic.
- `tb.sv`: SystemVerilog testbench with:
  - Randomized transaction class
  - Covergroups
  - Assertions
  - Scoreboard logic
  - Waveform dumping
- `README.md`: Project documentation.

---

## 📊 How to Analyze Results

1. **Console Log**
   - Check for assertion failures or `$error` messages.
   - Observe the final printed functional coverage percentage.
   - Coverage improves significantly as iteration count increases (e.g., 50 → ~70%, 500 → ~97–100%).

2. **Functional Coverage**
   - Coverage is printed at the end of simulation using:
     ```
     Coverage = 97.27%
     ```

3. **EPWave Analysis**
   - Add signals: `a`, `b`, `gt`, `lt`, `eq`.
   - **Pro Tip**: Set `a` and `b` radix to **Decimal** for easier comparison visualization.

---

## 🛡️ Assertions in Action

The environment is designed for fail-fast verification:

- If multiple outputs are asserted simultaneously → Assertion failure.
- If DUT output mismatches expected comparison → Scoreboard error.
- All mismatches include timestamp and signal values for easier debugging.

To demonstrate robustness, intentionally introduce a bug in RTL (e.g., incorrect comparison operator). The simulation will immediately flag assertion violations and mismatches in the console log.

---

## 🎯 Key Verification Concepts Demonstrated

- Constrained-random verification
- Assertion-Based Verification (ABV)
- Functional cross coverage
- Self-checking testbench methodology
- Coverage-driven iteration refinement
- One-hot property validation

---

## 👩‍💻 Author

**Ahalya Sivakumar**  
Design Verification Engineer  
SystemVerilog | SVA | Functional Coverage | UVM (Learning)
