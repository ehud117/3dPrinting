use <presser.scad>
use <leverArms.scad>

mountingDistance = 18;
mountingBottomHoleCenter = 2;
function mountingHoles_getBottomPosition() = [0,0,mountingBottomHoleCenter];
function mountingHoles_getTopPosition() = [0,0,mountingBottomHoleCenter + mountingDistance];
presserR = presser_getR();
holeR = 1;


module mountingHoles(ang = 0)
{
    translate([0,0,mountingDistance/2 + mountingBottomHoleCenter]) rotate([ang,0,0])    union()
    {
        #translate([-presserR - 15, 0, mountingDistance / 2]) rotate([0, 90, 0]) cylinder(h = 2 * presserR + 30, r = holeR, $fn =32);
        #translate([-presserR - 15, 0, -mountingDistance / 2]) rotate([0, 90, 0]) cylinder(h = 2 * presserR + 30, r = holeR, $fn =32);
    }
    
}
mountingHoles();