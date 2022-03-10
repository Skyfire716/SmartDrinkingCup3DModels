use <ultrasonicCarrier.scad>
use <Getriebe.scad>
use <clip.scad>

$fn=150;

UltrasonicArmCarrier(180);
//UltrasonicArmCarrierCover(180);

cupHeight = 180;
//Width
//Thickness
//Length
properties = [4, 1, 7.5];


module UltrasonicArmCarrier(cupHeight){
    difference(){
        union(){
            translate([15, -12.75, cupHeight - 17.5]){
                ultrasonic_carrier();
            }
            translate([0, 0, cupHeight -17.5]){
                hohlrad (modul=1, zahnzahl=10, breite=17.5, randbreite=1, eingriffswinkel=20, schraegungswinkel=0);
            }
            difference(){
                hull(){
                    translate([13, -12.75, cupHeight- 17.5]){
                        cube([2, 25.5, 17.5]);
                    }
                    translate([0, 0, cupHeight - 8.75]){
                        cylinder(17.5, 7.5, 7.5, true);
                    }
                }
                union(){
                    translate([0, 0, cupHeight - 8.75]){
                        cylinder(18, 6.5, 6.5, true);
                    }
                    translate([8, -3.25, cupHeight - 6]){
                        cube([6.5, 6.5, 10]);
                    }
                }
            }
        }
        union(){
            translate([0, -3, cupHeight -15]){
                rotate([0, -30, 0]){
                    cube([25, 6, 4]);
                }
            }
            translate([0, 0, cupHeight - 0.8]){
                translate([65.3, 0, 0]){
                    rotate([0, 0, 90]){
                        clip(properties, false);
                    }
                }
                translate([2.7, -10, 0]){
                    rotate([0, 0, -20]){
                        clip(properties, false);
                    }
                }
                translate([2.7, 10, 0]){
                    rotate([0, 0, 200]){
                        clip(properties, false);
                    }
                }
            }
        }
    }
}

module UltrasonicArmCarrierCover(cupHeight){
    union(){
        difference(){
            translate([0, 0, 17.5]){
                hull(){
                    translate([13, -14.5, cupHeight- 19.5]){
                        cube([2, 29, 5]);
                    }
                    translate([64, -14.5, cupHeight - 19.5]){
                        cube([3, 29, 5]);
                    }
                    translate([0, 0, cupHeight - 17]){
                        cylinder(5, 9.5, 9.5, true);
                    }
                }
            }
            translate([0, 0, 18.5]){
                hull(){
                    translate([13, -13.75, cupHeight- 20.5]){
                        cube([2, 27.5, 4]);
                    }
                    translate([63, -13.75, cupHeight - 20.5]){
                        cube([3, 27.5, 4]);
                    }
                    translate([0, 0, cupHeight - 18.5]){
                        cylinder(4, 8.5, 8.5, true);
                    }
                }
            }
            translate([8, -3.01, cupHeight - 0]){
                //cube([6.1, 6.1, 4.2]);
                translate([3.05, 3.05, 0.6]){
                    cylinder(4, 5, 5, true);
                }
            }
        }
        translate([0, 0, cupHeight - 1]){
            translate([65.9, 0, 0]){
                rotate([0, 0, 90]){
                    clip(properties, true);
                }
            }
            translate([2.7, -10, 0]){
                rotate([0, 0, -20]){
                    clip(properties, true);
                }
            }
            translate([2.7, 10, 0]){
                rotate([0, 0, 200]){
                    clip(properties, true);
                }
            }
        }
    }
};

