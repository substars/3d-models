// ROG Bulwark Dock (DG310) back-wall shim for the 2023 ROG Ally (RC71L)
// The DG310 cradle is sized for the thicker 2025 model. This shim lines the
// cradle's back wall so the thinner RC71L sits snugly and stays upright.
//
// Coordinates: X = left/right (centered), Y = front/back (0 = bare back wall
// at floor level, +Y toward the front), Z = up.
// Measurements are entered as taken with the pad in place. Widths are to the
// bare plastic; depths from the back wall and heights from the floor are to
// the pad surface. The bare-plastic sizes are worked out below.
// Print orientation: by default the shim is exported lying flat on its back
// face, ready to print. Set print_flat = false to see it as it sits in the dock.

/* [Cradle] */
back_width    = 174;  // width of the back wall at the floor
floor_depth   = 28;   // padded back wall to padded front edge, at floor level

/* [Cradle back wall (front view)] */
wall_h_center = 14;   // wall height in the middle, from the padded floor
wall_h_end    = 10;   // wall height at the ends, from the padded floor
wall_chamfer  = 16;   // horizontal length of the corner slopes
wall_lean     = 4;    // how far the top of the wall leans back over its height
wall_corner_r = 2;    // radius of the rounded top corners (0 = sharp). Bigger is safe.

/* [Pad] */
// The sticky pad lines the cradle (floor, back, front and sides). The back
// pad is a separate piece: it can stay on the wall, or move to the shim's
// front face. Either way it takes up the same space, so the shim is the same.
pad_thickness = 1;

/* [Device] */
ally_depth = 21;      // RC71L thickness where it sits in the cradle

/* [Fit] */
clearance      = 0.5; // gap left at the ends and top so it drops in
fit_gap        = 0.5; // extra front-to-back room for the Ally
liner_override = 0;   // set >0 to force a shim thickness (mm)

/* [Output] */
print_flat = true;    // true = lying on its back face for printing

/* [Hidden] */
$fn = 48;
tilt  = wall_lean / wall_h_center;      // horizontal shift per mm of height
theta = atan(tilt);

// Bare-plastic sizes (measurements above were taken with the pad in place)
depth_bare = floor_depth + 2 * pad_thickness;  // back + front pads
h_ctr_bare = wall_h_center + pad_thickness;    // floor pad
h_end_bare = wall_h_end + pad_thickness;       // floor pad

// Floor, side and front pads stay in the cradle
pad_in = pad_thickness;

// Horizontal footprint of a leaning device of thickness ally_depth
ally_footprint = ally_depth / cos(theta);

// Depth to fill = bare floor depth
//   - back pad (on the wall or on the shim face)
//   - front lip pad
//   - the Ally and its fit gap
liner_t = liner_override > 0 ? liner_override
        : depth_bare - 2 * pad_thickness - ally_footprint - fit_gap;

echo(str("Wall lean angle: ", theta, " deg"));
echo(str("Shim thickness: ", liner_t, " mm"));
assert(liner_t > 0.8, "Shim too thin - check measurements");

// ---- Front-view profile of the back wall, inset by clearance + pad ----
module wall_profile() {
    w  = back_width - 2*(clearance + pad_in);
    // the shim sits on the floor pad, so trim its height to match
    hc = h_ctr_bare - clearance - pad_in;
    he = h_end_bare - clearance - pad_in;
    r  = wall_corner_r;
    // Round the convex corners (offset in, then back out by r). The shape is
    // extended below z=0 first and trimmed after, so only the top corners
    // get rounded and the bottom edge stays square.
    intersection() {
        offset(r = r) offset(delta = -r)
            polygon([
                [-w/2, -r - 1], [w/2, -r - 1],
                [ w/2, he], [ w/2 - wall_chamfer, hc],
                [-w/2 + wall_chamfer, hc], [-w/2, he]
            ]);
        translate([-w/2, 0]) square([w, hc]);
    }
}

// ---- Shim: profile extruded forward, sheared to follow the wall's lean ----
module shim() {
    // Back face shown against the back-wall pad. Since the shim sits on the
    // floor pad, the leaning wall is slightly further back at its base.
    // (With the pad moved to the shim, it simply sits 1mm further back.)
    y0 = pad_in - tilt * pad_in;
    // shear: y shifts back by `tilt` per mm of z
    multmatrix([[1, 0, 0,     0],
                [0, 1, -tilt, y0],
                [0, 0, 1,     0]])
        // profile lives in XZ; extrude along +Y by shim thickness
        rotate([90, 0, 0]) translate([0, 0, -liner_t])
            linear_extrude(liner_t) wall_profile();
}

// Lay flat: rotate about X until the back face points straight down, then
// drop that face onto the bed (z = 0).
module print_ready() {
    y0 = pad_in - tilt * pad_in;
    a  = 90 - theta;
    translate([0, 0, -y0 * sin(a)]) rotate([a, 0, 0]) shim();
}

if (print_flat) print_ready(); else shim();
