use <clip.scad>
use <glasses.scad>
use <componentHolder.scad>
use <ultrasonicLiftArm.scad>
use <reelyServo.scad>

translate([0, 5, 92]){
    //glass(2);
}

translate([-7.5, -32, 10]){
    //componentHolder();
}

translate([-7, -32, 7]){
    translate([-4.15, -6, -24.5]){
        //reelyServo(false);
    }
    //ultrasonicLiftArm();
}

$fn = 150;

//0 radius
//1 height
//2 wallThickness
//3 coverHeight
//4 skirtSettings [0 skirtHeight, 1 skirtThickness]
//5 numberOfClips
//6 clipSettings [0 Width, 1 Tickness, 2 Height]
//7 GripSlots
settings = [45, 35, 3.3, 0.6, [6, 2], 5, [5, 1.5, 10]];


glass_socket(settings);


difference(){
    union(){
        glass_socket_cover(settings);
        translate([-7, -32, 15]){
            cylinder(settings[3] + settings[4][0], 7, 7, true);
        }
    }
    cableShaftRadius = 2.5;
    outerRadius = 3.5;
    coverRadius = 6;
    cupHeight = 160;
    translate([-7, -32, cupHeight / 2 + 10]){
        cylinder(cupHeight, coverRadius * 1.05, coverRadius * 1.05, true);
    }
}



/*
translate([0, 0, 1]){
    //Cheated
    cableShaftRadius = 1.9;
    outerRadius = 3;
    coverRadius = 4;
    cupHeight = 160;
    difference(){
        union(){
            //Cheated
            translate([-7, -32, cupHeight / 2 + 10]){
                difference(){
                    cylinder(cupHeight * 0.9, coverRadius, coverRadius, true);
                    cylinder(cupHeight * 0.91, outerRadius * 1.1, outerRadius * 1.1, true);
                }
            }
            move = 1.3;
            translate([7 * move, 32 * move, cupHeight / 2 + 10]){
                cylinder(cupHeight * 0.9, coverRadius * 0.9, coverRadius * 0.9, true);
            }
            move2 = 1.15;
            translate([32 * move2, -7 * move2, cupHeight / 2 + 10]){
                cylinder(cupHeight * 0.9, coverRadius, coverRadius, true);
            }
            move3 = 1.25;
            translate([-32 * move3, 7 * move3, cupHeight / 2 + 10]){
                cylinder(cupHeight * 0.9, coverRadius, coverRadius, true);
            }
            //Cheated End
            glass_socket_cover(settings);
        }
        translate([-7, -32, cupHeight / 2 + 10]){
            cylinder(cupHeight, outerRadius * 1.1, outerRadius * 1.1, true);
        }
    }
}
  */  

//0 shape
//1 sizes[0 x, 1 y, 2 height]
//2 connector / socket
module gripCoupling(shape){
    if(shape[0] == 0){
        //Cylindrical Coupling
        if(shape[2]){
            difference(){
                cylinder(shape[1][2], shape[1][0], shape[1][1], true);
                cylinder(shape[1][2], shape[1][1], shape[1][1], true);
            }
        }else{
            difference(){
                cylinder(shape[1][2], shape[1][0], shape[1][1], true);
                cylinder(shape[1][2], shape[1][1], shape[1][1], true);
            }
        }
    }else if (shape[0] == 1){
        //TODO Rectangle
    }else{
        echo("Shape not known");
    }
}

//gripCoupling([0, [5, 4, 5], true]);

module glass_socket(settings){
    radius = settings[0];
    height = settings[1];
    wallThickness = settings[2];
    skirtThickness = settings[4][1];
    numberOfClips = settings[5];
    clipProperties = settings[6];
    
    //Bottom
    translate([0, 0, -height / 2]){
        cylinder(0.5, radius, radius, true);
    }
    //Walls
    difference(){
        difference(){
            cylinder(height, radius, radius, true);
            cylinder(height * 1.01, radius - wallThickness, radius - wallThickness, true);
        }
        
        union(){
            //Add Clips to Skirt
            for(i = [1: 1: numberOfClips]){
                angle = i * (360.0 / numberOfClips);
                echo("Place Clip at ", angle);
                rotate([0, 0, angle]){
                    translate([radius, 0, (height - clipProperties.z) / 2 -1]){
                        rotate([0, 0, 90]){
                            clip(clipProperties, false);
                        }
                    }
                }
            }
        }
    }
    
}

//0 radius
//1 height
//2 wallThickness
//3 coverHeight
//4 skirtSettings [0 skirtHeight, 1 skirtThickness]
//5 numberOfClips
//6 clipSettings [0 Width, 1 Tickness, 2 Height]

module glass_socket_cover(settings){
    radius = settings[0];
    height = settings[1];
    coverHeight = settings[3];
    skirtHeight = settings[4][0];
    skirtThickness = settings[4][1];
    numberOfClips = settings[5];
    clipProperties = settings[6];
    //Top Cover with drainage Angle
    translate([0, 0, (height + coverHeight) / 2]){
        cylinder(coverHeight, radius + skirtThickness, radius /* * 0.5 */, true);
    }
    //Skirt
    translate([0, 0, (height - skirtHeight) / 2]){
        difference(){
            cylinder(skirtHeight, radius + skirtThickness, radius + skirtThickness, true);
            cylinder(skirtHeight * 1.1, radius * 1.02, radius * 1.02, true);
        }
        
        //Add Clips to Skirt
        for(i = [1: 1: numberOfClips]){
            angle = i * (360.0 / numberOfClips);
            echo("Place Clip at ", angle);
            rotate([0, 0, angle]){
                translate([radius + skirtThickness / 2, 0, -clipProperties.z / 2]){
                    rotate([0, 0, 90]){
                        clip(clipProperties, true);
                    }
                }
            }
        }
    }
}

