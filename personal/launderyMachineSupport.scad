use <functional.scad>

t1=18;
fn = 250;
$fn=128;
d = 450;
r = d/2;
alpha = asin(100 / r);
thick=8.5;
h1 = asin (85 / r);
h2 = asin (20 / r);
h3 = -h1;



th = 2;
h = 2;
amp = 2;

module helical_wave()
{
//    for (i = [0:0.2:360]) {
//    rotateZ(i) rotate_extrude(angle=1) moveX(r) moveY(amp*sin(60*i)) square([th,h]);
//    }
//    
}


module holeMounting()
{
    cylinder(h=r + thick+2, d=8.5);
    moveZ(r + thick-0.143) cylinder(h = 3, d=17);
}

rotateZ(alpha)
difference()
{
    linear_extrude(t1) 
    polygon([
    for (i =[-fn/2 :1 :fn/2]) r * [cos(i*alpha/(fn/2)),sin(i*alpha/(fn/2))],
    for (i =[fn/2 : -1 : -fn/2]) (r+thick) * [cos(i*alpha/(fn/2)),sin(i*alpha/(fn/2))]
    ]);
    // Champher
    rotate_extrude(angle = 360) polygon([[r+thick+0.1,t1],[r+thick+0.1,t1-2],[r,t1]]);
    
    moveZ(t1/2)
    {
        rotateZ(h1) rotateY(90) holeMounting();
        rotateZ(h2) rotateY(90) holeMounting();
        rotateZ(h3) rotateY(90) holeMounting();
    }
    moveZ(4) helical_wave();
    moveZ(t1-6) helical_wave();

}


