//Download the Arduino STL File from the Arduino Page
//https://docs.arduino.cc/hardware/nano-rp2040-connect
module ArduinoNanoRP2040Connect(){
    //import("ArduinoNanoRp2040ConnectFixed.stl", convexity=300);
    translate([0, 0, -1.6]){
        cube([43.2, 19, 1.8]);
    }
}

ArduinoNanoRP2040Connect();
