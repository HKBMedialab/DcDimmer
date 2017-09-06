// 2017 Michael Flueckiger for HKB MEDIALAB
// Serial script for Vellemann K8064
// attach orange to 9 
// attach black to GND



import processing.serial.*;

// The serial port:
Serial myPort;



void setup(){
  size(800,100);
// List all the available serial ports:
printArray(Serial.list());

// Open the usbmodem tty port from the list in the console
myPort = new Serial(this, Serial.list()[5], 9600);

}


void draw(){
  int dimmval=int(map(mouseX,0,width,0,255));
  // Send the value out the serial port
  myPort.write(dimmval+"\n");
  
  background(dimmval);
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