# Overview
A one stop shop with fixed 5V/12V/24V/USB metered power, adjustable power supply, voltmeter, continuity tester and basic oscilloscope.

![alt text](https://github.com/JohnJJG/BasicHackerMultiBench/blob/main/images/MultiBench%20(Main).JPG?raw=true)

# Introduction
It is probably a rite of passage for any hardware hacker to build their own bench supply but with limited desk space I wanted to add a few more standard features that would mean I had everything in one place.

I had a basic list of needs:
1. Current measuring and supply of 5V, 12V, and 24V
2. Variable power supply with current limiting
3. Continuity tester
4. Voltmeter
5. USB Power
6. Oscilloscope – ok, not essential but I had it lying around – sue me.
7. Low cost – not meant to replace the good stuff

Most of the effort has gone into the 3D case for components and power supply. I have tried to do this in a modular fashion in OpenSCAD to allow the configuration to be changed.

The main components of this are DSP3005 Programmable Power Supply (\~$28) and a DSO150 basic oscilloscope (\~$50 for an original). The rest are standard parts like volt/ammeter, voltmeter, binding posts, switch, connectors, dc buck converters, DC to USB

# Before you start
This is an intermediate level project and assumes familiarity with buck converters and soldering.  The space is tight and may require a little adjustment of wires as components are added.  The PSU is an optional part of the build but is fully integrated.  The PSU involves working with mains voltage so do not do this part if you are not use to working with mains voltages (because…death etc).  An alternative is to get a 24V 5A brick supply and add an XT60 female connector.

# Build First
Solder red/black wires to the two LM2596 converters and set the voltage to 12V and 5V (24V input)

Solder red/black wires to the MP1584 converter and set voltage to 9V (24V input) and cover with clear heat shrink

DSO150 – Build the kit and connect the MP1584 converter in place of the 9V jack

![alt text](https://github.com/JohnJJG/BasicHackerMultiBench/blob/main/wiring/DSO150%20and%20MP1584.png?raw=true)

Continuity Tester – Solder the buzzer and resistor to the ATTINY85 board and program Solder together the Voltmeter, Continuity Tester and selection switch and cover the attiny with clear heat shrink

![alt text](https://github.com/JohnJJG/BasicHackerMultiBench/blob/main/wiring/Voltmeter%20and%20Continuity.png?raw=true)

![alt text](https://github.com/JohnJJG/BasicHackerMultiBench/blob/main/wiring/AtTiny85%20Continuity%20Build.png?raw=true)


# Build Order
Screw in all of the binding posts (6 posts, 2 sockets as in picture) with 1 nut

Screw in the DSO150 (4 short screws for the main board, 2 long for encoder switch and 1 long for the analogue daughter board

Slot in the slide switch, voltmeter

Screw in the 5V LM2596 converter to the side panel beside the DSO150

Slide in the LM2596S Dual USB Power Supply (don’t screw in until all wiring done)

Run wire between the two LM2596S Dual USB and onto the LM2596 converter

Slot in the volt/ammeter to the centre and connect to 5V and posts as per diagram

Slot in the volt/ammeter to the side and connect to on-off-on switch and posts as per diagram

Screw in the 12V LM2596 converter to the side panel below the DPS3005

![alt text](https://github.com/JohnJJG/BasicHackerMultiBench/blob/main/wiring/Power%20Meter%20and%20DPS3005%20Wiring.png?raw=true)
