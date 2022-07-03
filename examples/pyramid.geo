// pentahedron example geometry

// Parameters
Lx = 1.0 ;
Ly = 1.0 ;
Lz = 0.5 ;

ms = 10.0 ;
// ---------------------

// Points
Point(1) = {  0,  0,  0, ms} ;
Point(2) = { Lx,  0,  0, ms} ;
Point(3) = { Lx, Ly,  0, ms} ;
Point(4) = { 0,  Ly,  0, ms} ;

Point(5) = { 0.5*Lx, 0.5*Ly,  Lz, ms} ;
// ---------------------

// Lines
Line( 1) = {1, 2};
Line( 2) = {2, 3};
Line( 3) = {3, 4};
Line( 4) = {4, 1};

Line( 11) = {1, 5};
Line( 12) = {2, 5};
Line( 13) = {3, 5};
Line( 14) = {4, 5};
// ---------------------

Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

Curve Loop(2) = {1, 12, -11};
Plane Surface(2) = {2};

Curve Loop(3) = {2, 13, -12};
Plane Surface(3) = {3};

Curve Loop(4) = {3, 14, -13};
Plane Surface(4) = {4};

Curve Loop(5) = {4, 11, -14};
Plane Surface(5) = {5};

Surface Loop(1) = {1,2,3,4,5};
Volume(1) = {1};

Physical Point   ("point_prop_1") = {5};

Physical Surface ("surface_property_1") = {1};
Physical Surface ("surface_property_2") = {3};

Physical Volume  ("volume_property") = {1};

