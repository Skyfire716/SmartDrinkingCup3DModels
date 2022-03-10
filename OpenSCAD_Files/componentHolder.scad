use <lipo.scad>
use <arduinoNanoRP2040Connect.scad>
use <reelyServo.scad>
use <coil.scad>

module componentHolder(){
    translate([5, 0, 0]){
        difference(){
            union(){
                translate([-10, 30, -15]){
                    cube([10, 3, 11.5]);
                    translate([18, -19, 0]){
                        cube([7, 3, 11.5]);
                    }
                }
                translate([-10, 7, -27.5]){
                    cube([25, 38, 13]);
                }
                translate([-10, -7, -25]){
                    cube([25, 15, 5]);
                }
                translate([-17, 7, -26]){
                    rotate([0, -40, 0]){
                        cube([1, 37, 4]);
                    }
                }
                hull(){
                    translate([-17, 7, -26]){
                        rotate([0, -40, 0]){
                            cube([1, 3, 4]);
                        }
                    }
                    translate([-10, 7, -27.5]){
                        cube([3, 3, 3]);
                    }
                }
                hull(){
                    translate([-17, 42, -26]){
                        rotate([0, -40, 0]){
                            cube([1, 3, 4]);
                        }
                    }
                    translate([-10, 42, -27.5]){
                        cube([3, 3, 3]);
                    }
                }
                translate([-22, 44, -27.5]){
                    cube([37, 4.5, 10]);
                }
            }

            union(){
                translate([0, 0, -4.5]){
                    translate([-17, 8, -20]){
                        lipo();
                    }
                    /*
                    translate([7, 21, -12]){
                        rotate([0, 0, 90]){
                            //MT3608();
                            cube([18, 38, 2]);
                        }
                    }
                    */
                    translate([25, 13, -10]){
                        rotate([0, 0, 90]){
                            cube([18, 38, 2]);
                        }
                    }
                    translate([-14, 12.6, -1]){
                        ArduinoNanoRP2040Connect();
                    }
                    
                }
                translate([-9.45, -6, -25.1]){
                    scale([1.02, 1.02, 1.02]){
                        reelyServo(false);
                    }
                }
                translate([-18, 11, -26.5]){
                    scale([1.05, 1.05, 1.08]){
                        coil();
                    }
                }
                /*
                translate([-21, 9.5, -26.5]){
                    scale([1.05, 1.05, 1.05]){
                        union(){
                            coilCard();
                            translate([-2, 6, -1]){
                                cube([3, 20, 22]);
                            }
                        }
                    }
                }
                */
                //LevelChanger
                translate([-21, 45, -26.5]){
                    cube([16, 2.3, 21]);
                    translate([3, 2, 2]){
                        cube([10, 5, 15]);
                    }
                }  
                //Charger
                translate([-4, 45, -26.5]){
                    cube([18, 2, 22]);
                    translate([3, 1, 2]){
                        cube([12, 4, 15]);
                    }
                }
            }
        }       
    }
}

componentHolder();