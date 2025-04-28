size = 150;
h = 2;
w = 4;
//fontLine = 1;
sqrt2 = sqrt(2);
module main()
{
    intersection()
    {
        union()
        {
            difference()
            {
                cube([size, size, h]);
                translate([w,w,0]) cube([size - 2 * w, size - 2 * w, h]);
            }
            translate([w/2/sqrt2,-w/2/sqrt2,0]) rotate([0,0,45])  cube([size * sqrt2, w, h]);
            translate([size + w/2/sqrt2,w/2/sqrt2,0]) rotate([0,0,180-45])  cube([size * sqrt2, w, h]);
        }
        cube([size, size, h]);
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
multmatrix(m = [[1,0.05,0,0], [0,1,0,0], [0,0,1,0]]) difference()
{
    main();
    translate([2.5, size/3, 0])scale([0.8,0.8,1]) ySign();
    translate([size/3, 2.5, 0]) scale([0.8,0.8,1]) xSign();
}
