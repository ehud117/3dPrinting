use <functional.scad>
cube([150,15,2]);
moveZ(2)
{
    for (i = [1 : 14])
    {
        moveX(i*10-0.2) cube([0.4,10,1]);
    }
    for (i = [1:9])
    {
        moveX(i-0.2) cube([0.4,(i == 5) ? 5 : 3, 1]);
    }    
}