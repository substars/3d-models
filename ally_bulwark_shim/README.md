# ROG Bulwark Dock Shim for the 2023 ROG Ally

A 3D-printable shim that lets the original **2023 ROG Ally (RC71L)** stand upright in the **ROG Bulwark Dock (DG310)**.

## The problem

The Bulwark Dock's cradle is sized for the newer, thicker 2025 Ally. The 2023 model is about 21mm deep where it sits in the cradle, which leaves too much room front to back, so it falls over.

## The fix

The shim lines the cradle's back wall and takes up the extra space. It matches the wall's shape (15mm tall in the middle, 11mm at the ends, sloped and rounded top corners) and leans back about 16° with it, so the Ally still leans the way the dock intended.

There's no floor piece. The cradle floor isn't flat, so the shim stands on its bottom edge against the back wall, and the Ally's weight holds it in place.

## The pad

The dock's cradle is lined with a 1mm sticky pad. The back-wall pad is a separate piece from the floor, front and side pads, so you have two ways to install the shim. Both use the same `shim.stl`:

- **Back pad on the shim (recommended):** peel the back pad off the wall and stick the shim's back to the adhesive left on the wall. Then stick the back pad on the shim's front face, so the Ally rests on the soft pad.
- **Back pad left on the wall:** set the shim against the pad. Put double-sided tape on the shim's back to hold it in place.

The shim is the same either way because the back pad takes up the same 1mm whether it's behind the shim or in front of it.

## Files

| File | What it is |
|---|---|
| `shim.stl` | The shim, ready to slice (~5.7mm thick) |
| `ally_bulwark_shim.scad` | Parametric OpenSCAD source. Edit this to adjust the fit. |

## Printing

- **Orientation:** `shim.stl` is already lying flat on its back face, so just import it and slice. That gives a big flat contact area and no overhangs. To see the shim the way it sits in the dock instead, set `print_flat = false` in the `.scad` file.
- **Material:** I used PLA, but PETG or TPU might grip the dock better than PLA.

## Adjusting the fit

Open the `.scad` file in OpenSCAD and change the parameters at the top, or use **Window → Customizer**. Render with F6 and export with F7.

| Parameter | Default | What it does |
|---|---|---|
| `pad_thickness` | `1` | Thickness of the dock's pad, or whatever you replace it with |
| `liner_override` | `0` | Force a shim thickness in mm. Increase if the Ally still wobbles; decrease if it's too tight. `0` = calculate automatically. |
| `fit_gap` | `0.5` | Extra front-to-back room for the Ally |
| `clearance` | `0.5` | Gap left at the ends and top so the shim drops in |
| `wall_corner_r` | `2` | Radius of the rounded top corners |
| `print_flat` | `true` | `true` = export lying flat for printing; `false` = upright, as it sits in the dock |

The corner radius only removes material, so guessing too big is safe: it just leaves a small gap. To estimate it, hold drill bits against the corner and find the closest match (radius = half the bit diameter).

### How the shim thickness is calculated

A 21mm-thick Ally leaning ~16° takes up about 21.85mm of floor depth. With a 30mm-deep floor (bare plastic, 28mm with the pad):

```
30 − 1 (back pad) − 1 (front pad) − 21.85 (Ally) − 0.5 (fit gap) ≈ 5.7mm
```

## Tips

- **Tape on the back:** even if you stick the shim to the leftover adhesive on the wall, a strip of thin double-sided tape on the shim's back is a good idea. Old adhesive often doesn't hold well a second time, and the shim has nothing else keeping it in place when the Ally is out.
- **Back pad won't stick to the shim:** thin felt or adhesive cork (~1mm) works as a replacement; set `pad_thickness` to match.
- **Shim binds going in:** increase `clearance` to `0.7`.

## Dock measurements used

These are entered in the `.scad` file as measured with the pad in place. The file adds the pad back to get the bare-plastic sizes, so if your pad is a different thickness, change `pad_thickness` and everything adjusts.

| Measurement | As measured (with pad) | Bare plastic |
|---|---|---|
| Back wall width at the floor | 174mm | 174mm |
| Floor depth (back wall to front edge) | 28mm | 30mm |
| Back wall height, middle | 14mm | 15mm |
| Back wall height, ends | 10mm | 11mm |
| Back wall sloped corners | 16mm | 16mm |
| Back wall lean | 4mm over 14mm (~16°) | same |
| Pad lining the cradle | 1mm | — |
| Ally (RC71L) depth in cradle | 21mm | — |
