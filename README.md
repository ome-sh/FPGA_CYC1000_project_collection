# CYC1000 FPGA Projects Collection

A comprehensive collection of Verilog projects for the CYC1000 FPGA board, progressing from basic digital logic to advanced hardware implementations.

## Projects Overview

### 📟 **p0_blinky**
Classic "Hello World" for FPGA - LED blinking pattern
- Basic GPIO control
- Clock dividers and timing
- Perfect starting point for FPGA beginners

### 🔢 **p1_8bit_LED_Counter**
8-bit binary counter with LED visualization
- Counter logic implementation
- Binary representation display
- Clock domain concepts

### 🌈 **p2_rgb_led**
RGB LED color control and PWM generation
- PWM signal generation
- Color mixing algorithms
- Analog output from digital signals

### 📺 **p3_ByteDisplay**
Byte value display system
- Display interface control
- Data formatting and visualization
- Human-readable output generation

### 🔐 **p4_SHA256** ⚠️
**Educational SHA256 brute-force password cracker**
- Hardware implementation of SHA256 algorithm
- Parallel processing for password cracking
- **FOR EDUCATIONAL PURPOSES ONLY**
- Demonstrates cryptographic hardware acceleration

### 🔄 **p5_SPI**
SPI communication protocol implementation
- Master/Slave communication
- Serial data transmission
- Protocol timing and control signals

### 🔍 **p6_Logic_Analyzer**
Hardware logic analyzer for signal debugging
- Multi-channel signal capture
- Trigger conditions and timing analysis
- FPGA-based test equipment

## Hardware Requirements

- **CYC1000 FPGA Board** (Intel Cyclone 10 LP)
- **Quartus Prime Lite** (Free Intel FPGA development environment)
- USB-Blaster or compatible programmer
- Basic electronic components (LEDs, resistors, etc.)

## Getting Started

### Prerequisites
```bash
# Install Quartus Prime Lite from Intel
# Ensure USB-Blaster drivers are installed
```

### Building Projects
1. Open Quartus Prime
2. Open the desired project folder
3. Compile the design (`Ctrl+L`)
4. Program the FPGA (`Tools > Programmer`)

### Project Structure
```
px_ProjectName/
├── src/           # Verilog source files
├── constraints/   # Pin assignments and timing
├── simulation/    # Testbenches
└── quartus/       # Quartus project files
```

## Educational Value

This collection demonstrates:
- **Digital Logic Design**: From basic gates to complex systems
- **Hardware Description Languages**: Practical Verilog implementation
- **FPGA Architecture**: Utilizing FPGA resources effectively
- **Real-World Applications**: Communication, cryptography, and test equipment
- **Progressive Learning**: Each project builds on previous concepts

## ⚠️ Important Notice

The **p4_SHA256** project implements a brute-force password cracker for **educational and research purposes only**. This demonstrates:
- Hardware acceleration of cryptographic algorithms
- Parallel processing advantages in FPGAs
- Security research methodologies

**Not intended for malicious use. Use responsibly and in compliance with local laws.**

## Learning Path

**Recommended order for beginners:**
1. `p0_blinky` - Learn FPGA basics
2. `p1_8bit_LED_Counter` - Understand sequential logic
3. `p2_rgb_led` - Explore PWM and analog concepts
4. `p3_ByteDisplay` - Interface with displays
5. `p5_SPI` - Communication protocols
6. `p6_Logic_Analyzer` - Advanced signal processing
7. `p4_SHA256` - Complex algorithm implementation

## Resources

- [CYC1000 Board Documentation](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=&No=1265)
- [Intel Quartus Prime User Guide](https://www.intel.com/content/www/us/en/programmable/documentation/quartus_prime/)
- [Verilog HDL Reference](https://www.intel.com/content/www/us/en/programmable/documentation/verilog_hdl/)

## Contributing

Feel free to:
- Report issues or bugs
- Suggest improvements
- Add new projects to the collection
- Share your own implementations

## License

These projects are provided for educational purposes. Please respect local laws and ethical guidelines, especially regarding the cryptographic implementations.

---

*Happy FPGA learning! 🚀*
