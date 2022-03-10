use <OpenSCAD_ServoArms/servo_arm.scad>

//Download the ServiArm Lib from link below
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
    [3.85, 3.2, 1.22, 1.34],
    [20, 0.3, 0.7, 0.11]
];


module reelyServo(cableClearance){
    color([0.0, 0.0, 0.0, 1.0]){
        //=====BEGIN MainBlock=====
        cube([23.4, 12, 21.8]);
        
        difference(){
            translate([-4.35, 0, 18.1]){
                cube([32.1, 12, 3.7]);
            }
            //=====BEGIN Screw Holes=====
            union() {
                translate([-2.35, 6, 19.95]){
                    cylinder(10, 1.6, 1.6, true);
                    translate([28.1, 0, 0]){
                        cylinder(10, 1.6, 1.6, true);
                    }
                }            
            }
            //=====END Screw Holes=====
        }
        //=====END MainBlock=====
        
        
        
        //=====BEGIN GearBoxTop=====
        hull(){
            difference(){
                translate([4.15, 6, 21.8]){
                    cylinder(3.48, 6, 6, true);
                }
                translate([-5, 0, 0]){
                    cube([5, 12, 30]);
                }
            }
            translate([14, 6, 21.8]){
                cylinder(3.48, 2, 2, true);
            }
        }
        //=====END GearBoxTop=====
        
        translate([4.15, 6, 28.5]){
            rotate([180, 0, 0]){
                servo_head(FUTABA_3F_SPLINE);
            }
        }
        //=====BEGIN Drive Shaft=====
        translate([4.15, 6, 14.35]){
            cylinder(28.7, 1.915, 1.915, true);
        }
        //=====END Drive Shaft=====
    }
    if(cableClearance){
        //=====BEGIN Cable Clearence Cube=====
        color([1.0, 0.6470588235294118, 0.0, 1.0]){
            translate([-2, 4, -2]){
                rotate([0, 6, 0]){
                    cube([4, 4, 20]);
                }
            }
        }
        //=====END Cable Clearence Cube=====
    }
}


reelyServo();