use <functional.scad>
golden = 1.618; // the golden ratio.



width = 110;
depth = width / golden;
height = depth / golden;
topRadius = 8 / 100 * width;

mycube([width, depth, height], 8 / 100 * width);

