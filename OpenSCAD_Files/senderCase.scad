use <sender.scad>
use <threads.scad>

$fn = 500;

module topPlate(){
    difference(){
        translate([0, 0, -2]){
            difference () {
                cylinder (r=43.5, h=5, $fn=100);
                translate([0, 0, -1]){
                    metric_thread (diameter=85, pitch=2, length=4.8, internal=true, n_starts=1);
                }
            }
        }
        translate([20, -4, -2]){
            color([1.0, 0.0, 0.0, 1.0]){
                cube([30, 8, 3]);
            }
        }
    }
}

intersection(){
    translate([20, -10, -15]){
        cube([30, 20, 30]);
    }
union(){
translate([26, -4.5, -1]){
    chipCarrier();
}

difference(){        
    translate([0, 0, -3.2]){
        metric_thread (diameter=85 - 0.7, pitch=2, length=4.8, internal=true, n_starts=1);
    }
    union(){
        cylinder(5, 40, 40, true);
        translate([20, -6, -2]){
            color([1.0, 0.0, 0.0, 1.0]){
                cube([30, 12, 7]);
            }
        }
    }
}
}
}





module baseplate(){
    difference(){
        union(){
            cylinder(1, 27, 27, true);
            translate([0, 0, 2.5]){
                difference(){
                    cylinder(4, 27, 27, true);
                    cylinder(5, 26, 26, true);
                }
            }
        }
        translate([20, -4, 1]){
            color([1.0, 0.0, 0.0, 1.0]){
                cube([10, 8, 3]);
            }
        }
    }
}

module rotation_lock(length = 10, depth = 2, height = 3){
    head_length = length * 0.8;
    head_depth = depth;
    head_height = height * 0.9;
    tail_length = length * 0.1;
    tail_depth = depth;
    tail_height = height * 0.9;
    stop_length = length * 0.1;
    stop_depth = depth;
    stop_height = height;
    difference(){
        union(){
            rotate([0, 180, 180]){
                translate([0, -head_depth, -height]){
                    difference(){
                        cube([head_length, head_depth, head_height]);
                        translate([-head_length * 0.1, -head_depth * 0.1, -head_height * 0.1]){
                            rotate([0, -atan(head_height / head_length), 0]){
                                cube([head_length * 1.2, head_depth * 1.2, head_height * 1.2]);
                            }
                        }
                    }
                }
            }
            translate([head_length, 0, height * 0.1]){
                difference(){
                    cube([tail_length, tail_depth, tail_height]);
                    translate([-tail_length * 0.1, -tail_depth * 0.1, 0]){
                        rotate([0, atan(tail_height / tail_length), 0]){
                            cube([tail_length * 1.2, tail_depth * 1.2, tail_height * 1.2]);
                        }
                    }
                }
            }
        }
        translate([head_length - (tail_length * 0.6) / 2, -tail_depth * 0.1, height * 0.05]){
            cube([tail_length * 0.6, tail_depth * 1.2, tail_height * 0.1]);
        }
    }
    
    translate([head_length + tail_length, 0, 0]){
        cube([stop_length, stop_depth, stop_height]);
    }
    //cylinder(20, 5, 5, true);
    
    function f1(x, head_height, head_length, height) = (-head_height / head_length) * x + height;
    function f2(x, tail_length, tail_height, height) = ((tail_length / tail_height) * x + (height * 0.1 - (tail_length / tail_height) * (head_length - tail_length * 0.1)));
    function schnitt(x1, y1, x2, y2, x3, y3, x4, y4) = [((x2 - x1)*(x3 * y4 - y3 * x4) - (x4 - x3)*(x1 * y2 - y1 * x2)) / ((x2-x1)*(y4-y3)-(y2-y1)*(x4-x3)),
    ((y2 - y1) * (x3 * y4 - y3 * x4) - (y4 - y3) * (x1 * y2 - y1 * x2)) / ((x2-x1)*(y4-y3)-(y2-y1)*(x4-x3))];
    x1 = (head_length - (tail_length * 0.6) / 2);
    x3 = (head_length + (tail_length * 0.6 / 2));
    x2 = x3;
    x4 = x1;
    crossPoint = schnitt(x1, f1(x1, head_height, head_length, height), x2, f1(x2, head_height, head_length, height), x3, f2(x3, tail_length, tail_height, height), x4, f2(x4, tail_length, tail_height, height));
    /*
    translate([crossPoint.x, -1, crossPoint.y]){
        color([1.0, 0.0, 0.0, 1.0]){
            cube([0.01, 0.01, 0.01]);
        }
    }
    translate([(head_length - (tail_length * 0.6) / 2), 0, (-head_height / head_length) * (head_length - (tail_length * 0.6) / 2) + height]){
        color([1.0, 0.0, 0.0, 1.0]){
            cube([0.01, 0.01, 0.01]);
        }
    }
    translate([(head_length + (tail_length * 0.6 / 2)),
   -1,
   (tail_length / tail_height) * (head_length + (tail_length * 0.6 / 2)) + height * 0.1 - tail_height * 0.6
    ]){
        color([1.0, 0.0, 0.0, 1.0]){
            cube([0.01, 0.01, 0.01]);
        }
    }
    */
    /*
    for(x =[0:0.1:10]){
        translate([x, -1, f1(x, head_height, head_length, height)]){
            color([1.0, 0.0, 0.0, 1.0]){
                cube([0.01, 0.01, 0.01]);
            }
        }
        translate([x, -1, f2(x, tail_length, tail_height, height)]){
            color([1.0, 0.0, 0.0, 1.0]){
                cube([0.01, 0.01, 0.01]);
            }
        }
    }
    */
    /*
    //Code from https://rosettacode.org/wiki/Gaussian_elimination#Java
    //Code from https://eribuijs.blogspot.com/2017/10/openscad-lists-and-list-manipulation.html
    lst = [1];
    function partial(list,start,end) = [for (i = [start:end]) list[i]];
    function remove_item(list,position) = [for (i = [0:len(list)-1]) if (i != position) list[i]];
    function add_value(list, value) = concat(list, [value]);
    function insert(list,value,position) = let (l1 = partial(list,0,position-1), l2 = partial(list,position,len(list)-1)) concat(add_value(l1,value),l2);
     echo(insert(lst,10,4));
    lst2 = add_value(lst, 3);
    echo(lst2);
    //echo(insert(lst2, 4, 1));
    lst2 = insert(lst2, 4, 1);
    echo(lst2);
    
    
    
    
    (j[1] == -1) ? state0(a, b, [k[0], k[1], k[2]], [j[0], i, j[2], j[3]]) : 
    (j[1] == n ? state0(a, b, [k[0], k[1], k[2]], [j[0], j[1], 0, j[3]]) : (/*Manipulate a/))
    (j[2] == p) ? state0(a, b, [k[0], k[1], k[2]], [j[0], j[1], j[2], j[3]]);
    
    //state = [i, k=[k1, k2, k3], j=[j1, j2, j3, j4]]
    function state0(a, b, state) = let (n = len(b))
    (i == n - 1) ? [a, b] : 
        ((j[0] == n) ? 
            ((k[0] != i) ? : )
    : state0(a, b, [i, [j[0], k[1], k[2]], [j[0] + 1, j[1], j[2], j[3]]]));
    
    function gauss(a, b, state) = assert(len(a) == len(b), "Wrong Dimensions a b") 
    assert(len([for(i=a) if (len(i) != len(a)) true]) == 0, "Wrong Dimensions a")
    (state == 0) ? 0 : ((state == 1) ? 0 : []);
    a = [[4, 1, 0, 0, 0],
         [1, 4, 1, 0, 0],
         [0, 1, 4, 1, 0], 
         [0, 0, 1, 4, 1],
         [0, 0, 0, 1, 4]];
    b = [[0.5],
         [2/3],
         [3/4],
         [4/5],
         [5/6]];
    echo(len(a));
    echo(len(a[0]));
    echo(len(b));
    echo(gauss(a, b, 0));
    */
    
}

module chipCarrier(){
    union(){
        translate([-2.5, -2, -5]){
            //cube([12, 14, 3]);
        }
        pinHeight = 5;
        cylinder(pinHeight, 1, 1, true);
        translate([6.95, 0, 0]){
            cylinder(pinHeight, 0.85, 0.85, true);
        }
        translate([0, 9.15, 0]){
            cylinder(pinHeight, 0.85, 0.85, true);
            translate([7.15, -0.15, 0]){
                cylinder(pinHeight, 1, 1, true);
            }
        }
        translate([0, 0, -1.5]){
            cylinder(1.5, 1.2, 1.2, true);
            translate([6.95, 0, 0]){
                cylinder(1.5, 1, 1, true);
            }
            translate([0, 9.15, 0]){
                cylinder(1.5, 1, 1, true);
                translate([7.15, -0.15, 0]){
                    cylinder(1.5, 1.2, 1.2, true);
                }
            }
        }
    }
}

module topcover(){
    cylinder(5, 13, 10, true);
    cylinder(1, 20, 20, true);
}


*union(){
    baseplate();
    translate([10, -4.5, 2.5]){
        color([1.0, 0.0, 0.0, 1.0]){
            chipCarrier();
        }
    }
/*
    color([0.0, 1.0, 0.0, 1.0]){
        translate([-5, 20, 0.7]){
            rotation_lock(10, 3, 3);
        }
        rotate([0, 0, 180]){
            translate([-5, 20, 0.7]){
                rotation_lock(10, 3, 3);
            }
        }
    }
    */
}




translate([0, 0, 10]){
    color([1.0, 0.0, 0.0, 1.0]){
        //sender();
    }
}