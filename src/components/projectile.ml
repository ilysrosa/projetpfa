open Ecs
open Component_defs
open System_defs

type tag += Projectile

let random_v () =
  let a = Random.float (Float.pi/.2.0) -. (Float.pi /. 4.0) in
  let v = Vector.{x = cos a; y = sin a} in
  let v = Vector.mult (float Cst.proj_speed) (Vector.normalize v) in
  v

let random_x () =
  let a = (Random.int Cst.(window_width - (2 * vwall_width))) +  Cst.vwall_width in
  a

let random_y () = 
  let a = (Random.int Cst.(window_height - (2 * hwall_height))) + Cst.hwall_height in
  a

let projectile (x, y, txt, width, height) =
  let e = new projectile () in
  e#texture#set txt;
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};
  let v = random_v () in
    e#velocity#set v;

  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Player.Player (w) ->
      let global = Global.get () in
      if w#target#get then begin
        if w#hp#get > 1 then begin
          w#hp#set (w#hp#get - 1);
          w#target#set false;
          w#texture#set Cst.player_down_color;
          Player.timer := global.time;
        end else begin
          w#hp#set 0;
          global.waiting <- 0;
        end
      end
    | Wall.Wall (w) | Wall.Soft (w) ->
      let e_pos = e#position#get in
        let e_box = e#box#get in
        let w_pos = w#position#get in
        let w_box = w#box#get in
        let mdiff_pos, mdiff_rect = Rect.mdiff e_pos e_box w_pos w_box in
        if Rect.has_origin mdiff_pos mdiff_rect then begin
          let correction = Rect.penetration_vector mdiff_pos mdiff_rect in
          let corrected_pos = Vector.sub e_pos correction in
          e#position#set corrected_pos;

          let old_v = e#velocity#get in
          let new_v =
            if abs_float correction.x > abs_float correction.y then
              Vector.{ old_v with x = -. old_v.x }
            else
              Vector.{ old_v with y = -. old_v.y }
          in
          e#velocity#set new_v;

        end;
    | _ -> ()
    );

  Draw_system.(register (e :>t));
  Collision_system.(register (e :> t));
  Move_system.(register (e:> t));
  e

let projectiles () =
  List.map projectile
    Cst.[
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
      (random_x (), random_y (), proj_color, proj_size, proj_size);
    ]


 