local wezterm = require("wezterm")
local act = wezterm.action

return {
	color_scheme = "Sakura",
	font = wezterm.font_with_fallback({
		-- F0001 -> text?
		{ family = "chiikawa", assume_emoji_presentation = false },
		{ family = "chiikawa", assume_emoji_presentation = true },
	}),
	font_size = 13.0,
  allow_square_glyphs_to_overflow_width = "Never",
  window_background_opacity = 0.85,
}
