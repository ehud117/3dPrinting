use <functional.scad>
$fn=128;


module all()
{
d1 = 40;
u = d1/40;

scaleX(1.35) scaleZ(0.92) sphere(d = d1);
x1 = 1.7*d1/3;
y1 = 0.65*d1;
z1 = 14*u;
translate(-[x1/2,y1,0]) mycube([x1, y1, z1],chm=u);


r1=60*u;
ld = 6*u;
r2 = r1-ld;
z2 = z1 + 2 *u;
lline = 1;
r3 = (r1+r2)/2 +lline;
r4 = (r1+r2)/2 -lline;


difference()
{
    moveY(-y1 - r1+2*u) cylinder(h=z2, r = r1);  
    moveZ(-0.05) moveY(-y1 - r1+2*u) cylinder(h=z2+0.1, r = r2);
    moveX(120*u) cube(200, center = true);
    moveX(-120*u) cube(200, center = true);
    moveY(-150*u) cube(200, center = true);
    moveZ(z2-2*u) difference()
    {
        moveY(-y1 - r1+2*u) cylinder(h=z2, r = r3);  
        moveZ(-0.05) moveY(-y1 - r1+2*u) cylinder(h=z2+0.1, r = r4);
        moveX(120*u) cube(200, center = true);
        moveX(-120*u) cube(200, center = true);
        moveY(-150*u) cube(200, center = true);
    }

    
}
translate([20, -30.7,0]*u) cylinder(h=z2, d =1.05*ld);
translate([-20, -30.7,0]*u) cylinder(h=z2, d =1.05*ld);

deye = d1/6;
module eye()
{
    hull()
    {
        difference()
        {
            scaleY(1.6) sphere(d=1.1*deye);
            moveY(-50 * u) cube(100*u, center = true);
        }
        rotateX(-90) cylinder(h=u/3, d=1.15*deye);
    }
//    rotateX(-90) cylinder(h=u, d=1.15*deye);
    scaleY(1.6) sphere(d=deye);
    moveX(-0.75*u) moveY(-2.5*u) mycube([1.5*u,3.5*u, 1.1*deye/2],chm = 0.3*u);
    
}
translate([5*u,-15*u, z1]) scale(1.5) eye();
translate([-5*u,-15*u, z1]) scale(1.5) eye();

module nose()
{
    rotateX(-90) rotate_extrude() 
    difference()
    {
        union()
        {
            hull()
            {
                circle(r = 7*u);
                moveY(1.5*u) circle(r = 7*u);
            }
            hull()
            {
                moveY(1.5*u) circle(r = 7*u);
                moveY(14*u) circle(r=3*u);
            }
        }
        moveY(-20*u) square(50*u);
    }
}
translate([0,-35*u, z1]) nose();

// neck
yn=68; xn = 4;
translate([-xn, -yn,-z1*0.05]) mycube([2*xn, yn+5*u,z1*.6],chm=2.5);

//collor
translate([0, -yn+14,4]) rotateX(90) 
{
    difference()
    {
        cylinder(h=14, r1 = xn+2,r2 = xn+4);
        translate([0, 1.2*13/sqrt(2), -4]) rotateZ(45) linear_extrude(18,scale=1.6) square(13,center = true);
    }
}

//torso
yt=70*u; xt = 18*u; zt = z1;
module torsoHelper()
{
    hull()
    {
       
        moveZ(zt/2) moveY(-yn) scale([1,0.4,0.67]) sphere(1.3*zt);
        moveZ(zt/2) moveY(-yn-yt) scale([1,0.7,0.85]) sphere(1.3*zt);
    }
}
difference()
{
    torsoHelper();
    moveY(-182) cube(100, center = true);
}
scale([0.9,1,0.9]) intersection()
{
    torsoHelper();
    moveY(-182) cube(100, center = true);
}
// sleeves
hull()
{
    translate([20, -74,9]) rotate([20,90,0]) cylinder(h=13, r = 7);
    translate([15, -73,9]) sphere(7);
}
hull()
{
    translate([-20, -74,9]) rotate([-20,90,180]) cylinder(h = 13, r = 7);
    translate([-15, -73,9]) sphere(7);
}



//hand
module hand()
{
    zh = zt;
    poly = [[xt,-yn], [ 3*xt,-(yn + 0.25*yt)+1], [ 3*xt,-(yn + 0.25*yt)-1],  [xt-2.7*u,-(yn+yt-8*u)], [xt,-(yn+yt- 16*u)],
    [ 3*xt-10*u,-(yn + 0.265*yt)],[xt,-(yn+8*u)]];
    linear_extrude(zh) polygon(poly);
    //linear_extrude_polygon(poly,zh, 5, 0.2);
    difference()
    {
        translate([xt+6, -(yn+yt-10), 0]) cylinder(h=zh, d = 17*u);
        translate([xt+8, -(yn+yt-12), -0.1]) cylinder(h=zh+0.2, d = 13.5*u);
        color("blue") translate([xt+13.5, -(yn+yt-10)-1, -0.1]) rotateZ(-18) cube([2,2,zh+1]);
    }
   
}
hand();
mirror([1,0,0]) hand();

module leg1()
{

    mycube([10, 120, 8], chm=3);
    
    difference()
    {
        moveZ(-5) mycube([30, 12, 8+5], chm=3.5);
        moveZ(-5.5) translate([19, 12, -0.1]) scaleY(0.8) cylinder(h=20.2, d=17);
    }
}

module leg2(){
    mycube([10, 120, 8], chm=3.5);
    difference()
    {
        mycube([10, 12, 30], chm=3.5);
        rotateY(-90) translate([17.5, 12, -0.1]) scaleY(0.7) moveZ(-12) cylinder(h=12.2, d=18);
    }
}

moveZ(-3){
translate([0, -215, 0]) leg1();
mirror([1,0,0]) translate([0, -215, 0]) leg1();

translate([0, -215, 8]) leg2();
mirror([1,0,0]) translate([0, -215, 8]) leg2();
}
}

color("purple") scale(0.5)  all();
