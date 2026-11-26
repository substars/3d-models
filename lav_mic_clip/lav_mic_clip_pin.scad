// Pin-mounted spring clip for IVANKY lavalier transmitters
// Reuses the original hinge posts + pin. No metal spring: a flat PETG leaf
// is the spring. A block between the posts carries the pin and butts against
// the small square nub, so the clip can't rotate.
//
// Frame (as designed): x = across mic, y = along mic (+ toward charging pins),
// z = up from the back surface. Origin = pin axis projected onto the surface.
//
// PRINT: exported upside down -- the flat top of the leaf sits on the bed.
// No supports. PETG, 100% infill. The leaf is printed flat, which is the
// strong direction for a leaf spring.
//
// ---- MEASURE THESE (calipers) ----
pin_d      = 1.2;   // diameter of the original pin
pin_z      = 1.5;   // height of pin CENTER above the back surface
post_h     = 3.5;   // how far the posts stick up from the back surface
post_gap   = 4.0;   // gap between the posts (measured)
post_y1    = 1.6;   // pin center -> lower end of posts (toward charging pins)
nub_y      = -1.7;  // pin center -> lower face of the little square nub (negative = toward top)
// -----------------------------------

pin_clear  = 0.25;  // hole oversize so the pin turns/slides in
side_clear = 0.15;  // per side, block vs posts
leaf_w     = 11.8;    // body is 18 wide, clip slot is 12.2 mm
leaf_t     = 0.96;   // leaf thickness: thicker = stronger grip, but more strain
over_clear = 0.4;   // leaf clearance above post tops
top_y      = -4.0;  // leaf extends this far toward the top (cosmetic cover)
block_end  = post_y1 - 0.2; // block fills the whole post gap; leaf flexes from here to the pad
fillet     = 1.0;   // wedge where block meets leaf (+y / -y faces)
tip_y      = 15.0;  // leaf end (stays just above the slot at ~16.5)
pad_len    = 2.0;   // contact pad length along y
preload    = 0.30;   // pad reaches this far "into" the body -> clamping force

$fn = 48;

zb      = post_h + over_clear;   // underside of leaf
block_w = post_gap - 2 * side_clear;

module block() {
    y0 = nub_y + 0.2;
    difference() {
        union() {
            translate([-block_w / 2, y0, 0])
                cube([block_w, block_end - y0, zb + 0.01]);
            // fillets: block -> leaf, both ends (stays narrow so it clears posts)
            for (e = [[block_end, 1], [y0, -1]])
                translate([block_w / 2, e[0], zb + 0.01]) rotate([0, -90, 0])
                    linear_extrude(block_w)
                        polygon([[0, 0], [0, e[1] * fillet], [-fillet, 0]]);
        }
        translate([0, 0, pin_z])
            rotate([0, 90, 0]) cylinder(d = pin_d + pin_clear, h = 10, center = true);
    }
}

module leaf() {
    translate([-leaf_w / 2, top_y, zb]) cube([leaf_w, tip_y - top_y, leaf_t]);
}

module pad() {
    // hangs from leaf tip down to -preload; chamfered on the tip side so
    // fabric slides in, gentle round on the inner side
    h = zb + preload;
    translate([leaf_w / 2, 0, 0]) rotate([0, -90, 0])
    linear_extrude(leaf_w)
        // 2D in (z, y)
        polygon([
            [zb + 0.01, tip_y - pad_len],
            [zb + 0.01, tip_y],
            [-preload + 1.2, tip_y],          // chamfer start
            [-preload, tip_y - 1.2],          // contact edge
            [-preload, tip_y - pad_len + 0.4],
            [-preload + 0.4, tip_y - pad_len],
        ]);
}

module clip() {
    union() { block(); leaf(); pad(); }
}

// print orientation: leaf top face on bed
translate([0, 0, zb + leaf_t]) rotate([180, 0, 0]) clip();
