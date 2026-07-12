{...}: {
  enable = true;
  extraConfig = builtins.readFile ./dotfiles/bash/.bashrc;
}
