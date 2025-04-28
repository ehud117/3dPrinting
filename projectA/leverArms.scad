use <presser.scad>

armsLen = 60;
distanceR = presser_getR() + 0.5;
profileR = 5;

function leverArms_getProfileR() =  profileR;
function leverArms_getDistanceR() = distanceR;



module leverArms_profile()
{
    circle(r = profileR, $fn = 6);
}

module leverArms()
{
    union()
    {
        translate([-(distanceR + profileR), 0, 0]) rotate([-90,0,0])  linear_extrude(    armsLen) leverArms_profile();
        translate([+(distanceR + profileR), 0, 0]) rotate([-90,0,0])  linear_extrude(    armsLen) leverArms_profile();
    }
}
leverArms();