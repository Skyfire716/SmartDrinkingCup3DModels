use <receiver.scad>

//receiver();

module receiverCase(bottomDiameter){
    botrad = bottomDiameter / 2;
    receiverDiameter = 70;
    receiverRad = receiverDiameter / 2;
    union(){
        translate([0, 0, 11]){
            difference(){
                cylinder(4, receiverRad + 1, botrad, true);
                cylinder(5, receiverRad - 1, botrad - 6, true);
            }
        }        
        difference(){
            translate([0, 0, 14]){
                for(i=[0:1:3]){
                    rotate([0, 0, i * 90]){
                        lasche();
                    }
                }
            }
            translate([0, 0, 9]){
                cylinder(7, bottomDiameter, bottomDiameter, true);
            }
        }
        difference(){
            cylinder(18, receiverRad + 1, receiverRad + 1, true);
            cylinder(20, receiverRad, receiverRad, true);
        }
        translate([0, 0, -9]){
            difference(){
                cylinder(0.5, receiverRad + 1, receiverRad + 1, true);
                translate([0, 0, 1.20]){
                    cylinder(3, 7, 5, true);
                }
            }
        }
        translate([0, 0, -7.75]){
            color([1.0, 0.0, 0.0]){
                difference(){
                    cylinder(3, 7, 5, true);
                    translate([0, 0, -0.5]){
                        cylinder(3, 6, 4, true);
                    }
                }
            }
        }
    }

    
    module lasche(){
        rotate([0, -180, 0]){
            rotate_extrude(angle = 10, convexity = 20, $fn=200){
                projection(cut = true){
                    rotate([90, 0, 0]){
                        difference(){
                            translate([0, 0, -3]){
                                difference(){
                                    cylinder(9, botrad + 3, botrad - 4, true);
                                    cylinder(10, botrad + 1, botrad - 7, true);
                                }
                            }
                            difference(){
                                translate([-bottomDiameter * 1.2 / 2, -bottomDiameter * 1.2 / 2, -8]){
                                    cube([bottomDiameter * 1.2, bottomDiameter * 1.2, 12]);
                                }
                                translate([0, -0.5, -10]){
                                    cube([bottomDiameter * 1.1, 1, 20]);
                                }
                            }   
                        }
                    }
                }
            }
        }
    }
}

$fn=50;
minkowski(){
    receiverCase(67 + 5);

/*
    intersection(){
        receiverCase(67 + 5);
        translate([0, 0, 14]){
            cylinder(5, 120, 120, true);
        }
    }
    */
}


/*
union(){
    translate([-5, -5, -3]){
        translate([0, 0, 1.5]){
            cube([75, 45, 0.5]);
        }
        difference(){
            translate([0, 0, 2]){
                difference(){
                    cube([75, 45, 15]);
                    translate([2, 2, -1]){
                        cube([71, 41, 17]);
                    }
                }
            }
            translate([1, 1, 13.5]){
                cube([75, 43, 2]);
            }
        }
    }
}
*/
/*
translate([1, 1.5, 13.75]){
    difference(){
        cube([78, 42, 1.5]);
        translate([-1, 2, -0.5]){
            cube([9, 8, 3]);
        }
    }
}
*/