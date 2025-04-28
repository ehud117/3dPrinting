// Function to calculate the unit vector from p1 to p2
function unit_vector(p1, p2) = (p2 - p1) / norm(p2 - p1);

// Function to normalize a vector
function normalize(v) = v / norm(v);

// Function to calculate the direction of the angle bisector
function bisector_direction(A, B, C) = normalize(unit_vector(A, B) + unit_vector(C, B));

// Function to calculate the perpendicular distance from a point to a line
function perpendicular_distance(P, A, B) = abs((B[1] - A[1]) * P[0] - (B[0] - A[0]) * P[1] + B[0] * A[1] - B[1] * A[0]) / norm(B - A);

// Function to calculate the angle of a vector with the X-axis
function angle_with_x_axis(v) = atan2(v[1], v[0]);

// Function to find points D, E, and F, and the required angles
function find_point_D_and_angles(A, B, C, X) = let(
    bisector_dir = bisector_direction(A, B, C),
    scale_factor = X / perpendicular_distance(B + bisector_dir, A, B),
    D = B - scale_factor * bisector_dir,
    // Calculate the direction vector for E (perpendicular to AB)
    dir_perpendicular_AB = normalize([B[1] - A[1], -(B[0] - A[0])]),
    E = D + X * dir_perpendicular_AB,
    // Calculate the direction vector for F (perpendicular to BC)
    dir_perpendicular_BC = normalize([C[1] - B[1], -(C[0] - B[0])]),
    F = D + X * dir_perpendicular_BC,
    angle_DE = angle_with_x_axis(E - D),
    angle_DF = angle_with_x_axis(F - D)
) [D, angle_DE, angle_DF,E];

// Example usage
A = [2, 2];
B = [0, 0];
C = [2, -2];
X = .5;

res = find_point_D_and_angles(A, B, C, X);
echo("full answer:", res);
//echo (res[0] + X*[sin(res[1]), cos(res[1])]);
polygon([A,B,C]);
translate(res[0]) #circle(r=X,$fn=64);
echo ("res3", res[3]);
D = res[0];
E = res[3];
alpha= res[1];
translate(D) color("blue") circle(r=0.1,$fn=64);
translate(E) color("green") circle(r=0.1,$fn=64);

translate(D+X*[cos(alpha), sin(alpha)]) color("red") circle(r=0.1,$fn=64);


