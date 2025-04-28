
sqrt2 = sqrt(2);
module heartShape(x, h, centerZ = true)
{
	translate([0,x * (sqrt2/2 - 1) / 2, 0])
	union()
	{
		translate([x/2/sqrt2,x/sqrt2/2,0]) cylinder(h = h, r = x/2, center = centerZ);
		translate([-x/2/sqrt2,x/sqrt2/2 ,0]) cylinder(h = h, r = x/2, center = centerZ);      
		rotate([0,0,45]) cube([x,x,h], center = centerZ);
	}   
}

module star(n, r1, r2)
{
	alpha = 360 / n / 2;
	v = [
		for (i = [0: n * 2 - 1])
			let (r = (i % 2 == 0) ? r1 : r2)
			[ r  * cos(alpha * i), r * sin(alpha * i)]
	];
	polygon(v);
}
