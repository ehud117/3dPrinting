use <functional.scad>
$fn=64;

holeCenter = [55-24,19];

d1_1=21.2;
d1_2=d1_1-4;

module all()
{
translate(holeCenter)  linear_extrude(5,scale=1/0.8)
{
    scale(0.8)
    difference()
    {
        circle(d=d1_1);
        circle(d=d1_2);
    }
}
moveZ(5)
linear_extrude(35)
{
    translate(holeCenter) difference()
    {
        circle(d=d1_1);
        circle(d=d1_2);
    }
}

dsh=5;
moveZ(40)
linear_extrude(3.5)
{
    difference()
    {
        square([55,50]);
        translate([55-46,15]) circle(d=dsh);
        translate(holeCenter) circle(d=d1_2);
        translate([55-8,40]) circle(d=dsh);
        
    }
}

d2=27;
translate(holeCenter) moveZ(40+3.5)
{
linear_extrude(35)
{
    difference()
    {
        circle(d=d2);
        circle(d=d2-5);
    }
}
moveZ(35)
linear_extrude(5, scale=0.8)
{
     difference()
    {
        circle(d=d2);
        circle(d=d2-5);
    }
}
}



}
all();