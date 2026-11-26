# Lavalier Microphone Clip for the IVANKY Lav Mic

This is a 3D-printable replacement clip for the
[IVANKY lavalier microphone](https://www.amazon.com/dp/B0F8Q3C11Z?th=1).
It mounts on the microphone's original hinge posts and pin, replacing the
folding clip body with a printable spring clip.

The clip is spring-loaded by a thin PETG leaf rather than a metal spring.
Its block assembly rides on the original pin and is prevented from rotating
by the microphone's existing square nub.

## Files

| File | What it is |
|---|---|
| `lav_mic_clip_pin.3mf` | Ready-to-print 3MF model |
| `lav_mic_clip_pin.stl` | Ready-to-print STL model |
| `lav_mic_clip_pin.scad` | Parametric OpenSCAD source |

## Printing

- **Material:** PETG
- **Infill:** 100%
- **Supports:** None
- **Orientation:** Import the STL or 3MF as provided. It is positioned upside down so the flat leaf spring sits on the build plate.

Printing the leaf flat keeps the flat PETG section aligned with the print
layers, making it suitable as a leaf spring. A flexible filament is not
required.

## Assembly

1. Remove the original clip body while keeping the original pin and hinge posts.
2. Slide the printed block over the hinge posts and align its hole with the pin.
3. Reinstall the original pin.
4. Confirm that the pin turns or slides with the clearance provided in the design.
5. Route fabric into the gap behind the clip pad.

The printed block should bottom against the posts and square nub instead of
rotating around the pin.

## Fit adjustment

The `lav_mic_clip_pin.scad` file contains the measured dimensions of the
microphone's hinge at the top. Open it in OpenSCAD and adjust these values
if your microphone differs or a fresh print needs more clearance:

| Parameter | Default | Purpose |
|---|---|---|
| `pin_d` | `1.2 mm` | Original pin diameter |
| `pin_z` | `1.5 mm` | Pin-center height above the back surface |
| `post_h` | `3.5 mm` | Post height |
| `post_gap` | `4.0 mm` | Gap between posts |
| `post_y1` | `1.6 mm` | Distance from the pin to the lower end of the posts |
| `nub_y` | `-1.7 mm` | Position of the square nub |
| `leaf_t` | `0.96 mm` | Leaf-spring thickness |
| `preload` | `0.30 mm` | How far the pad is forced into the grip position |

Measure the pin and posts with calipers before changing fit values. The
generated STL and 3MF have been exported in the print orientation.
