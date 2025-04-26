(*
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
V                               V
V  1                         2  V
V  1 B                       2  V
V  1                         2  V
V  1                         2  V
V                               V
HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
*)


let window_width = 800
let window_height = 600

let player_width = 16
let player_height = 16
let player_color = Texture.blue

let player_x = (window_width / 2) - (player_width / 2)
let player_y = window_height - player_height - 40

let plat_width = 120
let plat_height = 4
let plat_color = Texture.black

let plat1_x = window_width / 4 - plat_width / 2
let plat1_y = 3 * window_height / 4

let plat2_x = window_width / 2 - plat_width / 2
let plat2_y = window_height / 2

let plat3_x = (3*window_width / 4 ) - plat_width / 2
let plat3_y = plat1_y

let player_left = Vector.{ x = -4.0; y = 0.0 }
let player_right = Vector.sub Vector.zero player_left
let player_up = Vector.{ x = 0.0; y = -4.0 }
let player_down = Vector.sub Vector.zero player_up

let proj_w = 6
let proj_h = 24
let proj_fall = Vector.{x = 0.0; y = 12.0}
let proj_color = Texture.red

let cooldown = 0.3

let wall_thickness = 32

let hwall_width = window_width
let hwall_height = wall_thickness
let hwall1_x = 0
let hwall1_y = 0
let hwall2_x = 0
let hwall2_y = window_height -  wall_thickness
let hwall_color = Texture.green

let vwall_width = wall_thickness
let vwall_height = window_height - 2 * wall_thickness
let vwall1_x = 0
let vwall1_y = wall_thickness
let vwall2_x = window_width - wall_thickness
let vwall2_y = vwall1_y
let vwall_color = Texture.yellow

let font_name = if Gfx.backend = "js" then "monospace" else "resources/images/monospace.ttf"
let font_color = Gfx.color 0 0 0 255
