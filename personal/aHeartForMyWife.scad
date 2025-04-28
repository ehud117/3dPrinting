use <decorative.scad>
use <functional.scad>
$fn = 124;
module halfSphere()
{
    intersection()
    {
        translate([0,0,5]) cube(10, center = true);
        sphere(2);
    }
}



module texts(){
    text1 = "לאודיה";
    text2 = "אשתי";
    translate([-12, -7, 3.5]) linear_extrude(10) text(text1, size = 7, font = "David");
translate([-9, -16.5, 3.5]) linear_extrude(10) text(text2, size = 7, font = "David");
}


difference(){
rotateZ(180) difference()
{
minkowski()
{
    heartShape(25, 4, false);
    halfSphere();
}
    translate([ 17, 1, -0.5]) cylinder(h = 7, d = 4);

}
    texts();
    moveZ(6) rotateY(180) texts();
}
