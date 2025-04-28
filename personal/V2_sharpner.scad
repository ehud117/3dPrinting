use <functional.scad>

module op() {children();};


$fn=64;
baseZ = 8;
paperY = 80;
alpha = 18;
paperX = 120;
gap = 2.5;
supportW = 10;
triangleY = 45;
marginY = 2 * gap/tan(alpha);
marginYm = 20;
move = 30;
slot = move + 0.6 * triangleY;


//module all()
//{
//
//
//
//    cube([2 * supportW + paperX, 2 * gap/tan(alpha) + triangleY,baseZ]);
//   
//    translate([0, 2 * gap/tan(alpha), baseZ]) cube([supportW, supportW, gap]);
//    translate([0, 2 * gap/tan(alpha) - supportW + triangleY, baseZ]) cube([supportW, supportW, gap]);
//    translate([supportW + paperX, marginY, baseZ]) cube([supportW, supportW, gap]);
//    translate([supportW + paperX, 2 * gap/tan(alpha) - supportW + triangleY, baseZ]) cube([supportW, supportW, gap]);
//     op()  moveX(2 * supportW + paperX) moveY(marginY) moveZ(gap+baseZ) rotateY(-90) linear_extrude(2 * supportW + paperX) polygon(triangleY/cos(alpha) * [[0,0], [sin(alpha),cos(alpha)], [0, cos(alpha)]]);
//
//
//
//
//} // module all
//
////rotateY(-90) rotateZ(90) all();
//all();


baseX = 2 * supportW + paperX;
baseY = 2 * gap/tan(alpha) + triangleY + slot;
stop = 5;

module slotP()
{
        translate([0,baseY-marginYm, baseZ]) cube([supportW, stop, gap]);
        translate([0,baseY- marginYm  - slot, baseZ]) cube([supportW, slot, gap]);
        translate([0,baseY-marginYm - slot-stop, baseZ]) cube([supportW, stop, gap]);
}
module slotM()
{
    translate([0,baseY- marginYm, baseZ]) rotateX(90) linear_extrude(slot) polygon([[supportW/2,-4], [0, gap], [supportW, gap]]);
}

module base()
{
    difference()
    {
        //     
        union()
        {
            color("lightgreen") cube([baseX, baseY, baseZ]);
            slotP();
            moveX(paperX + supportW) slotP();
        }
        slotM();
        moveX(paperX + supportW) slotM();
    }        
}


module movingPart()
{
       rotateX(90) linear_extrude(2 * supportW + paperX) polygon(triangleY/cos(alpha) * [[0,0], [sin(alpha),0], [0, cos(alpha)]]);
      rotateZ(-90) linear_extrude(slot-move) moveY(-gap) polygon([[supportW/2,-4], [0, gap], [supportW, gap]]);
    moveY(-(paperX+supportW)) rotateZ(-90) linear_extrude(slot-move) moveY(-gap) polygon([[supportW/2,-4], [0, gap], [supportW, gap]]);
    
}

//base();
//moveY(60) moveZ(baseZ+ 10) rotateX(90) rotateZ(90) movingPart();

movingPart();