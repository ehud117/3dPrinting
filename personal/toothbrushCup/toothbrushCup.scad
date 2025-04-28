use <functional.scad>
use <decorative.scad>
d = 85;
epsilon = 0.1;


module mystar()
{
    scale(0.8) star(5,15,6);
}

r = 3;
bw = 2;
h25=23;
h3 = 105-h25;


h0 = 3;
hull()
{
    cylinder(h = 0.1, d = d + 10, $fn = 100);
    moveZ(h0) rotateZ(360/8/2) cylinder(h=0.1, d = d, $fn = 8);
}

moveZ(h0)
{

h1 =12;
ro = d/2;
ri = (d-6)/2;
a = 360/8/2;

rotateZ(90) linear_extrude(h1) polygon([
    [ro*sin(-a), ro*cos(-a)],
    [ro*sin(a), ro*cos(a)],
    [ro*sin(3*a), ro*cos(3*a)],
    [ro*sin(5*a), ro*cos(5*a)],
    [ro*sin(7*a), ro*cos(7*a)],
    [ro*sin(9*a), ro*cos(9*a)],
    [ro*sin(9*a), ri*cos(9*a)],
    [ri*sin(7*a), ri*cos(7*a)],
    [ri*sin(5*a), ri*cos(5*a)],
    [ri*sin(3*a), ri*cos(3*a)],
    [ri*sin(a), ri*cos(a)],
    [ro*sin(-a), ri*cos(-a)]]);


//#cube(d * cos(360/8/2), center = true);
od = d * cos(360/8/2);

h2 = 14;
intersection()
{
    rotateZ(360/8/2) cylinder(h = h2, d = d, $fn = 8);
    moveX(-od/2) for (i = [1:1:7])
    {
        translate([(od-bw) / 8 *i + 1,-od/2,0]) 
        {
            cube([bw, od, h2]);
        }
    }        
}
intersection(){
rotateZ(360/8/2) cylinder(h =h2, d=d,$fn=8);
rotateZ(-90) rotateX(90) moveZ(-d/2*cos(360/8/2))linear_extrude(d*cos(360/8/2)) polygon(
[
[d/2*cos(360/8/2),0],
[-d/2*cos(360/8/2),0],
[-d/2*cos(360/8/2),h2]
]); 
}

moveZ(h1)
{
    difference()
    {
        rotateZ(360/8/2) cylinder(h = h2-h1, d = d, $fn = 8);
        moveZ(-epsilon) rotateZ(360/8/2) cylinder(h = h2-h1 + 2 * epsilon, d = 2*ri, $fn = 8);
    }
}

decMov = 15;

moveZ(h2)
{
    difference()
    {
        hull()
        {
            rotateZ(360/8/2) cylinder(h = h25, d = d, $fn = 8);
            moveZ(h25) rotateZ(360/8/2) cylinder(h = h3, d = d, $fn = 128);
        }
        moveZ(-epsilon) rotateZ(360/8/2) cylinder(h = h3 + 4 * epsilon, d = 2*ri, $fn = 8);
        
        moveZ(h25) 
                moveZ(-epsilon) rotateZ(360/8/2) cylinder(h = h3+ 4 * epsilon, d = 2*ri, $fn = 128);
        
         for (i = [0:1:3])       rotateZ(i*45)
        moveZ(h3+h25-20 - (i % 2) * decMov) moveY( (d + 4+ 2 * epsilon) / 2) rotateY(360/4 + 180) rotateX(90) linear_extrude(d + 4 + 2 * epsilon) scale(0.8)  mystar();
        
    }
    moveZ(h3+h25) torus(ro, ri,$fn=128);
    
    for (i = [0:1:3])
    {
        rotateZ(i*45)
        difference()
        {
            moveZ(h3+h25-20- (i % 2) * decMov) moveY( (d + 4) / 2) rotateY(360/4 + 180) rotateX(90) linear_extrude(d + 4)   mystar();
            moveZ(h3+h25-20- (i % 2) * decMov) moveY( (d + 4+ 2 * epsilon) / 2) rotateY(360/4 + 180) rotateX(90) linear_extrude(d + 4 + 2 * epsilon) scale(0.8)  mystar();
            moveZ(h25) 
                    moveZ(-epsilon) rotateZ(360/8/2) cylinder(h = h3+ 4 * epsilon, d = 2*ri, $fn = 128);
            difference()
            {
                moveZ(-epsilon) rotateZ(360/8/2) cylinder(h = h3+h2+ 4 * epsilon, d = d + 14, $fn = 128);
                moveZ(-epsilon) rotateZ(360/8/2) cylinder(h = h3+h2+ 4 * epsilon, d = d+1.5, $fn = 128);

            }
        }
    }

}
}
