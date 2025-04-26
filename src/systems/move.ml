open Ecs
open Component_defs

type t = movable

let init _ = ()

let update _ el =
    Seq.iter (fun (e:t) ->
      let vel = e#velocity#get in
      let pos = e#position#get in
      e#position#set (Vector.add vel pos)
    ) el;
