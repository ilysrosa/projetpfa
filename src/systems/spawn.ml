open Ecs
open Component_defs

type t = spawnable

let init _ = ()

let update dt el =
  let Global.{window;ctx;font;overlay;player;entityNb;time;health;waiting;} = Global.get () in
    let glob = Global.{window;ctx;font;overlay;player;entityNb = (List.length (List.of_seq el));time;health;waiting;} in
    Global.set glob;
  Seq.iter (fun (e:t) ->
    let pos = e#position#get in
    if pos.y > float Cst.window_height then
      Entity.delete(e :> t);
  ) el;
