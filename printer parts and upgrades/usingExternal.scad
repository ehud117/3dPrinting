use <functional.scad>
module orig()
{
translate([0,170,-7]) rotate([90,0,0]) import("Filament_holder_v6.stl");
}


difference()
{
    orig();
    
    translate([-25, -100,0]) cube([50, 35, 30]);
    translate([-25, 20,0]) cube([50, 65, 30]);
    translate([-90, -45,0]) cube([50, 65, 30]);
    translate([40, -45,0]) cube([50, 65, 30]);
    
    translate([-25, -100,12]) minkowski(){ cube([50, 50, 30]); rotateY(90) cylinder(h = 50, r = 5);}
    
    moveXY(8.5, 10) tappedHole(4,10);
    moveXY(-8.5, 10) tappedHole(4,10);

    moveXY(8.5, -55) tappedHole(4,10);
    moveXY(-8.5, -55) tappedHole(4,10);

    moveXY(-32, -10) tappedHole(4,10);
    moveXY(-32, -27) tappedHole(4,10);

    moveXY(32, -10) tappedHole(4,10);
    moveXY(32, -27) tappedHole(4,10);
}
