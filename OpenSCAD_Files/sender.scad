module sender(){
    coilRadius = 25;
    coilHeight = 2.4;
    chipLength = 31;
    chipDepth = 33;
    chipHeight = 3.5;
    chip_coil_spacing = 10;
    chipDimensions = [chipLength, chipDepth, chipHeight];
    cylinder(coilHeight, coilRadius, coilRadius, true);
    translate([-5, -16.5, -5]){
        cube(chipDimensions);
    }
}

sender();