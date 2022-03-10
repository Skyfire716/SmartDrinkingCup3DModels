use <threads.scad>

module adjustableCarrier(minDiameter, maxDiameter, arms){
    maxRadius = maxDiameter / 2;
    minRadius = minDiameter / 2;
    coverWallThickness = 1;
    coverHeight = 5;
    
    cylinder(2, maxRadius, maxRadius, true);
    color([1.0, 0.0, 0.0, 1.0]){
        cylinder(4, minRadius, minRadius, true);
    }
    
    //cover();
    
    module cover(){
        translate([0, 0, -coverHeight / 2]){
            //=====BEGIN Cover=====
            difference(){
                cylinder(coverHeight, maxRadius, maxRadius, true);
                cylinder(coverHeight * 1.1, maxRadius - coverWallThickness, maxRadius - coverWallThickness, true);
            }
            //=====END Cover=====
        }
    }
}

//adjustableCarrier(55, 80, 3);

$fn = 500;

clearance = 0.6;
selfSecureScrewClearance = clearance + 0.1;
minDiameter = 50;
maxDiameter = 85;
cupHeight = 140;
armRadius = 5.5;
cableShaftRadius = 2.5;
wormGearPitch = 2.0;
progress = 1.0;


module rail(railRange, railWidth, gearLength, railHeight){
    translate([-railWidth / 2, 0, -railHeight / 2]){
        cube([railWidth, railRange + gearLength, railHeight]);
    } 
    
}

module railGear(railRange, progress, railWidth, gearLength){
    gearWidth = railWidth - clearance;
    color([1.0, 0.0, 0.0, 1.0]){
        translate([0, railRange * progress + gearLength / 2, 0]){
            
            translate([-gearWidth / 2, -gearLength / 2, 0]){
                cube([gearWidth, gearLength, 2]);
            }
            
            translate([0, 0, 4.5]){
                cylinder(9, gearWidth / 2, gearWidth / 2, true);
            }
        }
    }
}


/*
 * translate([0, 0, -1]){
 *    color([0.0, 1.0, 0.0, 1.0]){
 *        cylinder(2, minDiameter / 2, minDiameter / 2, true);
 *    }
 *    color([0.0, 1.0, 1.0, 1.0]){
 *        cylinder(1, maxDiameter / 2, maxDiameter / 2, true);
 *    }
 * }
 */


module clearPath(){
    radius = armRadius + clearance;
    translate([0, radius, 0]){
        color([1.0, 0.0, 0.0, 0.3]){
            hull(){
                translate([0, maxDiameter / 2, 10]){
                    cylinder(20, radius, radius, true);
                }
                translate([0, minDiameter / 2, 10]){
                    cylinder(20, radius, radius, true);
                }
            }
        }
    }
}

*%clearPath();

/*
 * clearPath();
 * mirror([0, 1, 0]){
 *    clearPath();
 * }
 * rotate([0, 0, 90]){
 *    clearPath();
 *    mirror([0, 1, 0]){
 *        clearPath();
 *    }
 * }
 */

//G     A       G       A
//H     H       A       G
//sin   cos     tan     cotan

module testPins(progress, adjacent, railWidth, gearLength){
    gearWidth = railWidth - clearance;
    radius = gearWidth / 2 + clearance;
    translate([1.1, -0.5, 0]){
        color([1.0, 0.0, 0.0, 1.0]){
            hull(){
                translate([0, adjacent + gearLength / 2, 0]){
                    translate([0, 0, 2.5]){
                        cylinder(10, radius, radius, true);
                    }
                }
                translate([0, 0 + gearLength / 2, 0]){
                    translate([0, 0, 2.5]){
                        cylinder(10, radius, radius, true);
                    }
                }
            }
        }
    }
}

module arm(adjacent, gearLength, offset, railWidth){
    translate([0, adjacent * progress + gearLength / 2 - 0.5 + offset - railWidth * 1.25, 0]){
        cube([maxDiameter / 2.9, railWidth * 2.5, 2]);
    }
}

module shiftArea(offset, adjacent, railWidth, gearLength){
    translate([offset + adjacent * progress, offset, 0]){
        testPins(progress, adjacent, railWidth, gearLength);
    }
}


module test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, railHeight){
    render(convexity=2){
        translate([offset, offset, 0]){
            rotate([0, 0, -45]){
                rail(railRange, railWidth, gearLength, railHeight);
                railGear(railRange, progress, railWidth, gearLength);
            }
        }
        
        generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset);
        rotate([0, 0, 90]){
            translate([0, 0, 2 + clearance]){
                generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, false);
            }
        }    
    }
}

module generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, justBar){
    module subArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset){
        difference(){
            arm(adjacent, gearLength, offset, railWidth);
            rotate([0, 0, -90]){
                mirror([1, 0, 0]){
                    shiftArea(offset, adjacent, railWidth, gearLength);
                }
            }
        }
    }
    render(convexity = 2){
        translate([0, adjacent * progress + gearLength / 2 - 0.5 + offset - railWidth, 0]){
            difference(){
                union(){
                    union(){
                        translate([0, -(adjacent * progress + gearLength / 2 - 0.5 + offset - railWidth), 0]){
                            subArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset);
                            mirror([1, 0, 0]){
                                subArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset);
                            }
                        }
                    }
                    if(!justBar){
                        hull(){
                            translate([-armRadius, -5, 0]){
                                cube([armRadius * 2, 20, 2]);
                            }
                            translate([0, 22, 1]){
                                cylinder(2, armRadius, armRadius, true);
                                
                            }
                        }
                        translate([0, 22, 1]){
                            diameter = armRadius * 2;
                            metric_thread (diameter=diameter - clearance, pitch=2, length=10);
                        }   
                    }
                }
                if(!justBar){
                    translate([0, 22, 5.5]){
                        cylinder(20, 3, 3, true);
                    }
                }
                translate([-3, -8, -0.5]){
                    color([1.0, 0.0, 0.0, 1.0]){
                        rotate([0, 0, 0]){
                            cube([6, 30, 2]);
                        }
                    }
                }
            }
        }
    }
}

railWidth = 2;
gearLength = 3;
movableDistance = maxDiameter - minDiameter;
adjacent = movableDistance / 2;
railRange = adjacent / cos(45);
offset = (minDiameter - railRange) / 3;

*generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, false);
*gripArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset);

module gripArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset){
    grippers = ["wave.dat", "triangle.dat", "dots.dat"];
    gripper = -1;
    render(convexity = 2){
        translate([0, adjacent * progress + gearLength / 2 - 0.5 + offset - railWidth, 0]){
            translate([0, 22, 1]){
                difference(){
                    translate([0, 0, 5]){
                        cylinder(9, armRadius + 1.4, armRadius + 1.4, true);
                    }
                    diameter = armRadius * 2;
                    metric_thread (diameter=diameter + clearance, pitch=2, length=10, internal = true);
                }   
                if(gripper >= 0){
                translate([0, -1.5, 70]){
                rotate([0, 180, 0]){
                rotate([-90, 0,0]){
                   surface(grippers[gripper], center = true, convexity = 5);
                }
                }
                }
                }
                difference(){
                hull(){
                    translate([0, 0, 10]){
                        difference(){
                            cylinder(2, armRadius + 1.4, armRadius + 1.4, true);
                            cylinder(3, armRadius + 1, armRadius + 1, true);
                        }
                    }
                    translate([0, 0, cupHeight / 2]){
                        *cylinder(cupHeight, 3, 3, true);
                    }
                    translate([-4, -7, 15]){
                        cube([8, 5, 1]);
                    }
                }
                hull(){
                translate([-2.5, -6, 10]){
                cube([5, 3, 10]);
                }
                translate([-2.5, -4, 5]){
                cube([5, 3, 1]);
                }
                }
                }
                difference(){
                    
                    hull(){
                        translate([-4, -7, cupHeight]){
                            cube([8, 5, 1]);
                        }
                        translate([-4, -7, 15]){
                            cube([8, 5, 1]);
                        }
                    }
                    
                    hull(){
                        translate([-2.5, -6, cupHeight - 1]){
                            cube([5, 3, 1]);
                        }
                        translate([-2.5, -6, 14]){
                            cube([5, 3, 1]);
                        }
                    }
                    
                    
                }
            }
        }
    }
}


module rotarySnail(invert, Threadclearance){
    module snailThread(invert, Threadclearance){
        mirror([invert, 0, 0]){
            if(Threadclearance == 0){
                diameter = 6 - Threadclearance;
                metric_thread (diameter = diameter, pitch = wormGearPitch, length = railRange * 1.3, square = false, internal = true);
            }else{
                diameter = 6 - Threadclearance;
                metric_thread (diameter=diameter, pitch=wormGearPitch, length=railRange * 1.3, square=false);
                
            }
        }
    }
    
    rotate([0, 0, -45]){
        rotate([90, 0, 0]){
            translate([0, 0, 10]){
                snailThread(invert, Threadclearance);
            }
        }
    }
}


//Worm Gear
*union(){
    translate([0, 0, -7]){
        rotarySnail(0, clearance);
        mirror([0, 1, 0]){
            mirror([1, 0, 0]){
                rotarySnail(1, clearance);
            }
        }
    }
    translate([0, 0, -7]){
        rotate([90, 0, 135]){
            cylinder(20, 2.5, 2.5, true);
        }
    }
    translate([0, 0, -7]){
        rotate([0, 0, 45]){
            translate([-6.5, -2.5, -2.5]){
                cube([11.5, 5, 5]);
            }
            translate([-9, -2, -2]){
                cube([3.5, 4, 4]);
            }
            
            rotate([30, 0, 0]){
                translate([-6.5, -2.5, -2.5]){
                    cube([11.5, 5, 5]);
                }
                translate([-9, -2, -2]){
                    cube([3.5, 4, 4]);
                }
                
            }
            rotate([60, 0, 0]){
                translate([-6.5, -2.5, -2.5]){
                    cube([11.5, 5, 5]);
                }
                translate([-9, -2, -2]){
                    cube([3.5, 4, 4]);
                }
                
            }
        }
    }
}


//BottomPlate
*union(){
    //WormGearCarry
    difference(){
        union(){
            translate([0, 0, -11.5]){
                rotate([0, 0, 45]){
                    translate([-9.9, -5, 0]){
                        cube([4, 10, 9]);
                    }
                    translate([5.9, -5, 0]){
                        cube([4, 10, 9]);
                    }
                }
            }
        }
        
        
        translate([0, 0, -7]){
            rotate([90, 0, 135]){
                cylinder(20, 3.5 + clearance / 2, 3 + clearance / 2, true);
            }
        }    
    }
    //BottomPlatePart
    difference(){
        translate([0, 0, -1.4]){
            cylinder(4, maxDiameter / 2, maxDiameter / 2, true);
        }
        union(){
            translate([0, 0, -6]){
                stageScrews(true);
                rotate([0, 0, 90]){
                    stageScrews(true);
                }
            }
            translate([0, 0, 0]){
                cylinder(10, 7, 7, true);
            }
            translate([0, 0, 0]){
                difference(){
                    cylinder(2, 9, 9, true);
                    cylinder(3, 8, 8, true);
                }
            }
            
            translate([0, 0, 2]){
                test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 20);
                
                mirror([1, 0, 0]){
                    test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 8);
                }
                
                mirror([1, 0, 0]){
                    mirror([0, -1, 0]){
                        test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 20);
                    }
                }
                
                mirror([0, -1, 0]){
                    test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 8);
                }
            }
            
        }
    }
}




module bla(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset){
    translate([offset, offset, -7.5]){
        rotate([0, 0, -45]){
            translate([0, railRange * progress + gearLength / 2, 0]){
                translate([-4, -2.5, -4]){
                    cube([8, 5, 8]);
                }
                gearWidth = railWidth - clearance;
                
                translate([-gearWidth / 2, -gearLength / 2, 0]){
                    cube([gearWidth, gearLength, 9]);
                }
                
            }
        }
    }
}


//WormGearNuts


*union(){
    translate([offset, offset, 0]){
        rotate([0, 0, -45]){
            railGear(railRange, progress, railWidth, gearLength);
        }
    }
    difference(){
        bla(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset);
        translate([0, 0, -7]){
            mirror([1, 1, 0]){
                rotarySnail(0, 0);
            }
        }
    }
}

*mirror([1, 0, 0]){
    
    
    translate([offset, offset, 0]){
        rotate([0, 0, -45]){
            railGear(railRange, progress, railWidth, gearLength);
        }
    }
}

*mirror([0, 1, 0]){
    
    translate([offset, offset, 0]){
        rotate([0, 0, -45]){
            railGear(railRange, progress, railWidth, gearLength);
        }
    }
    
    
}

*difference(){
    mirror([1, 1, 0]){
        
        translate([offset, offset, 0]){
            rotate([0, 0, -45]){
                railGear(railRange, progress, railWidth, gearLength);
            }
        }
        
        
        bla(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset);    
    }
    translate([0, 0, -7]){
        rotarySnail(0, 0);
    }
}




module stageScrews(nut){
    module stageScrewSub(pos, neg){
        dist = railRange + gearLength * 1.5 + offset;
        x = pos ? dist : -dist;
        translate([x, 0, 0]){
            if(neg){
                //difference () {
                //cylinder (r=4, h=9.9, $fn=100);
                metric_thread (diameter=6, pitch=2, length=10, internal=true, n_starts=1);
                //}
            }else{
                metric_thread (diameter=6 - selfSecureScrewClearance, pitch=2, length=8);
            }
        }
    }
    render(convexity = 2){
        rotate([0, 0, 20]){    
            stageScrewSub(true, nut);
            stageScrewSub(false, nut);
        }
        rotate([0, 0, -20]){    
            stageScrewSub(true, nut);
            stageScrewSub(false, nut);
        }
        
    }
}


module stageScrewsPrint(){
    for(i=[1:1:4]){
        translate([10 * i, 0, 0]){
            metric_thread(diameter = 6 - selfSecureScrewClearance, pitch = 2, length = 8);
            difference(){
                translate([-3, -3, -3]){
                    cube([6, 6, 3]);
                }            
                translate([-2, -1, -3.1]){
                    cube([4, 2, 2]);
                }
            }
        }
    }
}

metric_thread(diameter = 6 - selfSecureScrewClearance, pitch = 2, length = 8);
difference(){
    translate([-3, -3, -3]){
        cube([6, 6, 3]);
    }
    translate([-2, -1, -3.1]){
        cube([4, 2, 2]);
    }
}
*stageScrewsPrint();



* translate([0, 0, -4]){
    stageScrews(false);
    rotate([0, 0, 90]){
        stageScrews(false);
    }
}


module innerClearArea(){
    
    render(convexity = 2){
        color([0.0, 0.0, 1.0, 0.3]){
            union(){
                translate([0, 0, 2]){
                    cylinder(6, (railRange + minDiameter) / 2, (railRange + minDiameter) / 2, true);
                }
                radius = armRadius + clearance;
                translate([0, -6, 5]){
                    scale([1.15, 1.15, 1.15]){
                        clearPath();
                    }
                }
                rotate([0, 0, 90]){
                    translate([0, -6, 5]){
                        scale([1.15, 1.15, 1.15]){
                            clearPath();
                        }
                    }
                }
                rotate([0, 0, -90]){
                    translate([0, -6, 5]){
                        scale([1.15, 1.15, 1.15]){
                            clearPath();
                        }
                    }
                }
                rotate([0, 0, 180]){
                    translate([0, -6, 5]){
                        scale([1.15, 1.15, 1.15]){
                            clearPath();
                        }
                    }
                }
                translate([0, 0, -6]){
                    stageScrews(true);
                    rotate([0, 0, 90]){
                        stageScrews(true);
                    }
                }
            }
        }
    }
    
}


*union(){
    union(){
        render(convexity = 2){
            difference(){
                translate([0, 0, 4]){
                    radius = maxDiameter / 2 + 3;
                    cylinder(6.5, radius, radius, true);
                    
                }
                //InnerClearArea
                color([0.0, 0.0, 1.0, 0.3]){
                    translate([0, 0, 2]){
                        radius = (railRange + minDiameter) / 2 - 3;
                        cylinder(6, radius, radius, true);
                    }
                    translate([0, 0, 0.5]){    
                        scale([1.01, 1.01, 2.5]){
                            hull(){
                                generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, true);
                                mirror([0, 1, 0]){
                                    generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, true);
                                }
                            }
                        }
                    }
                    
                    radius = armRadius + clearance;
                    translate([0, -6, 0.75]){
                        scale([1.15, 1.15, 1.15]){
                            clearPath();
                        }
                    }
                    rotate([0, 0, 90]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    rotate([0, 0, -90]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    rotate([0, 0, 180]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    
                    translate([0, 0, -6.03]){
                        stageScrews(true);
                        rotate([0, 0, 90]){
                            stageScrews(true);
                        }
                    }
                    
                    
                    
                    translate([0, 0, 5]){
                        rails(railRange, railWidth, progress, 4, gearLength);
                        
                        mirror([1, 0, 0]){
                            rails(railRange, railWidth, progress, 4, gearLength);
                            
                        }
                        
                        mirror([1, 0, 0]){
                            mirror([0, -1, 0]){
                                rails(railRange, railWidth, progress, 4, gearLength);
                            }
                        }
                        
                        mirror([0, -1, 0]){
                            rails(railRange, railWidth, progress, 4, gearLength);
                        }
                    }                    
                }
            }
            //InnerClearAreaEnd
        }
        
    }
    
    
    //TopPlate2
    //TopPlate
    union(){
        render(convexity = 2){
            difference(){
                union(){
                    translate([0, 0, 4]){
                        radius = maxDiameter / 2 + 3;
                        cylinder(6.5, radius, radius, true);
                        
                    }
                    translate([0, 0, -5.3]){
                        difference(){
                            radius = maxDiameter / 2 + 3;
                            echo("Check Radius, Leafe space to bottomPart");
                            cylinder(25, radius, radius, true);
                            
                        }
                    }
                }
                //InnerClearArea
                color([0.0, 0.0, 1.0, 0.3]){
                    translate([0, 0, -5.3]){
                        union(){
                            union(){
                                radius = maxDiameter / 2 + 3;
                                translate([0, 0, -12]){
                                    metric_thread (diameter=radius * 2 - 3 - clearance, pitch=2, length=5);    
                                }
                                cylinder(30, radius - 2.5, radius - 2.5, true);    
                            }
                        }
                    }
                    translate([0, 0, 2]){
                        radius = (railRange + minDiameter) / 2 - 3;
                        cylinder(6, radius, radius, true);
                    }
                    translate([0, 0, 0.5]){    
                        scale([1.01, 1.01, 2.5]){
                            hull(){
                                generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, true);
                                mirror([0, 1, 0]){
                                    generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, true);
                                }
                            }
                        }
                    }
                    
                    radius = armRadius + clearance;
                    translate([0, -6, 0.75]){
                        scale([1.15, 1.15, 1.15]){
                            clearPath();
                        }
                    }
                    rotate([0, 0, 90]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    rotate([0, 0, -90]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    rotate([0, 0, 180]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    
                    translate([0, 0, -6.03]){
                        stageScrews(true);
                        rotate([0, 0, 90]){
                            stageScrews(true);
                        }
                    }
                    
                    
                    
                    translate([0, 0, 5]){
                        rails(railRange, railWidth, progress, 4, gearLength);
                        
                        mirror([1, 0, 0]){
                            rails(railRange, railWidth, progress, 4, gearLength);
                            
                        }
                        
                        mirror([1, 0, 0]){
                            mirror([0, -1, 0]){
                                rails(railRange, railWidth, progress, 4, gearLength);
                            }
                        }
                        
                        mirror([0, -1, 0]){
                            rails(railRange, railWidth, progress, 4, gearLength);
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            //InnerClearAreaEnd
        }
        
    }
}    



//TopPlateBackup
*union(){
    render(convexity = 2){
        difference(){
            translate([0, 0, 4]){
                radius = maxDiameter / 2 + 3;
                cylinder(6.5, radius, radius, true);
            }
            //InnerClearArea
            color([0.0, 0.0, 1.0, 0.3]){
                union(){
                    translate([0, 0, 2]){
                        radius = (railRange + minDiameter) / 2 - 3;
                        cylinder(6, radius, radius, true);
                    }
                    translate([0, 0, 0.5]){    
                        scale([1.01, 1.01, 2.5]){
                            hull(){
                                generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, true);
                                mirror([0, 1, 0]){
                                    generateArm(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, true);
                                }
                            }
                        }
                    }
                    
                    radius = armRadius + clearance;
                    translate([0, -6, 0.75]){
                        scale([1.15, 1.15, 1.15]){
                            clearPath();
                        }
                    }
                    rotate([0, 0, 90]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    rotate([0, 0, -90]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    rotate([0, 0, 180]){
                        translate([0, -6, 0.75]){
                            scale([1.15, 1.15, 1.15]){
                                clearPath();
                            }
                        }
                    }
                    
                    translate([0, 0, -6.03]){
                        stageScrews(true);
                        rotate([0, 0, 90]){
                            stageScrews(true);
                        }
                    }
                    
                    
                    
                    translate([0, 0, 5]){
                        rails(railRange, railWidth, progress, 4, gearLength);
                        
                        mirror([1, 0, 0]){
                            rails(railRange, railWidth, progress, 4, gearLength);
                            
                        }
                        
                        mirror([1, 0, 0]){
                            mirror([0, -1, 0]){
                                rails(railRange, railWidth, progress, 4, gearLength);
                            }
                        }
                        
                        mirror([0, -1, 0]){
                            rails(railRange, railWidth, progress, 4, gearLength);
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            //InnerClearAreaEnd
        }
        
    }
    
    union(){
        translate([0, 0, -5.3]){
            difference(){
                radius = maxDiameter / 2 + 3;
                echo("Check Radius, Leafe space to bottomPart");
                cylinder(25, radius, radius, true);
                union(){
                    translate([0, 0, -12]){
                        metric_thread (diameter=radius * 2 - 3 - clearance, pitch=2, length=5);    
                    }
                    cylinder(30, radius - 2.5, radius - 2.5, true);    
                    
                    
                    render(convexity = 2){
                        color([0.0, 0.0, 1.0, 0.3]){
                            union(){
                                translate([0, 0, 2]){
                                    cylinder(6, (railRange + minDiameter) / 2, (railRange + minDiameter) / 2, true);
                                }
                                radius = armRadius + clearance;
                                translate([0, -6, 5]){
                                    scale([1.15, 1.15, 1.15]){
                                        clearPath();
                                    }
                                }
                                rotate([0, 0, 90]){
                                    translate([0, -6, 5]){
                                        scale([1.15, 1.15, 1.15]){
                                            clearPath();
                                        }
                                    }
                                }
                                rotate([0, 0, -90]){
                                    translate([0, -6, 5]){
                                        scale([1.15, 1.15, 1.15]){
                                            clearPath();
                                        }
                                    }
                                }
                                rotate([0, 0, 180]){
                                    translate([0, -6, 5]){
                                        scale([1.15, 1.15, 1.15]){
                                            clearPath();
                                        }
                                    }
                                }
                                translate([0, 0, -6]){
                                    stageScrews(true);
                                    rotate([0, 0, 90]){
                                        stageScrews(true);
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
}


//UntenDing
*translate([0, 0, -5.2]){
    radius = maxDiameter / 2 + 1.5;
    difference(){
        translate([0, 0, -12]){
            metric_thread(diameter = radius * 2 - 1 - clearance, pitch = 2, length = 5);
        }
        
        translate([0, 0, -10]){
            cylinder(10, radius- 3, radius - 3, true);
        }        
    }
    translate([0, 0, -2]){
        difference(){
            translate([0, 0, -20]){
                cylinder(20,radius -1 , radius -1, true);
            }
            translate([0, 0, -14.5]){
                cylinder(30, radius - 3, radius -3, true);
            }
        }
        
    }
}
//Unten Ding Ende


module rails(railRange, railWidth, progress, railHeight, gearLength){
    translate([offset, offset, 0]){
        rotate([0, 0, -45]){
            rail(railRange, railWidth, gearLength, railHeight);
        }
    }
}


*translate([0, 0, 5]){
    rails(railRange, railWidth, progress, 4, gearLength);
    
    mirror([1, 0, 0]){
        rails(railRange, railWidth, progress, 4, gearLength);
        
    }
    
    mirror([1, 0, 0]){
        mirror([0, -1, 0]){
            rails(railRange, railWidth, progress, 4, gearLength);
        }
    }
    
    mirror([0, -1, 0]){
        rails(railRange, railWidth, progress, 4, gearLength);
    }
}




*translate([0, 0, 0.7]){
    color([0.0, 0.0, 0.3, 1.0]){
        render(convexity = 2){
            test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 2);
            
            mirror([1, 0, 0]){
                test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 2);
            }
            translate([0, 0, -0.5]){
                mirror([1, 0, 0]){
                    mirror([0, -1, 0]){
                        test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 2);
                    }
                }
                mirror([0, -1, 0]){
                    test(progress, railWidth, gearLength, movableDistance, adjacent, railRange, offset, 2);
                }
            }
            
            
        }
        
        
    }
}


