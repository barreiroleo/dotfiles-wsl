return {
    tab_bar = {
        background = '#0b0022',
        active_tab = {
            bg_color = '#2b2042',
            fg_color = '#c0c0c0',
            underline = 'Single', -- ["None"], "Single", "Double"
        },
        inactive_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080',
            intensity = 'Half', -- "Half", ["Normal"],  "Bold"
            italic = true,
        },
        inactive_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true,
        },
        new_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080',
        },
        new_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
        },
    },
    compose_cursor = 'orange' -- Cursor color when leader is active
}
