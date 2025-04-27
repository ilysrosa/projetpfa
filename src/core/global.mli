open Component_defs
(* A module to initialize and retrieve the global state *)
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

val get : unit -> t
val set : t -> unit
