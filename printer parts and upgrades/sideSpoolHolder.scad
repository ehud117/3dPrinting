use <functional.scad>

widthPillar = 18;
widthBase = 70;
$fn=128;

module pillarShape(width)
{
    rotate([90,0,0]) linear_extrude(width) union() {
        polygon([
        [-50, 0],
        [-13, 20],
        [-13, 180],
        [-5, 180],
        [-3,165],
        [3,165],
        [5, 180],
        [13, 180],
        [13, 20],
        [50, 0]
        ]);
        difference(){
            square([30 , 40]);
            translate([45,40]) circle(33);
        }
        mirror([1,0]) difference(){
            square([30 , 40]);
            translate([45,40]) circle(33);
        }

    }
}
module pillar() {
    pillarShape(widthPillar);
}
module base() 
{
    difference()
    {
        intersection()
        {
            union()
            {
                
                translate([-50, 0,0]) cube([2*50,widthBase,20]);
                difference()
                {
                    translate([-50, 0,20]) cube([2*50,15,15]);
                    translate([-51,15,35]) rotate([0,90,0]) cylinder(102, r = 15, $fn=64);
                }
                difference()
                {
                    translate([-50, widthBase -15,20]) cube([2*50,15,15]);
                    translate([-51,widthBase -15,35]) rotate([0,90,0]) cylinder(102, r = 15);
                }

            }
            translate([0,widthBase,0]) pillarShape(widthBase);
        }
        translate([0, widthBase/2,-0.01]) scale([1.25,1,1]) cylinder(h = 30, r = 28);
    }
    
}
module pillarShape_V2(width)
{
    difference(){
        moveZ(65) moveY(-width/2) scaleX(1.3) cylinder(180 - 65, r = width/2);
        rotate([90,0,0]) linear_extrude(width) polygon([
            [-5,181], [-3,165], [3,165], [5,181]]);
    }
    hull(){
        
            
        moveZ(65) moveY(-width/2) scaleX(1.3) cylinder(1, r = width/2);
        moveZ(40) moveY(-width) moveX(-12) cube([24, width, 1]);
    }
    rotate([90,0,0]) linear_extrude(width) union() {
        polygon([
        [-50, 0],
        [-13, 20],
//        [-13, 160],
//        [-5, 160],
//        [-3,145],
//        [3,145],
//        [5, 160],
//        [13, 160],
        [13, 20],
        [50, 0]
        ]);
        difference(){
            square([30 , 40]);
            translate([45,40]) circle(33);
        }
        mirror([1,0]) difference(){
            square([30 , 40]);
            translate([45,40]) circle(33);
        }

    
    }
}
module pillar_V2() {
    pillarShape_V2(widthPillar);
}

module stand()
{
    pillar_V2();
    base();
    translate([0,widthBase + widthPillar,0]) pillar_V2();
}
//stand();

//linear_extrude(15, scale = 1/0.9) star(16, 8.4*0.9, 6.5*0.9);
//translate([0,0,15]) linear_extrude(25) star(16, 8.4, 6.5);
//translate([0,0,15+25]) linear_extrude(15,scale=0.9) star(16, 8.4, 6.5);




rotateZ(180) stand();


