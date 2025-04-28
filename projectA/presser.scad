use <leverMounting.scad>


radious = 15;
thickness = 4;
height = 25;

function presser_getR() = radious;
function getPresserAng() = 2;

presser();
module presser()
{
    difference()
    {
        cylinder(h = height, r = radious, $fn =64);
        translate([0,0,-1])cylinder(h = height + 2, r = radious - thickness);
        
        mountingHoles(getPresserAng());
    }
    
}
