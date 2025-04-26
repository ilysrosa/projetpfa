open Component_defs
open System_defs

type tag += Platform of platform

let platform (x, y, txt, width, height) =
  let e = new platform () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (Platform e);
  e#box#set Rect.{width; height};
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  e

let platforms () = 
  List.map platform
    Cst.[ 
      (plat1_x, plat1_y, plat_color, plat_width, plat_height);
      (plat2_x, plat2_y, plat_color, plat_width, plat_height);
      (plat3_x, plat1_y, plat_color, plat_width, plat_height);
    ]