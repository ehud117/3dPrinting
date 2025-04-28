use <decorative.scad>
use <functional.scad>

h = 7; // total part height.
nh = 2.001 *h; // For faster rendering. used for holes

d = 85; // outer diameter.
r = d / 2; // outer radious.
radialStripW = 11;
innerHoleD = 16; // need to measure.
innerHoleR = innerHoleD / 2;
$fn = 70;
sqrt2 = sqrt(2);
innerStripW = 6;



module main()
{
	difference()
	{
		r = d / 2;
		union()
        {
            wagonWheel(h, r ,radialStripW, innerHoleR, innerStripW);
      		for (i = [0:1:5])
            {
                rotate ([0,0, i * 60]) translate([0,r - radialStripW / 2,h/2 + 0.3]) heartShape(4, h+0.3);
            }
        } 

		for (i = [0:1:5]) 
		{
			rotate ([0,0, i * 60]) translate([0,r - radialStripW / 2,0]) heartShape(3.5, nh + 2);
		} 
	}
}
//main();



module cut1(x,y)
{
    moveX(y) rotateX(90) moveZ(-x) rotateZ(90) linear_extrude(2 * x) polygon([[0,0], [h/2, h/2/tan(70)], [h, 0]]);
    difference(){
        moveY(-d/2) cube([d/2,d,h+1]);
        difference()
        {
            rotateX(90) moveZ(-d/2) rotateZ(90) linear_extrude(d) polygon([[0,0], [h/2, -h/2/tan(70)], [h, 0]]);
            rotateX(90) moveZ(-x) rotateZ(90) linear_extrude(2 * x) polygon([[0,0], [h/2, -h/2/tan(70)], [h, 0]]);
        }
    }   
}

//cut(22,0.5);
innerJoint = 26;
tolerance = 0.3;
module c1()
intersection()
{
    main();
    cut1(innerJoint, 0.2);
}
c1();




module cut2(x,y)
{
    moveX(y) rotateX(90) moveZ(-x) rotateZ(90) linear_extrude(2 * x) polygon([[0,0], [h/2, h/2/tan(70)], [h, 0]]);
    difference(){
        moveY(-d/2) cube([d/2,d,h]);
        moveX(-0.2) difference()
        {
            rotateX(90) moveZ(-d/2) rotateZ(90) linear_extrude(d) polygon([[0,0], [h/2, -h/2/tan(70)], [h, 0]]);
            rotateX(90) moveZ(-x) rotateZ(90) linear_extrude(2 * x) polygon([[0,0], [h/2, -h/2/tan(70)], [h, 0]]);
        }
    }   
}

module c2()
{
    intersection()
    {
        main();
        difference() 
        {
            moveY(-d/2) moveX(-d/2) cube([d,d,h]);
            cut2(innerJoint+tolerance, 0);
        }
    }
}
//c2();



