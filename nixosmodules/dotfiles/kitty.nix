{ config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        settings = {
            font_family = "GeistMono Nerd Font Mono Medium";

            # Edited Theme from diinki https://github.com/diinki/diinki-retrofuture/tree/main/config/kitty
            # Make the cursor shape a beam

            shell = "zsh --login";
            shell_integration = "no-cursor";
            cursor_shape = "beam";
            cursor_trail = "1";
            cursor_trail_decay = "0 0.3";
            cursor_trail_start_threshold = "0";

            # Padding
            window_padding_width = 7;
            window_padding_height = 10;

            # Scroll back up to 3000 lines.
            scrollback_lines = 5000;

            #Default font size.
            font_size = 13;

            # Background opacity, set to 0 if you want blur/transparency.
            # Blur works with hyprland, or sway-fx as a drop-in replacement for sway.
            background_opacity = "0.9";
            background_blur = 20;
            
            extraConfig = "
                map ctrl+shift+plus change_font_size all +1.0
                map ctrl+shift+minus change_font_size all -1.0
                cursor               #AC82E9

                active_border_color #3a2855
                inactive_border_color #353239

                selection_background #d8cab8
                selection_foreground #141216

                background           #141216
                foreground           #d8cab8

                color0               #4f3767
                color8               #92fcfa
                color1               #fc4649
                color9               #fc4649
                color2               #c4e881
                color10              #c4e881
                color3               #AC82E9
                color11              #AC82E9
                color4               #7b91fc
                color12              #7b91fc
                color5               #f3fc7b
                color13              #f3fc7b
                color6               #8F56E1
                color14              #8F56E1
                color7               #fc92fc
                color15              #d8cab8
            ";
        };
    };
    home.stateVersion = "24.11";
}