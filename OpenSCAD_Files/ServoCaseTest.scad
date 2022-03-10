use <reelyServo.scad>

scaling = 1.02;

difference(){
    translate([-3.3, -4, 5]){
        cube([30, 20, 4]);
    }
    scale([scaling, scaling, scaling]){
        reelyServo(false);
    }
}

