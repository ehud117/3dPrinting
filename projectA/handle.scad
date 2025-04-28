use <leverArms.scad>

armFinishLen = 25;
profileR = leverArms_getProfileR();
distanceR = leverArms_getDistanceR();



module handle()
{
    module U_helper()
    {
        E = distanceR + 2 * profileR;
        translate([-E,0,-profileR]) cube([2 * E, E, 2 * profileR]);
    }

    module U_shape()
    {
        difference()
        {
            rotate_extrude(convexity = 10, $fn = 60)
            translate([distanceR + profileR, 0, 0])
            leverArms_profile();
            U_helper();
        }
    }

    union()
    {
        U_shape();
        translate([0, -(distanceR + profileR), 0]) rotate([90,0,0])  linear_extrude( armFinishLen) circle(r = profileR, $fn = 6);
        leverArms();
    }
}
handle();
