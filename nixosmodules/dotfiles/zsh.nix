{ config, lib, pkgs, ... }:    
    
    
{    
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  interactiveShellInit = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      
      zstyle ':fzf-tab:*' fzf-flags '--height=70%' '--layout=reverse' '--border'
      zstyle ':fzf-tab:complete:*:*' fzf-preview '
        TARGET=$realpath
        if [ -z "$TARGET" ]; then
          TARGET=$word
        fi
        if [ -d "$TARGET" ]; then
          eza --tree --color=always -L 2 "$TARGET"
        elif [ -f "$TARGET" ]; then
          if file --mime-type "$TARGET" | grep -q image/; then
          kitten icat --clear --transfer-mode=memory --stdin=no --place "''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}@0x0" "$TARGET"            else
            bat --color=always --style=numbers --line-range=:1000 "$TARGET"
          fi
        elif command -v "$TARGET" >/dev/null 2>&1 || type "$TARGET" >/dev/null 2>&1; then
          man -P cat "$TARGET" 2>/dev/null | bat -l man --color=always --plain || type "$TARGET"
        else
          echo "$TARGET"
        fi
      '
      _fzf_tab_cleaner() {
        zle fzf-tab-complete
        kitten icat --clear >/dev/tty 2>/dev/null
        zle redisplay
      }
      zle -N _fzf_tab_cleaner
      bindkey "^I" _fzf_tab_cleaner
  '';
  #  shellAliases = {
  #    ll = "ls -l";
  #    edit = "sudo -e";
  #    update = "sudo nixos-rebuild switch";
  #  };
  };
}