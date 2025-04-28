use <functional.scad>
$fn = 64;

module op() {children();}
//module op() {}
//module tmp() { children();}

    module insertHole()
    {
        translate([10/2,-0.01,10/2]) rotateX(-90) cylinder(d= 3.6, h = (4 + 3));
        translate([10/2,-0.01,10/2]) rotateX(-90) cylinder(d= 3.15, h = 10.02);
    }
    module screwHole()
    {
        translate([10/2,0,10/2]) rotateX(-90) rotate_extrude(angle=360) polygon([[0,0], [0, 10], [4.5, 10], [2.6, 10 - 4.5 + 2.6], [2.6, 0]]); 
    }



module gamma()
{
    difference()
    {
        union()
        {
            linear_extrude(10)
            polygon([[0,0],[145,0] ,[145,10], [10,10], [10,200], [0,200]]);
        }
        moveX(30) insertHole();
        moveX(125) insertHole();
        color ("red") moveX(55) screwHole();
        moveX(110) screwHole();
        moveY(55) rotateZ(-90) insertHole();
        moveY(175) rotateZ(-90) insertHole();
    }
}



gamma();
op() color("red") moveZ(210-50-1) gamma();
op() color("blue") difference()
{
    linear_extrude(210-50) union()
    {
        square(10);
        moveX((145-10)/2) square(10);
        moveX(145-10) square(10);
        moveY((200-10)/2) square(10);
        moveY(200-10) square(10);
    }
    translate([0,105,(210-50)/2] ) rotateZ(-90) insertHole();
//    translate([(145-10)/2,0,(210-50-10)/2]) screwHole();
}
    