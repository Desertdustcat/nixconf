{ config, lib, pkgs, ... }:

{
    
    programs.starship = {
        enable = true;
        settings = {
            format = "[](#3B1A80)$os$username[](bg:#3D3287 fg:#3B1A80)$directory[](fg:#3D3287 bg:#6D3491)$git_branch$git_status[](fg:#6D3491 bg:#983FD4)$c$elixir$elm$golang$gradle$haskell$java$julia$maven$nodejs$bun$nim$rust$scala[](fg:#983FD4 bg:#9A5EE1)$docker_context[](fg:#9A5EE1 bg:#AC82E9)$time[ ](fg:#AC82E9)";

            # Disable the blank line at the start of the prompt
            # add_newline = false

            # You can also replace your username with a neat symbol like   or disable this
            # and use the os module below
            username = {
                disabled = false;
                format = "[$user ]($style)";
                show_always = true;
                style_root = "bg:#3B1A80";
                style_user = "bg:#3B1A80";
            };
            # An alternative to the username module which displays a symbol that
            # represents the current operating system
            os = {
                disabled = true; # Disabled by default
                style = "bg:#3B1A80"; 
            };

            directory = {
                format = "[ $path ]($style)";
                style = "bg:#3D3287";
                truncation_length = 3;
                truncation_symbol = "…/";
            };

            # Here is how you can shorten some long paths by text replacement
            # similar to mapped_locations in Oh My Posh:
            directory.substitutions = {
                "Documents" = "󰈙 ";
                "Downloads" = " ";
                "Music" = " ";
                "Pictures" = " ";
                # Keep in mind that the order matters. For example:
                # "Important Documents" = " 󰈙 "
                # will not be replaced, because "Documents" was already substituted before.
                # So either put "Important Documents" before "Documents" or use the substituted version:
                # "Important 󰈙 " = " 󰈙 "
            };

            c = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };

            cpp = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };
            
            docker_context = {
                format = "[ $symbol $context ]($style)";
                style = "bg:#9A5EE1";
                symbol = " ";
            };
            
            elixir = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };

            elm = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };

            git_branch = {
                format = "[ $symbol $branch ]($style)";
                style = "bg:#6D3491";
                symbol = "";
            };
            
            git_status = {
                format = "[$all_status$ahead_behind ]($style)";
                style = "bg:#6D3491";
            };
            
            golang = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };

            gradle = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
            };
            
            haskell = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };

            java = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };
            
            julia = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };
            
            maven = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
            };
            
            nodejs = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = "";
            };
            
            bun = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = "";
            };

            nim = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = "󰆥 ";
            };
            
            rust = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = "";
            };
            
            scala = {
                format = "[ $symbol ($version) ]($style)";
                style = "bg:#983FD4";
                symbol = " ";
            };
            time = {
                disabled = false ;
                format = "[ ♥ $time ]($style)";
                style = "bg:#AC82E9"; 
                time_format = "%R"; # Hour:Minute Format
            };
            
        };
    };

}