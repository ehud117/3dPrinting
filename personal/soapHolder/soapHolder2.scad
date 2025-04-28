use <decorative.scad>
use <functional.scad>

scale(0.8)
{
    golden = 1.618;

    x = 110;
    y = x/golden;
    h = 25;
    r = 3;
    bw = 2;
    echo(str(h));

    //!Qsphere();
    rotateY(90) rotateZ(90) linear_extrude(x) polygon([[0,0], [0,h], [(1-1/golden/golden) * y, h /4], [y-2, 0]]);


    for (i = [0:1:10])
        translate([(x-bw) *i/10,0,0]) 
        {
                cube([bw, y, h-r]);
                cube([bw, y-r, h]);
                translate([0,y-r,h-r]) rotateY(90) cylinder(h=bw, r=r, $fn=128);
        }
    }