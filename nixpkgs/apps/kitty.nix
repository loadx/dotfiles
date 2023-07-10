{ lib }:

{
	kitty = {
    enable = true;
    extraConfig = ''
	font_size 13.5
  font_family "SauceCodePro Nerd Font Mono Regular"
	cursor #cccccc
	cursor_shape block
	cursor_stop_blinking_after 5.0
	url_color #0087bd
	url_style curly
	open_url_with default
	detect_urls yes
	copy_on_select clipboard
	mouse_map middle release ungrabbed paste_from_selection
	mouse_map left press ungrabbed mouse_selection normal
	mouse_map alt+left press ungrabbed mouse_selection rectangle
	mouse_map left doublepress ungrabbed mouse_selection word
	mouse_map left triplepress ungrabbed mouse_selection line
	mouse_map shift+left press ungrabbed,grabbed mouse_selection normal
	enable_audio_bell no
	draw_minimal_borders yes
	window_margin_width 0
	window_padding_width 1

	# Base16 Harmonic16 Dark - kitty color config
	# Scheme by Jannik Siebert (https://github.com/janniks)
	background #0b1c2c
	foreground #cbd6e2
	selection_background #cbd6e2
	selection_foreground #0b1c2c
	url_color #aabcce
	cursor #cbd6e2
	active_border_color #627e99
	inactive_border_color #223b54
	active_tab_background #0b1c2c
	active_tab_foreground #cbd6e2
	inactive_tab_background #223b54
	inactive_tab_foreground #aabcce
	tab_bar_background #223b54

	# normal
	color0 #0b1c2c
	color1 #bf8b56
	color2 #56bf8b
	color3 #8bbf56
	color4 #8b56bf
	color5 #bf568b
	color6 #568bbf
	color7 #cbd6e2

	# bright
	color8 #627e99
	color9 #bfbf56
	color10 #223b54
	color11 #405c79
	color12 #aabcce
	color13 #e5ebf1
	color14 #bf5656
	color15 #f7f9fb

  background_opacity .97
	dynamic_background_opacity no
  '';
  };
}