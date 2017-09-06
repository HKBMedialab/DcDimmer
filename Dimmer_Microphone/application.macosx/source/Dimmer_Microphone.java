import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Dimmer_Microphone extends PApplet {

// 2017 Michael Flueckiger for HKB MEDIALAB
// Serial script for Vellemann K8064
// attach orange to 9 
// attach black to GND
// Plug in first consumer, then to the wallplug





float volume=0;
float drag=0.01f;

// The serial port:
Serial myPort;

AudioIn input;
Amplitude analyzer;

public void setup() {
  
  // List all the available serial ports:
  printArray(Serial.list());

  // Open the usbmodem tty port from the list in the console
  myPort = new Serial(this, Serial.list()[3], 9600);

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


public void draw() {


  float vol = analyzer.analyze();
  print(vol);
  volume+=vol;
  volume=constrain(volume, 0, 1);
  int dimmval=PApplet.parseInt(map(volume, 0, 1, 0, 255));
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
  public void settings() {  size(800, 100); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Dimmer_Microphone" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
