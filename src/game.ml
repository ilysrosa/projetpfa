open System_defs
open Component_defs

let update dt =
  let global = Global.get () in
  global.time <- dt;
  if global.waiting = 1 then begin
    let () = Player.player_update () in
    let () = Input.handle_input () in
    let () = Overlay.set_text() in
    Move_system.update dt;
    Collision_system.update dt;
    Draw_system.update dt;
    None
  end else Some (global.player#hp#get)

let win () =
  let global = Global.get () in
  let ctx = global.ctx in
  let surface = Gfx.get_surface global.window in
  let font = global.font in
  Gfx.set_color ctx (Gfx.color 0 0 0 255); (* noir *)
  Gfx.fill_rect ctx surface 0 0 Cst.window_width Cst.window_height;
  Gfx.set_color ctx (Gfx.color 255 255 255 255); (* blanc *)
  let win_txt = Printf.sprintf "Victoire !" in
  let win2_txt = Printf.sprintf "Hp: %d Time: %.1f" global.player#hp#get ((global.time)/.1000.) in
  let rend = Gfx.render_text ctx win_txt font in
  let rend2 = Gfx.render_text ctx win2_txt font in
  let w,h = Gfx.measure_text win_txt font in
  let w2,h2 = Gfx.measure_text win2_txt font in
  Gfx.blit_scale ctx surface rend 240 120 (w/2) (h/2);
  Gfx.blit_scale ctx surface rend2 120 (120 + (h/2) + 60) (w2/2) (h2/2);
  Gfx.commit ctx

let loss () =
  let global = Global.get () in
  let ctx = global.ctx in
  let surface = Gfx.get_surface global.window in
  let font = global.font in
  Gfx.set_color ctx (Gfx.color 0 0 0 255); (* noir *)
  Gfx.fill_rect ctx surface 0 0 Cst.window_width Cst.window_height;
  Gfx.set_color ctx (Gfx.color 255 0 0 255); (* rouge *)
  let loss_txt = Printf.sprintf "Défaite.." in
  let loss2_txt = Printf.sprintf "Lvl: %d Time: %.1f" global.niveau ((global.time) /.1000.) in
  let rend = Gfx.render_text ctx loss_txt font in
  let rend2 = Gfx.render_text ctx loss2_txt font in
  let w,h = Gfx.measure_text loss_txt font in
  let w2,h2 = Gfx.measure_text loss2_txt font in
  Gfx.blit_scale ctx surface rend 240 120 (w/2) (h/2);
  Gfx.blit_scale ctx surface rend2 120 (120+(h/2) + 60) (w2/2) (h2/2);
  Gfx.commit ctx

let run () =
  let window_spec = 
    Format.sprintf "game_canvas:%dx%d:"
      Cst.window_width Cst.window_height
  in
  let window = Gfx.create  window_spec in
  let ctx = Gfx.get_context window in
  let font = Gfx.load_font Cst.font_name "" 128 in
  let _walls = Wall.walls () in
  let _projectiles = Projectile.projectiles () in
  let player = Player.players () in
  let overlay = Overlay.overlay () in
  let global = Global.{ window; ctx; font; player; overlay; niveau = 1; time = 0.0; waiting = 1; } in
  Global.set global;
  Gfx.main_loop update (fun v -> if v = 0 then loss () else win () )


