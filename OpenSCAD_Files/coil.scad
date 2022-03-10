
module coil(core){
    if(core){
        difference(){
            cube([40.9, 29.4, 0.4]);
            translate([6.97, 9.7, -0.05]){
                cube([27, 10, 0.5]);
            }
        }
    }else{
        cube([40.9, 29.4, 0.4]);
    }
}


module coilCard(){
    cube([1, 32.5, 18]);
}

coil();

coilCard();