module mcube()
{
    cube(50);
}
module hole()
{
    translate([0, 25,25]) 
    rotate([0,90,0]) cylinder(50, d = 20,center = false, $fn=64);
}
module body()
{
    difference()
    {
        mcube();
        hole();
    }
}
body();
//hole();