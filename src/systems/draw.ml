open Ecs
open Component_defs

type t = drawable

let init _ = ()

let white = Gfx.color 255 255 255 255

let update _dt el =
  let Global.{window;ctx;font;overlay;player;_} = Global.get () in
  let surface = Gfx.get_surface window in
  let ww, wh = Gfx.get_context_logical_size ctx in
  Gfx.set_color ctx white;
  Gfx.fill_rect ctx surface 0 0 ww wh;
  Seq.iter (fun (e:t) ->
      let pos = e#position#get in
      let box = e#box#get in
      let txt = e#texture#get in
      Texture.draw ctx surface pos box txt font
    ) el;
  Texture.draw ctx surface (player#position#get) (player#box#get) (player#texture#get) font;
  Texture.draw ctx surface (overlay#position#get) (overlay#box#get) (overlay#texture#get) font;
  Gfx.commit ctx