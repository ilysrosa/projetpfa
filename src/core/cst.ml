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
let player_up_color = Texture.blue
let player_down_color = Texture.grey

let player_x = (window_width / 16) - (player_width)
let player_y = (window_height / 2) - (player_height / 2)

let player_left = Vector.{ x = -2.0; y = 0.0 }
let player_right = Vector.sub Vector.zero player_left
let player_up = Vector.{ x = 0.0; y = -2.0 }
let player_down = Vector.sub Vector.zero player_up

let untargettable = 1500.

let proj_size = 20
let proj_speed = 2
let proj_x = 300
let proj_y = 400
let proj_color = Texture.red

let ov_x = 10
let ov1_y = 10
let ov2_y = 30
let ov3_y = 50

let hwall_thickness = 100
let vwall_thickness = 8
let soft_thickness = 60

let hwall_width = window_width
let hwall_height = hwall_thickness
let hwall1_x = 0
let hwall1_y = 0
let hwall2_x = 0
let hwall2_y = window_height -  hwall_thickness
let hwall_color = Texture.black

let vwall_width = vwall_thickness
let vwall_height = window_height - 2 * hwall_thickness
let vwall1_x = 0
let vwall1_y = hwall_thickness
let vwall2_x = window_width - vwall_thickness
let vwall2_y = vwall1_y
let vwall_color = Texture.black

let exit_w = 16

let soft1_x = vwall_width
let soft1_y = hwall_thickness
let soft1_w = soft_thickness
let soft1_h = vwall_height
let soft2_x = vwall2_x - soft_thickness
let soft2_y = soft1_y
let soft2_w = soft1_w - exit_w
let soft2_h = soft1_h
let soft_color = Texture.yellow

let exit_x = soft2_x + soft2_w
let exit_y = soft2_y
let exit_h = soft2_h
let exit_color = Texture.green

let hard_w = 4
let hard_h = 200
let hard_c = Texture.black

let hard1_x = (( 800 - 136 ) / 5 ) + 68
let hard1_y = hwall2_y - hard_h

let hard2_x = (2* ( 800 - 136 ) / 5 ) + 68
let hard2_y = hwall_height

let hard3_x = (3* ( 800 - 136 ) / 5 ) + 68
let hard3_y = hard1_y

let hard4_x = (4* ( 800 - 136 ) / 5 ) + 68
let hard4_y = hard2_y

let soft_sq = 40
let soft3_x = hard2_x - soft_sq
let soft3_y = hard2_y

let soft4_x = hard3_x - soft_sq
let soft4_y = hard3_y + hard_h - soft_sq

let soft5_x = hard4_x - soft_sq
let soft5_y = hard4_y

let font_name = if Gfx.backend = "js" then "monospace" else "resources/images/monospace.ttf"
let font_color = Gfx.color 0 0 0 255
