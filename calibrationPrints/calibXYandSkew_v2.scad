size = 100;
h = 2;
w = 4;
//fontLine = 1;
sqrt2 = sqrt(2);
epsilon = 0.01;
module triang()
{
    intersection()
    {
        union()
        {
            difference()
            {
                cube([size, size, h]);
                translate([w,w,0]) cube([size - 2 * w, size - 2 * w, h + epsilon]);
            }
            translate([w/2/sqrt2,-w/2/sqrt2,0]) rotate([0,0,45])  cube([size * sqrt2, w, h]);
            translate([size + w/2/sqrt2,w/2/sqrt2,0]) rotate([0,0,180-45])  cube([size * sqrt2, w * sqrt2, h]);
        }
        difference()
        {
            cube([size, size, h]);
            translate([size, 0,0]) rotate([0,0,45]) cube([300,300,h]);
        }
    }
}
module xSign()
{
    union()
    {
        rotate([0,0,45]) translate([0,0,h/2]) cube([3.5,1,h], center = true);
        rotate([0,0,-45]) translate([0,0,h/2]) cube([3.5,1,h], center = true);
    }
}
module ySign()
{
    translate([1/2/sqrt2,0,0]) rotate([0,0,45]) cube([3.5/2,1,h]);
    translate([1/2/sqrt2,1/sqrt2,0])rotate([0,0,135]) cube([3.5/2,1,h]);
    translate([-0.5,-2, 0]) cube([1,3,h]);
}


// first triangle
module firstTri()
{
    difference()
    {
        triang();
        translate([2, size/3, 0])scale([0.6,0.6,1]) ySign();
        translate([size/3, 2, 0]) scale([0.6,0.6,1]) xSign();
    }
}
// second triangle
module secondTri()
{
    translate([1.6 * (size + w),0.35*size+w,0])  rotate([0,0,90]) difference()
    {
        triang();
        translate([1.75, size/3 - 4, 0]) cube([0.5,2,h]);
        translate([2, size/3, 0])scale([0.6,0.6,1]) xSign();
        translate([size/3, 1.8, 0]) scale([0.6,0.6,1]) ySign();

    }
}

module skewFinder()
{
    a = 100;
    b = 40;
    fw = 2;
    linear_extrude(15) polygon([[0,0],[0,a],[fw,a],[fw,0]]);
    linear_extrude(15) polygon([[0,0],[b,0],[b,fw],[0,fw]]);
    linear_extrude(15) polygon([[0,a],[b,a],[b,a-fw],[0,a-fw]]);
    linear_extrude(15) polygon([[b,fw],[1.5*fw, a-fw],[0.5*fw, a-fw],[b-fw,fw]]);
    linear_extrude(15) polygon([[b,a-fw],[1.5*fw, fw],[0.5*fw, fw],[b-fw,a-fw]]); 
        
}

module xzSkrewFinder()
{
    rotate([90, 0,0]) difference()
    {
        skewFinder();
        translate([1.5,1.5,0]) scale([0.4,0.4, 20]) xSign();
    }
}

module yzSkrewFinder()
{
    rotate([90, 0,90]) difference()
    {
        skewFinder();
        translate([1.5,1.5,0]) scale([0.4,0.4, 20]) ySign();
    }
}

module stopper()
{
    translate([0, -20, 0]) cube([170, 10, 2]);
    translate([30, -15, 0]) cube([10, 10, 2]);
}

module main()
{
    firstTri();
    secondTri();
    translate([120, 20, 0]) xzSkrewFinder();
    translate([70, 80, 0]) yzSkrewFinder();
    stopper();
}

main();
    