use <functional.scad>
use <decorative.scad>
$fn=128;

module outer(x)
{
    difference()
    {
    cylinder(h = 2 + 2.5 + 7.5, d = x+5);
    cylinder(h = 2 + 2.5 + 7.5, d = x-6);    
    moveZ(2) linear_extrude(7.5) star(20, (x+2)/2,x/2);
    moveZ(2+7.5) linear_extrude(2.5,scale=1.05) star(20, (x+2)/2,x/2);
    }
}
outer(22);

module inner(x)
{
    difference()
    {
        union()
        {
            cylinder(h = 4, d = x + 2);
            linear_extrude(20) star(20, x/2, (x-2)/2);
            moveZ(20) linear_extrude(3,scale = 0.95) star(20, x/2, (x-2)/2);
        }
        translate([2.5, -2.5, 0]) rotateY(180) linear_extrude(2) text(str(x),size = 5);
    }
}
//inner(9);
module testPeg()
{
    difference()
    {
        cylinder(h = 20, d = 12);
        
        moveZ(3) linear_extrude(25) star(20, 9/2, 7.3/2);
    }
}
//testPeg();