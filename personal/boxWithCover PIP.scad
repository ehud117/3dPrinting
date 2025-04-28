use <functional.scad>


epsilon = 0.01;
$fn=20;


L1 = 30;

armX = L1 / 10;
mountL = L1/3;
mountPointH = L1/8;
mountD = 4;

module cover()
{
    tolerance = 0.5;
    ML = mountL - tolerance;
    wallThickness = 2;
    moveZ(mountPointH) rotateX(90) cylinder(h = ML, d = mountD, center = true);
    translate(-[mountD,ML,0]/2) cube([mountD,ML,mountPointH]);
    //translate(-[mountD/2,ML/2,wallThickness]) cube([mountD,ML,wallThickness]);
    
    x1 = armX + L1+mountD/2;
    y1 = L1;
    translate(-[mountD/2,y1/2,wallThickness]) cube([x1,y1,wallThickness]);
}

module box()
{
    wallThickness = 2;
    L2 = L1 - 2 *wallThickness;
    moveX(L1/2+armX) difference()
    {
        moveZ(L1/2)           cube(L1, center = true);
        moveZ(L2/2 - epsilon) cube(L2, center = true);
    }
}


box();
alpha = 45;
color("blue") moveZ(mountPointH) rotateY(alpha) moveZ(-mountPointH) cover();
//moveZ(mountPointH) rotateY($t*180) moveZ(-mountPointH) cover();