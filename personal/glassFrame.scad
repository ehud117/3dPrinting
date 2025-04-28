use <functional.scad>

module attachment2D()
{
    difference()
    {
        union()
        {
            polygon([[-2,0],[2,0],[2,-2.2],[-2,-2.2]]); 
            circle(d=4,$fn=64);
        }
    }
}

module attachment()
{
    
    difference()
    {
        union()
        {
            //linear_extrude(3.2) attachment2D();
            linear_extrude(3.2) polygon([[-2,-2],[2,-2],[2,-2.2],[-2,-2.2]]);
            rotateY(180) moveZ(-0.5) linear_extrude(0.5, scale = 0.93) attachment2D();
            moveZ(0.5) linear_extrude(3.2-2*0.5) attachment2D();
            moveZ(3.2-0.5) linear_extrude(0.5, scale =0.93) attachment2D();
        }
        linear_extrude(3.2) circle(d=1.55, $fn=64);
    }
}


cfaces = [  [0,1,2,3],  [4,5,1,0],  [7,6,5,4],  [5,6,2,1],    [6,7,3,2],    [7,4,0,3]]; 
  



module rightTemplePositive()
{
    linear_extrude(2.4) polygon([[0,0],[70,4-6], [70,9.2-6], [0,9.2]]);
    
    hull()
    {
        linear_extrude(2.4) polygon([[69,-2],[70,4-6], [70,9.2-6], [69,3.2]]);
    
        translate([90, -3, 6.4]) sphere(d=5, $fn =64);
    }

    hull()
    {
        translate([90, -3, 6.4]) sphere(d=5, $fn =64);
        translate([135, -25, 30]) sphere(d=7, $fn =64);   
    }
    
    
    translate([2,3+3.2,2.2+2.4]) rotateX(90) attachment();
    
    //    polyhedron([[70,4,0], [70,4-6,2.4], [70,9.2-6,2.4], [70,9.2-6,0], 
//    [90,4-6,4], [90,4-6,2.4+4], [90,9.2-6,2.4+4], [90,9.2-6,0+4]], faces = cfaces);
//    polyhedron([[90,4-6,4], [90,4-6,2.4+4], [90,9.2-6,2.4+4], [90,9.2-6,0+4],     [135,-30,4+25], [135,-30,2.4+4+25], [135,9.2-30,2.4+4+25], [135,9.2-30,0+4+25]], cfaces);
}

module rightTemple()
{
    difference()
    {
        rightTemplePositive();
        translate([8,10,2.2]) rotateX(90) cylinder(d=2.5,h=20, $fn =32);
    }
       
}

module leftTemple()
{
    mirror([0,1,0]) rightTemple();
}


rightTemple();
//leftTemple();


