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
      ls = "eza --icons=always -1 --colour=always";
      ll = "eza --icons=always -1 --colour=always --tree -lgh";
      nos = "nh os switch";
      not = "nh os test";
    };

    initContent = ''
      alias -g G='| rg -i'
      alias -g C='| xclip -sel clip'

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
