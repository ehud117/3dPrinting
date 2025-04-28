use <functional.scad>
use <decorative.scad>
$fn=128;
bearingOuter = 22;


middleOuter = 60;
pHeight = 12;
slidingH = 2;
baseH=2.5;
numWeightHoles = 8;

module weightsStar()
{
    star(8,5,4.3);
}
module weightsStarBolge()
{
    star(8,5,4);
}

module middle()
{
    
    difference()
    {
        union()
        {
                difference()
            {
                ring(pHeight, middleOuter/2, (middleOuter - bearingOuter+4)/2);

            moveZ(baseH) linear_extrude(pHeight) star(20, (bearingOuter+2)/2,bearingOuter/2);
            moveZ(pHeight-slidingH+0.01) linear_extrude(slidingH,scale=1.05) star(20, (bearingOuter+2)/2,bearingOuter/2);
            }
            moveZ(pHeight) difference()
            {
                cylinder(pHeight, d1 = middleOuter-6,d2= middleOuter - 8);
                cylinder(pHeight + 1, d = bearingOuter +4);
            }
        }
        for (i = [0:1:numWeightHoles-1])
            rotateZ(i*360/numWeightHoles)
        union()
        {
            translate([(middleOuter - 16)/2, 0, baseH])
     multmatrix([[1,0,-5/17/2,0],[0,1,0,0],[0,0,1,0]]) linear_extrude(17+0.01) weightsStar();
            
        translate([(middleOuter - 21)/2, 0, baseH+17])
      linear_extrude(5) weightsStar();
            }
    }
}


module middleCover()
{
    cylinder(h=3,d=50);
        for (i = [0:1:numWeightHoles-1])
            rotateZ(i*360/numWeightHoles)               
        moveZ(3) moveX((middleOuter - 21)/2)
      linear_extrude(4.3) weightsStarBolge();
       
}
//middleCover();
//import("faceWithBeard.stl");
difference()
{
    union()
    {
        import("headMA.stl");
//        moveY(20) moveX(-35) moveZ(277) sphere(110);
    }
//    moveY(20) moveX(-35) moveZ(277) rotateX(-45) difference()
//    {
//        cylinder(250, r = 90);
//        sphere(109);
//        
//    }
}