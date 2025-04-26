open Ecs
open Component_defs
open System_defs

type tag += Projectile

let last_spawn_time = ref 0.0

let projectile () =
  let e = new projectile () in
  e#texture#set Cst.proj_color;
  e#position#set Vector.{x = (float Cst.vwall_width) +. Random.float ((float Cst.window_width) -. (2.*. (float Cst.vwall_width)) -. (float Cst.proj_w) );  y = 0.};
  e#box#set Rect.{width = Cst.proj_w; height = Cst.proj_h};
  
  e#velocity#set Cst.proj_fall;

  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Player.Player -> 
        Entity.(delete ( e:> t ));
        let Global.{window;ctx;font;overlay;player;entityNb;time;health;waiting;} = Global.get () in
          let glob = Global.{window;ctx;font;overlay;player;entityNb;time;health = health - 1;waiting;} in
          Global.set glob;
    | _ -> ()
    );

  Draw_system.(register (e :>t));
  Collision_system.(register (e :> t));
  Move_system.(register (e:> t));
  Spawn_system.(register (e :>t));
  e

let spawn () =
  let now = Sys.time () in
  if now -. !last_spawn_time >= Cst.cooldown then begin
    ignore (projectile ());
    last_spawn_time := now
  end