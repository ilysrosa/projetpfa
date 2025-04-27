type t =
    Image of Gfx.surface
  | Color of Gfx.color
  | Text of string

let black = Color (Gfx.color 0 0 0 255)
let grey = Color (Gfx.color 192 192 192 255)
let white = Color (Gfx.color 255 255 255 255)
let red = Color (Gfx.color 255 0 0 255)
let green = Color (Gfx.color 0 255 0 255)
let blue = Color (Gfx.color 0 0 255 255)

let yellow = Color (Gfx.color 255 255 0 128)
let transparent = Color (Gfx.color 0 0 0 0)

let draw ctx dst pos box src font =
  let x = int_of_float pos.Vector.x in
  let y = int_of_float pos.Vector.y in
  let Rect.{width;height} = box in
  match src with
  | Text t ->
    Gfx.set_color ctx (Gfx.color 255 255 255 255);
    let rend = Gfx.render_text ctx t font in
    let w,h = Gfx.measure_text t font in
    Gfx.blit_scale ctx dst rend x y (w/6) (h/6)
  | Image img ->
    Gfx.blit_scale ctx dst img x y width height
  | Color c ->
    Gfx.set_color ctx c;
    Gfx.fill_rect ctx dst x y width height
