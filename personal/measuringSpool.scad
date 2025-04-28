use <functional.scad>

V = 15000; // Teaspoon
writingT = "כף";

innerH = 0.9 * pow(V, 1/3);
innerR = sqrt(V/PI/innerH);
wallT = 2.5;
$fn=100;


echo(PI * innerR * innerR * innerH);


difference()
{
    cylinder(h = innerH + wallT, r = innerR + wallT);
    moveZ(wallT) cylinder(h = innerH, r = innerR);
}

difference()
{
    union()
    {
        moveX(innerR) moveZ(wallT + innerH/2) rotate_extrude() polygon([[0,0], [3,6],[0,6]]);
        moveX(-innerR) moveZ(wallT + innerH/2) rotate_extrude() polygon([[0,0], [3,6],[0,6]]);
        moveX(innerR) moveZ(wallT + innerH/4) rotate_extrude() scale(0.5) polygon([[0,0], [3,6],[0,6]]);
        moveX(-innerR) moveZ(wallT + innerH/4) rotate_extrude() scale(0.5) polygon([[0,0], [3,6],[0,6]]);
        moveY(innerR) moveZ(wallT + innerH/3) rotate_extrude() scale(0.8) polygon([[0,0], [3,6],[0,6]]);
        moveY(-innerR) moveZ(wallT + innerH/3) rotate_extrude() scale(0.8) polygon([[0,0], [3,6],[0,6]]);
    }
    moveZ(wallT) cylinder(h = innerH, r = innerR-0.5);
    difference()
    {
        cylinder(h = innerH + wallT, r = innerR + 10);
        moveZ(wallT) cylinder(h = innerH, r = innerR);
    }
}

moveZ(innerH)
linear_extrude(wallT) difference()
{
    hull() 
    {
        circle(innerR+wallT);
        moveX(4*innerR) square([0.1,innerR/2], center = true);
    }
    circle(innerR+wallT-0.1);
}

supportWBottom = 8;
supportWTop= 1;
moveX(4*innerR-supportWTop/2) linear_extrude(innerH, scale = [supportWTop/supportWBottom,1])
{
     square([supportWBottom,innerR/2], center = true);
}

font = "Guttman Yad-Light";
color("blue") translate([innerR*1.5,1.5, innerH + wallT]) linear_extrude(0.5) text(writingT, font=font,valign="center", size= 8);
