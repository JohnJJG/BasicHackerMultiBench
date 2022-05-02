/* Continuity Tester
 
   AtTiny85 DigiSpark version John Gilmour 15 Sept 2021
   Original: http://www.technoblogy.com/show?1YON (David Johnson-Davies Nov 2017)

   This a simpler build than David's, uses a USB Programmable board (Digispark)
   with one resistor and active buzzer.  A passive buzzer is a problem on P4 for
   this board so but an active buzzer simplifies programming, costs only  ~$0.50
   and can be attached to Pin 2

   There are plenty of  guides on programming a DigiSpark board (or clones)
   e.g. http://digistump.com/wiki/digispark/tutorials/connecting
   
   CC BY 4.0
   Licensed under a Creative Commons Attribution 4.0 International license: 
   http://creativecommons.org/licenses/by/4.0/
*/

const int Reference = 0;                  // AIN0
const int Probe = 1;                      // AIN1
const int SPEAKER_PIN = 2;
const int P3 = 3;
const int P4 = 4;

void setup () {
  pinMode(Reference, INPUT_PULLUP); // Reference Pin AIN0
  pinMode(Probe, INPUT_PULLUP);     // Reference PIN AIN1
  pinMode(SPEAKER_PIN, OUTPUT);     // Speaker Pin P2
  pinMode(P3, OUTPUT);              // Unused P4 (Dont leave floating)
  pinMode(P4, OUTPUT);              // Unused P4 (Dont leave floating) 
}

//Apart from pin setup just one line of code, buzz when >50ohm
void loop() {
  digitalWrite(SPEAKER_PIN, ACSR>>ACO & 1);  // Analog Comparator result is bit 5 of the ACSR register (If (AIN+) > (AIN-)  ACO = 1)
}
