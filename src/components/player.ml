open Ecs
open Component_defs
open System_defs

type tag += Player

let player (x, y, txt, width, height) =
  let e = new player in
  e#texture#set txt;
  e#tag#set Player;
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width; height};

  (* Rajouter velocity question 7.5 *)
  e#velocity#set Vector.zero;  

  e#resolve#set (fun _ t ->
    match t#tag#get with
    | Platform.Platform (w) | Wall.Wall (w) ->
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
    | _ -> ()
  );

  Draw_system.(register (e :> t));
  Collision_system.(register (e :> t));
  (* Question 7.5 enregistrer auprès du Move_system *)
  Move_system.(register (e:> t));
  e

let players () =  
  player  Cst.(player_x, player_y, player_color, player_width, player_height)


let player () = 
  let Global.{player; _ } = Global.get () in
  player


let stop_players () = 
  let Global.{player; _} = Global.get () in
    player#velocity#set Vector.zero
  (* À remplacer en question 7.5, mettre la vitesse
    à 0 *)

let move_player player v =
  player#velocity#set v
  (* À remplacer en question 7.5, mettre la vitesse
    du joueur à v *)
  