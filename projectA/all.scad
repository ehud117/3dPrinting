use <handle.scad>
use <leverArms.scad>
use <presser.scad>
use <leverMounting.scad>


translate ([0, -5, 0])
union()
{
    translate (mountingHoles_getTopPosition()) handle();
    translate (mountingHoles_getBottomPosition()) leverArms();
}
rotate([-getPresserAng(), 0, 0]) presser();

