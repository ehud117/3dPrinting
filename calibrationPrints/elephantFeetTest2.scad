epsilon = 0.001;
module box(text = "", x = 0, y = 0)
{
    translate([x, y, 0]) difference()
    {
        cube([10, 10, 4]);
        translate([2.5,2.5,2 + epsilon]) linear_extrude(2) text(text, size = 6);
    }
}

box("A");
box("B", 200);
box("C", 200, 200);
box("D", 0, 200);
box("E", 100, 100);