
//$fn=50;
//minkowski();
module ultrasonic_carrier(){
    difference(){
        difference(){
            //Ultrasonic Carrier
            cube([50, 25.5, 17.5]);
            translate([0, 0, 4.1]){
                //ultrasonic sensor
                union(){
                    translate([12.5, 12.5, 0]){
                        cylinder(15, 8.5, 8.5, true);
                        //24.5
                        translate([26.5, 0, 0]){
                            cylinder(15, 8.5, 8.5, true);
                        }
                    }

                    translate([2, 2, 6.5]){
                        cube([46.5, 21.5, 7]);
                    }
                }
            }
        }
        //Rim for better insertion
        translate([1.5, 12.75, 17]){
            rotate([90, 180, 0]){
                difference(){
                    difference(){
                        cylinder(21.5, 2, 2, true);
                        cylinder(22, 0.5, 0.5, true);
                    }
                    union(){
                        translate([-10, 0, -12.5]){
                            cube([20, 5, 25]);
                        }
                        translate([0, -10, -12.5]){
                            cube([5, 20, 25]);
                        }
                    }
                }
            }
        }
    }
}

$fn=50;

//intersection(){
ultrasonic_carrier();
/*
    translate([0, 0, 9.5]){
        cube([50, 25.5, 3]);
    }
}
*/