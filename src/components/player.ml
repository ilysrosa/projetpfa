open Ecs
open Component_defs
open System_defs

type tag += Player of player

let timer = ref 0.

let player (x, y, txt, width, height) =
  let e = new player in
  e#texture#set txt;
  e#tag#set (Player e);
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};

  (* Rajouter velocity question 7.5 *)
  e#velocity#set Vector.zero;
  e#hp#set 3;
  e#target#set true;  

  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Wall.Wall (w) | Wall.Hard (w) ->
        let e_pos = e#position#get in
        let e_box = e#box#get in
        let w_pos = w#position#get in
        let w_box = w#box#get in
        let mdiff_pos, mdiff_rect = Rect.mdiff e_pos e_box w_pos w_box in
        if Rect.has_origin mdiff_pos mdiff_rect then begin
          let correction = Rect.penetration_vector mdiff_pos mdiff_rect in
          let corrected_pos = Vector.sub e_pos correction in
          e#position#set corrected_pos
        end;
    | Wall.Exit (w) -> 
      let global = Global.get () in
      global.waiting <- 0;
    | _ -> ()
  );

  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  (* Question 7.5 enregistrer auprès du Move_system *)
  Move_system.(register (e:> t));
  e

let players () =  
  player  Cst.(player_x, player_y, player_up_color, player_width, player_height)

let player_update () = 
  let Global.{player;time;_} = Global.get () in
    player#velocity#set Vector.zero;
  if not player#target#get && (time -. !timer > Cst.untargettable) then begin
    player#target#set true;
    player#texture#set Cst.player_up_color;
  end
    
  (* À remplacer en question 7.5, mettre la vitesse
    à 0 *)

let move_player v =
  let Global.{player; _} = Global.get () in
    player#velocity#set v
  (* À remplacer en question 7.5, mettre la vitesse
    du joueur à v *)
  