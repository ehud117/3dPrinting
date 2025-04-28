
d = 22.5;

linear_extrude(3)
difference()
{
    circle(d=d, $fn=128);
    text(str(d), size = 7, font = "David", halign="center", valign="center");
}



