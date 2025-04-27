open Component_defs

type t = {
  window : Gfx.window;
  ctx : Gfx.context;
  font : Gfx.font;
  overlay : overlay;
  player : player;
  mutable niveau : int;
  mutable time : float;
  mutable waiting : int;
}

let state = ref None

let get () : t =
  match !state with
    None -> failwith "Uninitialized global state"
  | Some s -> s

let set s = state := Some s
