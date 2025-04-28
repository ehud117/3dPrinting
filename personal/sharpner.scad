use <functional.scad>

module op() {children();};


$fn=64;
baseZ = 8;
paperY = 80;
alpha = 11;
paperX = 120;
gap = 2;
supportW = 10;
triangleY = 45;
//marginX = 10;
marginY = 2 * gap/tan(alpha);





rotateX(-90) moveY(-(2 * gap/tan(alpha) + triangleY))
{
cube([ 2 * supportW + paperX, 2 * gap/tan(alpha) + triangleY,baseZ]);    

translate([0, 2 * gap/tan(alpha), baseZ]) cube([supportW, supportW, gap]);
translate([0, 2 * gap/tan(alpha) - supportW + triangleY, baseZ]) cube([supportW, supportW, gap]);
translate([supportW + paperX, marginY, baseZ]) cube([supportW, supportW, gap]);
translate([supportW + paperX, marginY - supportW + triangleY, baseZ]) cube([supportW, supportW, gap]);
 op()  moveX(2 * supportW + paperX) moveY(marginY) moveZ(gap+baseZ) rotateY(-90) linear_extrude(2 * supportW + paperX) polygon(triangleY/cos(alpha) * [[0,0], [sin(alpha),cos(alpha)], [0, cos(alpha)]]);

}