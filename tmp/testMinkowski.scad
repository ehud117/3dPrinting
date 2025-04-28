$fn =64;
minkowski(){
    cube(10);
    intersection() { sphere(1); translate([-1,-1,0]) cube(2);}
}