open Component_defs
open System_defs

let overlay () =
  let e = new overlay () in
  let text = "" in
  e#texture#set (Texture.Text text);
  e#position#set Vector.{x = 10.; y = 10.};
  e#box#set Rect.{width = 20; height = 4};
  Draw_system.(register (e :> t));
  e

let set_text() = 
  let Global.{overlay; niveau; time; player; _} = Global.get () in
  let txt = Printf.sprintf "Niveau : %d    Hp : %d    time : %.1f" niveau (player#hp#get) (time/.1000.) in
  overlay#texture#set (Texture.Text txt)

(*open Component_defs
open System_defs

type tag += Lvl of overlay | Hp of overlay | Time of overlay

let c_overlay (x, y, s, cat) =
  let e = new overlay () in
  e#tag#set (match cat with
    | 1 -> (Hp e)
    | 2 -> (Time e)
    | _ -> (Lvl e)
  );
  e#texture#set (Texture.Text s);
  e#position#set Vector.{x = float x; y = float y};
  e#box#set Rect.{width = 20; height = 4};
  Draw_system.(register (e :> t));
  e

let overlays () = 
  let Global.{overlay; niveau; time; player; _} = Global.get () in
  let s1 = Printf.sprintf "Niveau : %d" niveau in
  let s2 = Printf.sprintf "Hp : %d" (player#hp#get) in
  let s3 = Printf.sprintf "time : %.2f" (time/.1000.) in
  List.map c_overlay
    Cst.[
      (ov_x, ov1_y, s1, 0);
      (ov_x, ov2_y, s2, 1);
      (ov_x, ov3_y, s3, 2);
    ]

let update () =
  let Global.{overlay; niveau; time; player; _} = Global.get () in
  let s1 = Printf.sprintf "Niveau : %d" niveau in
  let s2 = Printf.sprintf "Hp : %d" (player#hp#get) in
  let s3 = Printf.sprintf "time : %.2f" (time/.1000.) in
  List.iter (fun e -> match e#tag#get with
    | Lvl e -> e#texture#set (Texture.Text s1)
    | Hp e -> e#texture#set (Texture.Text s2)
    | Time e -> e#texture#set (Texture.Text s3)
    | _ -> ();
    ) overlay;
  
  *)
  