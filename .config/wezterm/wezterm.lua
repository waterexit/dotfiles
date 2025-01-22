local wezterm = require("wezterm")
local act = wezterm.action

return {
    --   color_scheme = "Sakura",
    font = wezterm.font_with_fallback({
        -- F0001 -> text?
        { family = "chiikawa", assume_emoji_presentation = false },
        { family = "chiikawa", assume_emoji_presentation = true },
    }),
    font_size = 13.0,
    allow_square_glyphs_to_overflow_width = "Never",
    window_background_opacity = 0.85,
    use_ime = true,
    leader = { key = "t", mods = "ALT", timeout_milliseconds = 1000 },
    keys = {
        { key = "w", mods = "ALT", action = act.ActivateKeyTable { name = 'alt_w_leader', one_shot = true } },
        { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "x", mods = "LEADER", action = act.CloseCurrentTab { confirm = true } },
        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

        { key = "x", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
        { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
    },
    key_tables = {
        alt_w_leader = {
            { key = "v", mods = "NONE", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
            { key = "s", mods = "NONE", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
            { key = "q", mods = "NONE", action = act.CloseCurrentPane { confirm = true } },

            { key = "h", mods = "NONE", action = act.ActivatePaneDirection("Left") },
            { key = "l", mods = "NONE", action = act.ActivatePaneDirection("Right") },
            { key = "k", mods = "NONE", action = act.ActivatePaneDirection("Up") },
            { key = "j", mods = "NONE", action = act.ActivatePaneDirection("Down") },

            { key = "H", mods = "NONE", action = act.AdjustPaneSize { "Left", 10 } },
            { key = "L", mods = "NONE", action = act.AdjustPaneSize { "Right", 10 } },
            { key = "K", mods = "NONE", action = act.AdjustPaneSize { "Up", 5 } },
            { key = "J", mods = "NONE", action = act.AdjustPaneSize { "Down", 5 } },
        }
    }
}
