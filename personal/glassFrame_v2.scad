use <functional.scad>

module attachment2D()
{
        polygon([[-2,0],[2,0],[2,-2.2],[-2,-2.2]]);
        polygon([[sqrt(2),sqrt(2)],[sqrt(2),-2.2],[2.2+2*sqrt(2),-2.2]]);
        circle(d=4,$fn=64);
}



module attachment()
{
    
    difference()
    {
        linear_extrude(3.2) attachment2D();
        linear_extrude(3.2) circle(d=1.55, $fn=64);
        intersection()
        {
            union()
            {
                difference()
                {
                    linear_extrude(0.5) circle(d=4,$fn=64);
                    linear_extrude(0.5,scale = 1/0.93) circle(d=4*0.93,$fn=64);
                }
                moveZ(3.2-0.5) difference()
                {
                    linear_extrude(0.5) circle(d=4,$fn=64);
                    linear_extrude(0.5,scale = 0.93) circle(d=4,$fn=64);
                }
            }
            moveX(-sqrt(2)) moveY(sqrt(2)) cube(10);
        }
    }
   
    
}
//!attachment();
cfaces = [  [0,1,2,3],  [4,5,1,0],  [7,6,5,4],  [5,6,2,1],    [6,7,3,2],    [7,4,0,3]]; 
  



module rightTemplePositive()
{
    linear_extrude(1.4) polygon([[0,0],[70,4-6], [70,9.2-6], [0,9.2]]);
    
    x1 = 90;y1 = -3; z1 = 6.4;
    p1 = [90, -3, 6.4];
    phelper = [135,-25,30];
    p2 = 0.7*p1 + 0.3*phelper;
    p3 = phelper - [13,0,0];
    hull()
    {
        linear_extrude(1.4) polygon([[69,-2],[70,4-6], [70,9.2-6], [69,3.2]]);
    
        translate(p1) sphere(d=5, $fn =64);
    }
//
//    hull()
//    {
//        moveY(-1) moveX(50) cube([0.05, 6,1.4]);
//        translate(p1) sphere(d=5, $fn =64);
//    }
    
    hull()
    {
        translate(p1) sphere(d=5, $fn =64);
        translate(p2) sphere(d=5, $fn =64);   
    }
    hull()
    {
        translate(p2) sphere(d=5, $fn =64);
        translate(p3) sphere(d=5, $fn =64);   
    }

    
    
    translate([2,3+3.2,2.2+1.4]) rotateX(90) attachment();
    
    //    polyhedron([[70,4,0], [70,4-6,2.4], [70,9.2-6,2.4], [70,9.2-6,0], 
//    [90,4-6,4], [90,4-6,2.4+4], [90,9.2-6,2.4+4], [90,9.2-6,0+4]], faces = cfaces);
//    polyhedron([[90,4-6,4], [90,4-6,2.4+4], [90,9.2-6,2.4+4], [90,9.2-6,0+4],     [135,-30,4+25], [135,-30,2.4+4+25], [135,9.2-30,2.4+4+25], [135,9.2-30,0+4+25]], cfaces);
}

module rightTemple()
{
    rightTemplePositive();
       
}

module leftTemple()
{
    mirror([0,1,0]) rightTemple();
}


//rightTemple();
//leftTemple();


$fn=64;
x=1.7;
y=5.8;

linear_extrude(2.5) {
     difference(){
         union()
         {
            circle(d=4);
            polygon([[0,-2], [0,2], [y,2], [y+x,-2]]);
         }
         circle(d=1.65);
    }
}
moveZ(2.5) linear_extrude(3.2) polygon([[y-2.5+x,-2], [y-2.5,2], [y,2], [y+x,-2]]);
moveZ(2.5+3.2)  linear_extrude(2.5) {
     difference(){
         union()
         {
            circle(d=4);
            polygon([[0,-2], [0,2], [y,2], [y+x,-2]]);
         }
         circle(d=1.65);
    }
}

