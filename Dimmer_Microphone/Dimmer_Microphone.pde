// 2017 Michael Flueckiger for HKB MEDIALAB
// Serial script for Vellemann K8064
// attach orange to 9 
// attach black to GND
// Plug in first consumer, then to the wallplug

import processing.sound.*;
import processing.serial.*;


// PORT sieht man in der Konsole. muss irgendwas mit tty.usbmodem sein
int port=4;

// The serial port:
Serial myPort;


float volume=0;
float drag=0.01;

AudioIn input;
Amplitude analyzer;

void setup() {
  size(800, 100);
  // List all the available serial ports:
  printArray(Serial.list());

  // Open the usbmodem tty port from the list in the console
  myPort = new Serial(this, Serial.list()[port], 9600);

  // Start listening to the microphone
  // Create an Audio input and grab the 1st channel
  input = new AudioIn(this, 0);

  // start the Audio Input
  input.start();

  // create a new Amplitude analyzer
  analyzer = new Amplitude(this);

  // Patch the input to an volume analyzer
  analyzer.input(input);
}


void draw() {


  float vol = analyzer.analyze();
  print(vol);
  volume+=vol;
  volume=constrain(volume, 0, 1);
  int dimmval=int(map(volume, 0, 1, 0, 255));
  dimmval=constrain(dimmval, 0, 255);
  // Send the value out the serial port
  myPort.write(dimmval+"\n");
  background(dimmval);
  println(" dimmval "+dimmval);
  if (volume>0)volume-=drag;
}






// ARDUINO CODE

/*
int ledPin = 9;    // LED connected to digital pin 9
 int dimval = 0;
 
 void setup() {
 // opens serial port, sets data rate to 9600 bps
 Serial.begin(9600);
 }
 
 void loop() {
 // Listen for Input
 while ( (Serial.available() > 0) )
 {
 int value = Serial.parseInt();
 if (Serial.read() == '\n') {
 Serial.println("");
 Serial.print(value);
 dimval = value;
 }
 }
 
 // send it to pmw
 analogWrite(ledPin, dimval);
 }
 */