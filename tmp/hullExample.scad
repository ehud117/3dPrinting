hull(){
cylinder(10, d = 10, $fn =32);
translate([0,0,20]) cube([8, 4, 1], center = true);
}
translate([0,0,20]) cube([8, 4, 20], center = true);
