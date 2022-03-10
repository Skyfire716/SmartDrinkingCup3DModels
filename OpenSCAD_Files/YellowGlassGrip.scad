use <receiverCase.scad>

bottom_outer_diameter = 67;
bottom_support_thickness = 5;

module glass_cage(bottom_outer_diameter, bottom_support_thickness){
    top_outer_diameter = 65.4;
    bottom_outer_diameter = 67;
    glass_heigth = 140;

    top_support_thickness = 2;
    top_support_width = 7;
    bottom_support_width = 10;
    
    height_of_lower_supports = 0.3;
    number_of_supports = 4;
    lower_supports_index = [];
    grippers = ["wave.dat", "triangle.dat", "dots.dat"];
    gripper = 0;
    bottom_radius = (bottom_outer_diameter + bottom_support_thickness) / 2;
    botrad = bottom_outer_diameter / 2;
    toprad = top_outer_diameter / 2;

    function angle_v2v(u, v) = acos((u * v) / (len(u) * len(v)));
    function angle_deg(i) = i * (360 / number_of_supports);
    function position(i, top) = top ? [toprad * sin(angle_deg(i)), toprad * cos(angle_deg(i)), (search(i, lower_supports_index) == []) ? glass_heigth : glass_heigth * height_of_lower_supports] : [botrad * sin(angle_deg(i)), botrad * cos(angle_deg(i)), 0];

    module bottom_support_foot(i){
        intersection(){
            bottom_circle();
            translate(position(i, false)){
                translate([for([0:1:2])(-bottom_support_width / 2)]){
                    cube([for([0:1:2])bottom_support_width]);
                }
            }
        }    
    }

    module top_support_foot(i){
        intersection(){
            z_translation = (search(i, lower_supports_index) == []) ? glass_heigth : glass_heigth * height_of_lower_supports;
            top_circle(z_translation);
            translate(position(i, true)){
                translate([for([0:1:2])(-top_support_width / 2)]){
                    cube([for([0:1:2])top_support_width]);
                }
            }
        }
    }

    module top_circle(height){
        top_radius = (top_outer_diameter + top_support_thickness) / 2;
        translate([0, 0, height]){
            difference(){
                cylinder(2, top_radius, top_radius, true);
                cylinder(4, top_outer_diameter / 2, top_outer_diameter / 2, true);
            }
        }
    }

    module bottom_circle(){
        bottom_radius = (bottom_outer_diameter + bottom_support_thickness) / 2;
        difference(){
            cylinder(2, bottom_radius, bottom_radius, true);
                cylinder(4, bottom_outer_diameter / 2, bottom_outer_diameter / 2, true);
        }
    }

    module support(i){
        hull(){
            bottom_support_foot(i);
            top_support_foot(i);
        }
    }

    module gripper(i){
        if(gripper != -1 && search(i, lower_supports_index) == []){
            translate(position(i, false)){
                rotate([0, 0, -angle_deg(i)]){
                    v = [(botrad - toprad) * sin(angle_deg(i)), (botrad - toprad) * cos(angle_deg(i)), -glass_heigth];
                    v2 = v / norm(v);
                    rotate([-angle_v2v([0, 1, 0], v2), 0, 0]){
                        surface(grippers[gripper], center = true, convexity = 5);
                    }
                }
            }
        }
    }

    module lasche(){
        rotate([0, -180, 0]){
            rotate_extrude(angle = 20, convexity = 20, $fn=200){
                projection(cut = true){
                    translate([0, 0, 0]){
                        rotate([90, 0, 0]){
                            difference(){
                                translate([0, 0, -3]){
                                    difference(){
                                        cylinder(9, botrad + 6, botrad - 1.5, true);
                                        cylinder(10, botrad + 2, botrad - 4.5, true);
                                    }
                                }
                                difference(){
                                    translate([-bottom_outer_diameter * 1.2 / 2, -bottom_outer_diameter * 1.2 / 2, -8]){
                                        cube([bottom_outer_diameter * 1.2, bottom_outer_diameter * 1.2, 12]);
                                    }
                                    translate([0, -0.5, -10]){
                                        cube([bottom_outer_diameter * 1.1, 1, 20]);
                                    }
                                }                
                            }
                        }
                    }
                }
            }
        }
    }

    for(i = [0:1:number_of_supports - 1]){
        support(i);
        pos = position(i, false);
        pos_dir = pos / norm(pos);
        if(gripper != -1){
            intersection(){
                hull(){
                    bottom_support_foot(i);
                    translate(pos_dir * 10)bottom_support_foot(i);
                    top_support_foot(i);
                    translate(pos_dir * 10)top_support_foot(i);
                }
                gripper(i);
            }
        }
    }
    
            
    difference(){
        cylinder(2, bottom_radius, bottom_radius, true);
        union(){      
            rotate([0, 0, 56]){
                lasche();
            }
            rotate([0, 0, 146]){
                lasche();
            }
            rotate([0, 0, 30]){
                translate([-33, -3.5, -2]){
                    cube([5, 7, 4]);
                }
                translate([28, -3.5, -2]){
                    cube([5, 7, 4]);
                }
            }
            rotate([0, 0, -60]){
                rotate([0, 0, 26]){
                    lasche();
                }
                rotate([0, 0, -64]){
                    lasche();
                }
                translate([-33, -3.5, -2]){
                    cube([5, 7, 4]);
                }
            }
        }
    }
}

bottom_radius = (bottom_outer_diameter + bottom_support_thickness) / 2;

//TODO tolleranzen beim drehverschluss anpassen!!!
$fn=500;
minkowski(){
    glass_cage(bottom_outer_diameter, bottom_support_thickness);
/*
    intersection(){
        glass_cage(bottom_outer_diameter, bottom_support_thickness);
        translate([0, 0, 4.5]){
            difference(){
                cylinder(10, 120, 120, true);
                cylinder(11, 20, 20, true);
            }
        }
    }
*/
}


rotate([0, 0, 50]){
    translate([0, 0, -14]){
        receiverCase(bottom_radius * 2);
    }
}

