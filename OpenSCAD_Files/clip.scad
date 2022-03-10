//Width
//Thickness
//Length
properties = [4, 1, 7.5];

//clip(properties, false);
module clip(properties, positive){
    scalingFactor = 1.1;
    dimensions = [properties[0], properties[1], properties[2]];
    dimensionsNegative = dimensions * scalingFactor;
    if(positive){
        translate(-dimensions / 2){
            cube(dimensions);
            hull(){
                cube([dimensions.x, dimensions.y, 0.1]);
                translate([dimensions.x * 0.04 / 2, properties[1] * 1.5 * scalingFactor, properties[2] / 4]){
                    cube([dimensions.x * 0.96, dimensions.y, 0.1]);
                }
            }
        }
    }else{
        translate(-dimensionsNegative / 2){
            hull(){
                translate([0, 0, dimensionsNegative.z - 0.1]){
                    cube([dimensionsNegative.x, dimensionsNegative.y / 2, 0.1]);    
                }
                cube([dimensionsNegative.x, dimensionsNegative.y, 0.1]);
            }
            //cube(dimensionsNegative);
            hull(){
                cube([dimensionsNegative.x, dimensionsNegative.y, 0.1]);
                translate([0, properties[1] * 1.5 * scalingFactor, properties[2] / 4]){
                    cube([dimensionsNegative.x, dimensionsNegative.y, 0.1]);
                }
            }
        }
    }
}

clip(properties, true);
translate([10, 0, 0]){
    clip(properties, false);
}