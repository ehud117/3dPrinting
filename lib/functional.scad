

module moveX(x) { translate([x,0,0]) children();}
module moveY(y) { translate([0,y,0]) children();}
module moveZ(z) { translate([0,0,z]) children();}
module moveXY(x, y) { translate([x,y,0]) children();}

module scaleX(x) { scale([x,1,1]) children();}
module scaleY(y) { scale([1,y,1]) children();}
module scaleZ(z) { scale([1,1,z]) children();}



module rotateX(x) { rotate([x,0,0]) children();}
module rotateY(y) { rotate([0,y,0]) children();}
module rotateZ(z) { rotate([0,0,z]) children();}


epsilon = 0.005;

module torus(rOut, rIn)
{
	rotate_extrude(convexity=10)
		translate([rOut - 0.5 * (rOut - rIn), 0, 0])
		circle(d=rOut-rIn); // TODO: understand why $fn = $fn doesn't work
}

module mycube(xyz, chm = 1)
{
	x = xyz[0];
	y = xyz[1];
	z = xyz[2];
        
    // 3Cubes
    translate([chm,0,0]) cube([x - 2 * chm, y, z - chm]);
    translate([0, chm,0]) cube([x, y - 2 * chm, z - chm]);
    translate([chm, chm,0]) cube([x- 2 * chm, y - 2 * chm, z]);

    // 8 cylinders
    // 4 of the sides
    translate([chm, chm, 0]) cylinder(h = z - chm, r = chm);
    translate([chm, y - chm, 0]) cylinder(h = z - chm, r = chm);
    translate([x - chm, chm, 0]) cylinder(h = z - chm, r = chm);
    translate([x - chm, y - chm, 0]) cylinder(h = z - chm, r = chm);
    // 4 of the top
    translate([chm, chm, z - chm]) rotate([0,90,0]) cylinder(h = x - 2 * chm, r = chm);
    translate([chm, y - chm, z - chm]) rotate([0,90,0]) cylinder(h = x - 2 * chm, r = chm);
    translate([chm, chm, z - chm]) rotate([-90,0,0]) cylinder(h = y - 2 * chm, r = chm);
    translate([x - chm, chm, z - chm]) rotate([-90,0, 0]) cylinder(h = y - 2 * chm, r = chm);
    // 4 spheres
    translate([chm, chm, z - chm]) sphere(chm);
    translate([chm, y - chm, z - chm]) sphere(chm);
    translate([x - chm, chm, z - chm]) sphere(chm);
    translate([x - chm, y - chm, z - chm]) sphere(chm);


}



module _ringNoChampher(h, r, stripWidth)
{
    difference()
    {
        cylinder(h, r = r);
        translate([0,0,-epsilon/2]) cylinder(h + epsilon, r = r - stripWidth);
    }
}
module ring(h, r, stripWidth, chm= 1)
{
	if (chm == 0)
	{
		_ringNoChampher(h, r, stripWidth);
	}
	else
	{
		_ringNoChampher(h, r - chm, stripWidth - 2 * chm);
        _ringNoChampher(h/2, r, stripWidth);
		translate([0,0,chm]) _ringNoChampher(h - 2 * chm, r, stripWidth);
		translate([0,0,h - chm]) torus(r, r - 2 * chm);
		translate([0,0,h - chm]) torus(r - stripWidth + 2 * chm, r - stripWidth);
		
	}
}

module wagonWheel_outerStrip(h, r, stripWidth)
{
	ring(h, r, stripWidth);
}

module wagonWhell_inner(h, innerHoleR, innerStripW, innerBorder)
{
	chm = 1;
    difference()
    {
        union()
        {
            for (i = [0:1:5])
                rotate ([0,0, i * 60]) translate([-innerStripW/2,0,0]) mycube([innerStripW, innerBorder + chm, h]);
            ring(h, innerHoleR + innerStripW, innerStripW);
            _ringNoChampher(h, innerHoleR + innerStripW /2, innerStripW);
        }
        translate([0,0,-epsilon/2]) cylinder(h + epsilon, r = innerHoleR);
    }
}
module wagonWheel(h, r, radialStripW, innerHoleR, innerStripW)
{
	wagonWheel_outerStrip(h, r, radialStripW);
	wagonWhell_inner(h, innerHoleR, innerStripW, r - radialStripW);
}

	

module tappedHole(d, maxD = 200, alpha = 45)
{
    h = 20;
    r2 = h * tan(alpha);
    z = -(d/r2/2 * h);
    
    moveZ(z) intersection() 
    {
        cylinder(h = h, r1 = 0, r2 = r2, $fn=64);
        cylinder(h = h, r = maxD/2, $fn=64);
    }
}

//tappedHole(5,12);
//wagonWheel(5, 45, 8, 30, 5);
//mycube([40,50,20], 10);

//linear_extrude(10, $fn = 5) circle(20,$fn = 10);

module linear_extrude_polygonHelper(polygonP, z1, n1, z2, n2)
{
    polyhedronPoints = [
        for (i = [0: len(polygonP) - 1])
            let (n_m1 = ((i != 0) ? (i-1) : len(polygonP) - 1))
            let (n_p1 = (i != len(polygonP) - 1) ? (i+1) : 0)
            concat(n1 * polygonP[i] + (1-n1)/2 * polygonP[n_m1] + (1-n1)/2 *polygonP[n_p1], z1),
        for (i = [0: len(polygonP) - 1])
            let (n_m1 = ((i != 0) ? (i-1) : len(polygonP) - 1))
            let (n_p1 = (i != len(polygonP) - 1) ? (i+1) : 0)
            concat(n2 * polygonP[i] + (1-n2)/2 * polygonP[n_m1] + (1-n2)/2 *polygonP[n_p1], z2)
    ];
    polyhedronPaths = 
    [
        [ for (i = [0: len(polygonP) - 1]) i],
        [ for (i = [len(polygonP) - 1:-1:0]) i + len(polygonP)],
        for (i = [0: len(polygonP) - 1])

             let (n1 = len(polygonP) + i ) 
            let (n2 = len(polygonP) + (i + 1) % len(polygonP))
            let (n3 = (i + 1) % len(polygonP))
            let (n4 = i)
            [n1, n2, n3, n4] 
    ];    
    polyhedron(polyhedronPoints, polyhedronPaths);
    
}

module linear_extrude_polygon(polygonP, nmbr, chmH, chmX) // , center = false, convexity = 10, twist, slices, scale
{
    linear_extrude_polygonHelper(polygonP, 0, 1, nmbr - chmH, 1);
    linear_extrude_polygonHelper(polygonP, nmbr - chmH, 1, nmbr, chmX);
}
circ = 
   [
        for (i = [0: 90: 359])
            [sin(i), cos(i)]
    ];

//linear_extrude_polygon(30*circ,25, 5,0.5);
linear_extrude_polygon(20*[[0,0],[1,0],[1,1],[0,1]],25, 5,0.5);
