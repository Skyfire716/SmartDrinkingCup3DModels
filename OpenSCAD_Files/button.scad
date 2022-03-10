module button(){
    translate([-2.995, -2.995, 0]){
    cube([5.99, 5.99, 3.61]);
    }
    translate([0, 0, 3.3]){
       cylinder(2, 1.755, 1.755, true);
    }
}

$fn=50;

button();