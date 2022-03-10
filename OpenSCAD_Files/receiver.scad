module receiver(){
    //CoilDimensions
    coilLength = 41;
    coilDepth = 29;
    coilHeight = 0.3;
    coilDimensions = [coilLength, coilDepth, coilHeight];
    //CoilHoleDimensions
    coilHoleLength = 23;
    coilHoleDepth = 10;
    coilHoleHeight = 2 * coilHeight;
    coilHoleDimensions = [coilHoleLength, coilHoleDepth, coilHoleHeight];
    //ChipDimensions
    chipLength = 19;
    chipDepth = 32.5;
    chipHeight = 1.1;
    chipDimensions = [chipLength, chipDepth, chipHeight];
    
    coil_chip_spacing = 3;
    module receiverCoil(coilDimensions, coilHoleDimensions){
        difference(){
            cube(coilDimensions);
            trans = [(coilDimensions.x - coilHoleDimensions.x) / 2,
            (coilDimensions.y - coilHoleDimensions.y) / 2,
            -(coilHoleDimensions.z - coilDimensions.z) / 2];
            translate(trans){
                color([1.0, 0.0, 0.0, 1.0]){
                    cube(coilHoleDimensions);
                }
            }
        }
    }
    center = [chipLength + coil_chip_spacing,
    0, 0];
    translate(center){
        receiverCoil(coilDimensions, coilHoleDimensions);
        trans = [-coil_chip_spacing - chipLength,
        -(chipDepth - coilDepth) / 2,
        -(chipHeight - coilHeight) / 2];
        translate(trans){
            cube(chipDimensions);
        }
    }
}

receiver();