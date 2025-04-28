for (i = [0 : 4])
{
        translate([0,0, 4 *i]) union()
        {   
            cube([100 - 20 * i, 4, 4]);
            cube([4, 100 - 20 * i, 4]);
        }
        translate([4 * i, 0, 0]) cube([4,4, 100 -20 *i]);
}
translate([75,2.5,8])
cylinder(3, d = 2, $fn =32);