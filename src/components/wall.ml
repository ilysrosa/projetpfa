open Component_defs
open System_defs

type tag += Wall of wall | Soft of wall | Hard of wall | Exit of wall

let wall (x, y, txt, width, height, cat) =
  let e = new wall () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#tag#set (match cat with
    | 1 -> (Soft e)
    | 2 -> (Hard e)
    | 3 -> (Exit e)
    | _ -> (Wall e)
  );
  e#box#set Rect.{width; height};
  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  e

let walls () = 
  List.map wall
    Cst.[ 
      (hwall1_x, hwall1_y, hwall_color, hwall_width, hwall_height, 0);
      (hwall2_x, hwall2_y, hwall_color, hwall_width, hwall_height, 0);
      (vwall1_x, vwall1_y, vwall_color, vwall_width, vwall_height, 0);
      (vwall2_x, vwall2_y, vwall_color, vwall_width, vwall_height, 0);
      (soft1_x, soft1_y, soft_color, soft1_w, soft1_h, 1);
      (soft2_x, soft2_y, soft_color, soft2_w, soft2_h, 1);
      (hard1_x, hard1_y, hard_c, hard_w, hard_h, 2);
      (hard2_x, hard2_y, hard_c, hard_w, hard_h, 2);
      (hard3_x, hard3_y, hard_c, hard_w, hard_h, 2);
      (hard4_x, hard4_y, hard_c, hard_w, hard_h, 2);
      (soft3_x, soft3_y, soft_color, soft_sq, soft_sq, 1);
      (soft4_x, soft4_y, soft_color, soft_sq, soft_sq, 1);
      (soft5_x, soft5_y, soft_color, soft_sq, soft_sq, 1);
      (exit_x, exit_y, exit_color, exit_w, exit_h, 3);
    ]
