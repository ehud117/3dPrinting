use <functional.scad>


x = 80;
y = 83;
z = 17;
champher = 4;
stripWidth = 10;
$fn = 64;

difference()
{
    mycube([x,y, z], chm=4);
    translate([stripWidth, stripWidth, 0]) cube([x-2*stripWidth, y-2*stripWidth,z]);
}