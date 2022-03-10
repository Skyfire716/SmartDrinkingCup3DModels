use <OpenSCAD_ServoArms/servo_arm.scad>
use <ultrasonicCarrier.scad>
use <reelyServo.scad>
use <glasses.scad>
use <button.scad>
use <Getriebe.scad>
use <arduinoNanoRP2040Connect.scad>
use <MT3608.scad>
use <UltrasonicArmCarrier.scad>
use <receiverCase.scad>
use <lipo.scad>
use <componentHolder.scad>

/**
 * https://github.com/hugokernel/OpenSCAD_ServoArms/blob/master/servo_arm.scad
 *  Head / Tooth parameters
 *  Futaba 3F Standard Spline
 *  http://www.servocity.com/html/futaba_servo_splines.html
 *
 *  First array (head related) :
 *  0. Head external diameter
 *  1. Head heigth
 *  2. Head thickness
 *  3. Head screw diameter
 *
 *  Second array (tooth related) :
 *  0. Tooth count
 *  1. Tooth height
 *  2. Tooth length
 *  3. Tooth width
 */
//From Git Repo
FUTABA_3F_SPLINE = [
    [3.8, 3.2, 1.33, 1.34],
    [20, 0.3, 0.7, 0.11]
];

$fn=150;

cableShaftRadius = 2.5;
outerRadius = 3.5;
coverRadius = 5.5;
cupHeight = 160;
measuringHeight = cupHeight + 30;

union(){
    difference(){
        union(){
            translate([0, 0, -1]){
                cylinder(7, outerRadius + 1.5, outerRadius + 1.5, true);
            }
            translate([0, 0, -3]){
                hull(){
                    cylinder(3, 3, 3, true);
                    translate([-12.25, 0, 0]){
                        cylinder(3, 3, 3, true);
                    }
                }
            }
        }
        union(){
            cylinder(10, outerRadius + 0.3, outerRadius + 0.3, true);
            translate([0, 0, -3]){
                hull(){
                    translate([2.8, 0, 0]){
                        cylinder(4, 1.75, 1.75, true);
                    }
                    translate([-12.25, 0, 0]){
                        cylinder(2, 1.75, 1.75, true);
                    }
                }
            }
        }
    }
}

*translate([-12.25, 0, -2.5]){
    rotate([180, 0, 0]){
        translate([0, 0, 0.5]){
            hull(){
                cylinder(1, 1.75, 1.75, true);
                translate([12.25, 0, 0]){
                    cylinder(1, 1.75, 1.75, true);
                }
            }
        }
        translate([12.25, 0, 2]){
            cylinder(4, 2, 2, true);
        }
    }
}


/*
intersection(){
translate([-10, -10, 171]){
    cube([20, 20, 15]);
}


*/
*ultrasonicLiftArm();
//}

module ultrasonicLiftArm(){
    union(){
        /*
        translate([0, 0, cupHeight / 2]){
            difference(){
                cylinder(cupHeight * 0.9, coverRadius, coverRadius, true);
                outerRadiusMultiplier = 1.2;
                cylinder(cupHeight * 0.91, outerRadius * outerRadiusMultiplier, outerRadius * outerRadiusMultiplier, true);
            }
        }
        */
        difference(){
            union(){
                difference(){
                    union(){
                        translate([0, 0, measuringHeight / 2 + 0.1]){
                            cylinder(measuringHeight, outerRadius, outerRadius, true);
                        }
                        translate([0, 0, measuringHeight - 18.5]){
                            cylinder(2, 6, 6.5, true);
                        }
                    }
                    union(){
                        translate([0, 0, measuringHeight / 2 + FUTABA_3F_SPLINE[0][0]]){
                            cylinder(measuringHeight + 2, cableShaftRadius, cableShaftRadius, true);
                        }
                        rotate([0, 0, -90]){
                            translate([-1, -3, 8]){
                                rotate([0, 40, 0]){
                                    cube([10, 6, 4]);
                                }
                            }
                        }
                        servo_head(FUTABA_3F_SPLINE);
                    }
                }
                gearScaleNumber = 0.90;
                gearScale = [gearScaleNumber, gearScaleNumber, 1.0];
                translate([0, 0, measuringHeight - 17.5]){
                    scale(gearScale){
                        stirnrad (modul=1, zahnzahl=10, breite=18.65, bohrung=cableShaftRadius * 2, eingriffswinkel=20, schraegungswinkel=0, optimiert=false);
                    }
                }
                translate([0, 0, measuringHeight - 0.8]){
                    scale(gearScale){
                        //stirnrad (modul=1, zahnzahl=10, breite=1, bohrung=cableShaftRadius * 2, eingriffswinkel=20, schraegungswinkel=0, optimiert=false);
                    }
                }
            }
            union() {
                translate([0, 0, measuringHeight]){
                    //cube([10, 3, 3]);
                    translate([2, -3, -17]){
                        rotate([0, -60, 0]){
                            cube([20, 6, 4]);
                        }
                    }
                }
                translate([-15, -15, measuringHeight]){
                    cube([30, 30, 5]);
                }
            }
        }
    }
}

//}

module gears(){
    stirnrad (modul=1, zahnzahl=10, breite=3, bohrung=cableShaftRadius * 2, eingriffswinkel=20, schraegungswinkel=0, optimiert=false);
    //hohlrad (modul=1, zahnzahl=10, breite=17.5, randbreite=1, eingriffswinkel=20, schraegungswinkel=0);18
}


//UltrasonicArmCarrier(measuringHeight);
//UltrasonicArmCarrierCover(measuringHeight);

/*
translate([0, 0, cupHeight - 8.75]){
    translate([0, 0, -8.75]){
    hohlrad (modul=1, zahnzahl=10, breite=17.5, randbreite=1, eingriffswinkel=20, schraegungswinkel=0);
    }
    difference(){
        cylinder(17.5, 7.5, 7.5, true);
        cylinder(18, 6.5, 6.5, true);
    }
}
*/

translate([10, 0, -16]){
    //receiverCase((67 + 5));
}

//componentHolder();

                
translate([-4.15, -6, -24.5]){
    //reelyServo(false);
}

translate([40, 0, 75]){
    //glass(2);
}

