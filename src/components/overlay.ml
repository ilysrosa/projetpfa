open Component_defs
open System_defs

let overlay () =
  let e = new overlay () in
  let text = "Cc" in
  e#texture#set (Texture.Text text);
  e#position#set Vector.{x = 32.; y = 32.};
  e#box#set Rect.{width = 20; height = 2};
  Draw_system.(register (e :> t));
  e

let set_text() = 
  let Global.{overlay; entityNb; health; _} = Global.get () in
  let txt = Printf.sprintf "Nombre d'entités : %d Hp : %d" entityNb health in
  overlay#texture#set (Texture.Text txt)

  