module glass(type) {
    if(type == 1){
        glass_1();
    }else{
        glass_2();
    }
}

module glass_1(){
    color([1.0, 1.0, 1.0, 0.7]){
        difference(){
            cylinder(135, 27, 32.5, true);
            translate([0, 0, 8]){
                cylinder(140, 25, 29.4, true);
            }
        }
    }
}

module glass_2(){
    color([1.0, 1.0, 1.0, 0.7]){
        difference(){
            cylinder(140, 32.75, 32.75, true);
            translate([0, 0, 8]){
                cylinder(140, 31.75, 31.75, true);
            }
        }
    }
}

glass(1);