{pkgs, ...}: {
  programs.bash = {
    enable = true;
    initExtra = builtins.readFile ./dotfiles/bash/.bashrc;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 100000;
      share = true;
      ignoreAllDups = true;
    };

    shellAliases = {
      ls = "eza --icons=auto -1 --colour=auto";
      ll = "eza --icons=auto -1 --colour=auto -lgh";
      lt = "eza --icons=auto -1 --colour=auto --tree -lgh";
      nos = "nh os switch";
      not = "nh os test";
      nob = "nh os build";
      hl = "rg --passthrough";
    };

    initContent = ''
      alias -g C='| xclip -sel clip'
      alias -g E='2>&1'

      ### Error redirect abbreviation
      function _abbrev_redirect() {
        case "$LBUFFER" in
          *" 2null")
            LBUFFER="''${LBUFFER%2null}2>/dev/null"
            ;;
          *" 2clip")
            LBUFFER="''${LBUFFER%2clip}2>&1 | xclip -sel clip"
            ;;
        esac;
        zle self-insert
      }
      zle -N _abbrev_redirect
      bindkey ' ' _abbrev_redirect

      ### Copy to file shortcut `alt+f`
      function _append_c2f() {
        BUFFER="$BUFFER | c2f"
        CURSOR=$#BUFFER
      }
      zle -N _append_c2f
      bindkey '^[f' _append_c2f

      ### Copy git repo to file shortcut `alt+F`
      function _append_g2f() {
        BUFFER="g2f"
      }
      zle -N _append_g2f
      bindkey '^[F' _append_g2f

      c2f() {
        local filename="''${1:-attachment.txt}"
        local filepath="/dev/shm/$filename"

        cat > "$filepath"
        printf "file://%s\r\n" "$filepath" | xclip -selection clipboard -t text/uri-list
      }

      g2f() {
        git ls-files | xargs -n1 sh -c 'echo "FILEMARKER $1"; cat "$1"' _ | \
        awk '
        /^FILEMARKER/ {
            if (in_file) print "```\n"   # Close previous file block if open
            sub(/^FILEMARKER/, "")
            print "# " $0 "\n```"
            in_file = 1
            next
        }
        { print }
        END { if (in_file) print "```" }
        '
      }

      # 1. Interactive Grid Menu & Case-Insensitive Completion
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      bindkey '^[[Z' reverse-menu-complete # Shift-Tab cycles backward

      # 2. Wakatime Hook adapted for Zsh Engine
      GLOBAL_WAKATIME_PROJECT="Terminal"

      autoload -Uz add-zsh-hook
      deploy_wakatime() {
        # Safely capture the last running command name without numbers
        local last_cmd=$(fc -ln -1 | awk '{print $1}')
        (wakatime-cli --write \
          --plugin "zsh-wakatime/1.0.0" \
          --entity-type file \
          --entity "''${last_cmd:-shell}" \
          --project "$GLOBAL_WAKATIME_PROJECT" >/dev/null 2>&1 &)
      }
      add-zsh-hook precmd deploy_wakatime

      # 3. Fastfetch & Quote Engine (Only outside Tmux)
      if [[ -z "$TMUX" ]]; then
        ${pkgs.fastfetch}/bin/fastfetch
        print ""
        awk '/^# /{h1=$0; sub(/^#+ +/, "", h1)} /^## /{h2=$0; sub(/^##+ +/, "", h2)} /^>/{sub(/^>+ +/, ""); quote=quote $0 "\n"; next} /^—/{if(quote){sub(/^— +/, ""); printf "\033[3m%s—%s %s %s\033[0m\0", quote, h1, h2, $0; quote=""}}' ~/notes/quotes.norg | shuf -n 1 -z
      fi
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    #presets = ["catppuccin-powerline"];
    settings = builtins.fromTOML (builtins.readFile ./dotfiles/bash/starship.toml);
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
