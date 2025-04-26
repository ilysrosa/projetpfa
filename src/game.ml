open System_defs
open Component_defs

let update dt =
  let () = Player.stop_players () in
  let () = Input.handle_input () in
  (*let () = Projectile.spawn () in*)
  let () = Overlay.set_text() in
  Move_system.update dt;
  Spawn_system.update dt;
  Collision_system.update dt;
  Draw_system.update dt;
  None

let run () =
  let window_spec = 
    Format.sprintf "game_canvas:%dx%d:"
      Cst.window_width Cst.window_height
  in
  let window = Gfx.create  window_spec in
  let ctx = Gfx.get_context window in
  let font = Gfx.load_font Cst.font_name "" 128 in
  let _walls = Wall.walls () in
  let _platforms = Platform.platforms () in
  let player = Player.players () in
  let overlay = Overlay.overlay () in
  let global = Global.{ window; ctx; font; overlay; player; entityNb = 0; time = 0.; health = 3; waiting = 1; } in
  Global.set global;
  Gfx.main_loop update (fun () -> ())
